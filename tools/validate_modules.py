"""Check Vcom's module wiring and compatibility without running the Arma engine."""

from __future__ import annotations

import argparse
from dataclasses import dataclass, field
import hashlib
import json
from pathlib import Path
import re
import sys


ROOT = Path(__file__).resolve().parents[1]
MISSION_NAME = "VcomAI340.Stratis"
TOKEN = re.compile(
    r'//[^\n]*|/\*.*?\*/|"(?:[^" ]| |"")*"|\'(?:[^\']|\'\')*\'|\w+|[^\s]',
    re.DOTALL,
)
INCLUDE = re.compile(r'^\s*#include\s+"([^"]+)"\s*$', re.MULTILINE)
FSM_FIELDS = re.compile(
    r'/\*%FSM<(STATEINIT|ACTION|CONDITION|STATEPRECONDITION|CONDPRECONDITION)""">\*/'
    r'(.*?)/\*%FSM</\1""">\*/', re.DOTALL,
)


class ValidationError(ValueError):
    pass


def tokens(text: str) -> list[str]:
    result = []
    for match in TOKEN.finditer(text):
        token = match.group()
        if token.startswith(("//", "/*")):
            continue
        if token in ('"', "'"):
            raise ValidationError("unterminated string")
        result.append(token)
    return result


def balanced(text: str, label: str) -> None:
    stack = []
    for token in tokens(text):
        if token in ("(", "[", "{"):
            stack.append(token)
        elif token in (")", "]", "}"):
            if not stack or stack.pop() != {")": "(", "]": "[", "}": "{"}[token]:
                raise ValidationError(f"{label}: unbalanced {token}")
    if stack:
        raise ValidationError(f"{label}: unclosed {stack[-1]}")


def resolve_path(base: Path, relative: str, boundary: Path) -> Path:
    """Require existing paths with exact spelling, including on Windows."""
    current = base.resolve()
    for part in relative.replace("\\", "/").split("/"):
        if part in ("", "."):
            continue
        if part == "..":
            current = current.parent
        else:
            if not current.is_dir():
                raise ValidationError(f"missing directory: {current}")
            matches = [p for p in current.iterdir() if p.name == part]
            if not matches:
                raise ValidationError(f"missing path or incorrect case: {current / part}")
            current = matches[0]
        if not current.resolve().is_relative_to(boundary.resolve()):
            raise ValidationError(f"path escapes mission: {relative}")
    return current


def expand(path: Path, mission: Path, chain: tuple[Path, ...] = ()) -> str:
    path = path.resolve()
    if path in chain:
        raise ValidationError(f"include cycle: {path}")
    text = path.read_text(encoding="utf-8-sig")

    def include(match: re.Match[str]) -> str:
        target = resolve_path(path.parent, match[1], mission)
        return expand(target, mission, chain + (path,))

    return INCLUDE.sub(include, text)


@dataclass
class ConfigClass:
    name: str
    properties: dict[str, str] = field(default_factory=dict)
    children: list[ConfigClass] = field(default_factory=list)


def config_classes(text: str) -> list[ConfigClass]:
    stream = tokens(text)

    def block(index: int, nested: bool = False) -> tuple[list[ConfigClass], dict[str, str], int]:
        classes = []
        properties = {}
        while index < len(stream):
            token = stream[index]
            if token == "}":
                if not nested:
                    raise ValidationError("unexpected config closing brace")
                return classes, properties, index + 1
            if token == "class":
                name = stream[index + 1]
                index += 2
                if stream[index] == ";":
                    classes.append(ConfigClass(name))
                    index += 1
                    continue
                if stream[index] != "{":
                    raise ValidationError(f"unsupported config declaration: {name}")
                children, props, index = block(index + 1, True)
                classes.append(ConfigClass(name, props, children))
            elif index + 2 < len(stream) and stream[index + 1] == "=":
                properties[token] = stream[index + 2].strip('"')
                index += 3
            else:
                index += 1
        if nested:
            raise ValidationError("unclosed config class")
        return classes, properties, index

    return block(0)[0]


def registrations(text: str, mission: Path) -> dict[str, Path]:
    roots = config_classes(text)
    if len(roots) != 1 or roots[0].properties.get("tag") != "VCM":
        raise ValidationError("expected one VCOM registration with tag VCM")
    exports = {}
    category_names = set()
    for category in roots[0].children:
        if category.name.lower() in category_names:
            raise ValidationError(f"duplicate function category: {category.name}")
        category_names.add(category.name.lower())
        directory = category.properties.get("file")
        if not directory:
            raise ValidationError(f"missing function directory: {category.name}")
        for function in category.children:
            name = function.name.lower()
            if name in exports:
                raise ValidationError(f"duplicate export: VCM_fnc_{function.name}")
            ext = function.properties.get("ext", ".sqf")
            exports[name] = resolve_path(mission, f"{directory}/fn_{function.name}{ext}", mission)
    return exports


