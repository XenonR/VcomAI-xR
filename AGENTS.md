# Contributor instructions

This repository contains the Vcom AI SQF mission distribution in
`VcomAI340.Stratis`. Read `README.md` for module ownership, startup, interfaces,
and the Arma smoke-test checklist before changing behavior.

## Design principles

- **YAGNI (You Aren't Gonna Need It):** implement current requirements. Add an
  abstraction only when existing code or an accepted requirement needs it.
- **KISS (Keep It Simple):** prefer small SQF functions, explicit registration,
  straightforward control flow, and minimal dependencies. Extend the existing
  feature modules and feature settings before introducing new infrastructure.
- Keep each feature in its owning module. Core owns startup and lifecycle;
  Settings owns defaults and skill helpers. Feature CBA definitions belong in
  that feature's `CBASettings.inc.sqf`.
- Preserve `VCM_fnc_*` public names, legacy configuration variables, callback
  argument conventions, and the external userconfig location unless a change
  explicitly requires breaking compatibility.
- Preserve FSM transitions, priorities, cooldowns, and AI tuning during a
  structural refactor. Put reusable actions in SQF helpers instead of copying
  code between FSM fields.
- Keep experimental scripts in `Vcom/Legacy`; they are inactive and must not be
  automatically registered or loaded.

## SQF implementation

- Document parameters, types, return values, locality, and `call`/`spawn` usage
  on new or substantially changed functions. Use explicit `params` and private
  variables; do not depend on a caller's local variables in extracted helpers.
- Register functions in the owning module's `cfgFunctions.hpp`. Add a new
  module through an explicit include in the central registration file.
- Use exact filename casing for registration, includes, and mission paths.
- Perform AI mutations on the appropriate owner. Keep handler IDs and local
  lifecycle records local; publish configuration only when its existing API
  requires synchronization.
- Make repeated startup and unit setup safe. Remove only Vcom-owned event
  handlers; guard list deletion when an entry may already be absent.
- Use `call` for immediate work and `spawn` for functions that suspend. Preserve
  legacy scheduled behavior at existing call sites when extracting code.
- Make long-running behavior stop when ownership or eligibility ends. Release
  movement disabled by Vcom when cancelling traversal on a local unit.

## Verification

Run these from the repository root after changes to module wiring or behavior:

```powershell
python tools/validate_modules.py
python -m unittest discover -s tools -p "test_*.py" -v
git diff --check
```

The compatibility fixture protects the original 70 public exports, three FSMs'
states/transitions/timed conditions, and 74 unique CBA definitions. Update it
only for an intentional, reviewed compatibility or tuning change; never refresh
it simply to make a failing check pass. It records the pre-refactor interface,
not every detail of the SQF implementation.

Static checks do not execute SQF or prove gameplay correctness. Use the Arma
smoke tests in `README.md` for runtime changes, especially locality, JIP,
respawn, and optional integrations. Report which checks ran and which require
an Arma environment. Keep validation dependency-free unless a concrete need
justifies adding a tool.

## Staging and Conventional Commits

Develop changes in logical stages: module relocation, shared actions, defect
fixes, and documentation/validation. Keep each stage reviewable.

When preparing requested commits, stage deliberately: include only files and
hunks belonging to that logical change, then review `git diff --cached`.
Avoid mixing unrelated changes or generated caches into a commit.

Use Conventional Commits: `<type>(<scope>): <description>`. A scope is optional
for repository-wide changes. Use `refactor`, `fix`, `docs`, or `test` as
appropriate, with a concise description of the resulting change. Examples:

- `refactor(movement): extract unit setup`
- `fix(settings): prevent duplicate registration`
- `docs: add contributor guidelines`

Create commits only when requested. A request to update these guidelines alone
does not request staging or committing the current working tree.
