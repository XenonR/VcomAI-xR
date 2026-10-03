/*
    Parameters: [settings callback (CODE)]. Returns: nil. Call on each machine.
    Keep the legacy VCM_PublicScript interface, applying received settings once.
*/
params ["_settings"];
if (missionNamespace getVariable ["VCM_SettingsApplied", false]) exitWith {};
missionNamespace setVariable ["VCM_SettingsApplied", true];
[] call _settings;