def setting_hashes(text: str) -> dict[str, str]:
    stream = tokens(text)
    result = {}
    for index, token in enumerate(stream):
        if token != "[" or index + 4 >= len(stream):
            continue
        if stream[index + 2] != "," or stream[index + 3] not in (
            '"CHECKBOX"', '"SLIDER"', '"LIST"', '"EDITBOX"', '"COLOR"',
        ):
            continue
        depth = 1
        end = index + 1
        while depth and end < len(stream):
            depth += (stream[end] == "[") - (stream[end] == "]")
            end += 1
        if stream[end:end + 3] != ["call", "CBA_Settings_fnc_init", ";"]:
            continue
        key = stream[index + 1].strip('"')
        if key.lower() in {k.lower() for k in result}:
            raise ValidationError(f"duplicate CBA setting: {key}")
        result[key] = hashlib.sha256("\0".join(stream[index:end + 3]).encode()).hexdigest()
    return result


def fsm_structure(text: str) -> dict[str, list[str]]:
    return {
        "states": re.findall(r'/\*%FSM<STATE "([^"]+)">\*/', text),
        "targets": re.findall(r'\bto\s*=\s*"([^"]+)"', text),
        "priorities": re.findall(r'\bpriority\s*=\s*([\d.]+)', text),
        "timed_conditions": [s for s in re.findall(
            r'condition\s*=\s*/\*%FSM<CONDITION""">\*/(.*?)/\*%FSM</CONDITION""">\*/',
            text, re.DOTALL,
        ) if re.search(r'\btime\b|diag_tick', s, re.IGNORECASE)],
    }


def decode_fsm(text: str) -> list[str]:
    return ["\n".join(t[1:-1].replace('""', '"') for t in tokens(m[2]) if t.startswith('"'))
            for m in FSM_FIELDS.finditer(text)]


def validate(root: Path = ROOT) -> dict[str, int]:
    mission = root / MISSION_NAME
    vcom = mission / "Vcom"
    baseline = json.loads((root / "tools/compatibility.json").read_text())
    # Validate includes in the real mission entry point as well as the registration aggregator.
    balanced(expand(mission / "description.ext", mission), "description.ext")
    exports = registrations(expand(vcom / "cfgFunctions.hpp", mission), mission)
    missing = {n.lower() for n in baseline["legacy_exports"]} - exports.keys()
    if missing:
        raise ValidationError(f"missing legacy exports: {sorted(missing)}")

    active_paths = list((vcom / "Modules").rglob("*.sqf")) + [
        mission / "init.sqf", vcom / "Functions/VcomAI_DefaultSettings.sqf",
        mission / "THE FOLDER IN THIS FOLDER GOES INTO YOUR ROOT ARMA 3 FOLDER/userconfig/VCOM_AI/AISettingsV3.hpp",
    ]
    referenced = set()
    for path in active_paths:
        source = expand(path, mission)
        balanced(source, str(path.relative_to(root)))
        referenced.update(re.findall(r'\bVCM_fnc_(\w+)', source, re.IGNORECASE))
        for match in re.finditer(r'"([^"\n]+\.(?:sqf|hpp|fsm))"', source, re.IGNORECASE):
            if match[1].lower().startswith("vcom\\"):
                resolve_path(mission, match[1], mission)
        if path.name.startswith("fn_") and path not in exports.values():
            raise ValidationError(f"unregistered active function: {path}")

    fsms = {name: path for name, path in exports.items() if path.suffix == ".fsm"}
    for name, path in fsms.items():
        source = path.read_text()
        structure = fsm_structure(source)
        invalid = set(structure["targets"]) - set(structure["states"])
        if invalid:
            raise ValidationError(f"{path.name}: unknown FSM targets {sorted(invalid)}")
        original = next((s for n, s in baseline["fsms"].items() if n.lower() == name), None)
        if original is not None and structure != original:
            raise ValidationError(f"{path.name}: FSM states, transitions, priorities or timed conditions changed")
        balanced(source, path.name)
        for script in decode_fsm(source):
            balanced(script, f"{path.name} SQF field")
            referenced.update(re.findall(r'\bVCM_fnc_(\w+)', script, re.IGNORECASE))
    unresolved = {n.lower() for n in referenced} - exports.keys()
    if unresolved:
        raise ValidationError(f"unresolved Vcom references: {sorted(unresolved)}")
    cba = setting_hashes(expand(vcom / "Modules/Settings/Functions/fn_CBASettings.sqf", mission))
    if cba != baseline["cba_settings"]:
        raise ValidationError("CBA setting IDs, defaults or callbacks changed")
    return {"exports": len(exports), "legacy_exports": len(baseline["legacy_exports"]),
            "modules": len(list((vcom / "Modules").glob("*/cfgFunctions.hpp"))),
            "fsms": len(fsms), "cba_settings": len(cba)}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT, help="repository root")
    args = parser.parse_args()
    try:
        counts = validate(args.root.resolve())
    except (ValidationError, OSError, IndexError, KeyError) as error:
        print(f"FAIL: {error}", file=sys.stderr)
        return 1
    print("PASS: " + ", ".join(f"{value} {key}" for key, value in counts.items()))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
