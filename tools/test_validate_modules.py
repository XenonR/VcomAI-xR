"""Exercise module validation against broken wiring in isolated temporary copies."""

from pathlib import Path
import shutil
import tempfile
import unittest

from validate_modules import MISSION_NAME, ROOT, ValidationError, validate


class ModuleValidationTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="vcom-validation-")
        self.root = Path(self.temporary.name).resolve()
        assert self.root.is_relative_to(Path(tempfile.gettempdir()).resolve())
        shutil.copytree(ROOT / MISSION_NAME, self.root / MISSION_NAME)
        (self.root / "tools").mkdir()
        shutil.copyfile(ROOT / "tools/compatibility.json", self.root / "tools/compatibility.json")
        self.vcom = self.root / MISSION_NAME / "Vcom"

    def tearDown(self):
        self.temporary.cleanup()

    def edit(self, relative, before, after):
        path = self.vcom / relative
        text = path.read_text()
        self.assertIn(before, text)
        path.write_text(text.replace(before, after, 1))

    def test_current_modules_preserve_compatibility(self):
        counts = validate(self.root)
        self.assertEqual(counts["legacy_exports"], 70)
        self.assertEqual(counts["fsms"], 3)
        self.assertEqual(counts["cba_settings"], 74)

    def test_missing_include(self):
        self.edit("cfgFunctions.hpp", "Modules\\Core\\cfgFunctions.hpp", "Modules\\Missing\\cfgFunctions.hpp")
        with self.assertRaisesRegex(ValidationError, "missing path"):
            validate(self.root)

    def test_include_cycle(self):
        path = self.vcom / "Modules/Core/cfgFunctions.hpp"
        path.write_text('#include "cfgFunctions.hpp"\n')
        with self.assertRaisesRegex(ValidationError, "include cycle"):
            validate(self.root)

    def test_incorrect_path_case(self):
        self.edit("cfgFunctions.hpp", "Modules\\Core\\cfgFunctions.hpp", "Modules\\core\\cfgFunctions.hpp")
        with self.assertRaisesRegex(ValidationError, "incorrect case"):
            validate(self.root)

    def test_duplicate_export(self):
        self.edit("Modules/Core/cfgFunctions.hpp", "class VcomInit {};", "class VcomInit {};\n    class VcomInit {};")
        with self.assertRaisesRegex(ValidationError, "duplicate export"):
            validate(self.root)

    def test_removed_legacy_export(self):
        self.edit("Modules/Core/cfgFunctions.hpp", "class Classname {};", "")
        with self.assertRaisesRegex(ValidationError, "missing legacy exports"):
            validate(self.root)

    def test_unresolved_function(self):
        path = self.vcom / "Modules/Core/Functions/fn_InitUnit.sqf"
        path.write_text(path.read_text() + "\n[] call VCM_fnc_Missing;\n")
        with self.assertRaisesRegex(ValidationError, "unresolved Vcom references"):
            validate(self.root)

    def test_invalid_fsm_target(self):
        self.edit("Modules/Core/FSMs/fn_SQUADBEH.fsm", 'to="Exit_FSM"', 'to="Missing_State"')
        with self.assertRaisesRegex(ValidationError, "unknown FSM targets"):
            validate(self.root)

    def test_changed_fsm_timing(self):
        self.edit("Modules/Vehicles/FSMs/fn_AIDRIVEBEHAVIOR.fsm", "time > _t + VCM_DrivingDelay", "time > _t + 100")
        with self.assertRaisesRegex(ValidationError, "timed conditions changed"):
            validate(self.root)

    def test_duplicate_cba_setting(self):
        path = self.vcom / "Modules/Core/CBASettings.inc.sqf"
        path.write_text(path.read_text() + "\n" + path.read_text())
        with self.assertRaisesRegex(ValidationError, "duplicate CBA setting"):
            validate(self.root)

    def test_changed_cba_default(self):
        self.edit("Modules/Core/CBASettings.inc.sqf", "true, // data for this setting:", "false, // data for this setting:")
        with self.assertRaisesRegex(ValidationError, "CBA setting IDs, defaults or callbacks changed"):
            validate(self.root)

    def test_unbalanced_sqf(self):
        path = self.vcom / "Modules/Core/Functions/fn_InitUnit.sqf"
        path.write_text(path.read_text() + "\n[1, 2;\n")
        with self.assertRaisesRegex(ValidationError, "unclosed"):
            validate(self.root)


if __name__ == "__main__":
    unittest.main()
