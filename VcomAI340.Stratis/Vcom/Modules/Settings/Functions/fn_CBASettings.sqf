/* Parameters: none. Returns: nil. Call once per machine; registration waits for settings. */
if (missionNamespace getVariable ["VCM_CBASettingsRegistered", false]) exitWith {};
if (missionNamespace getVariable ["VCM_CBASettingsPending", false]) exitWith {};
missionNamespace setVariable ["VCM_CBASettingsPending", true];
[] spawn {
    sleep 1;
    waitUntil {sleep 0.1; !(isNil "CBAACT") && {!(isNil "VCM_USECBASETTINGS")}};
    if (CBAACT && {VCM_USECBASETTINGS}) then {
        missionNamespace setVariable ["VCM_CBASettingsRegistered", true];
        #include "..\..\Core\CBASettings.inc.sqf"
        #include "..\..\Settings\CBASettings.inc.sqf"
        #include "..\..\Debug\CBASettings.inc.sqf"
        #include "..\..\Artillery\CBASettings.inc.sqf"
        #include "..\..\Medical\CBASettings.inc.sqf"
        #include "..\..\Vehicles\CBASettings.inc.sqf"
        #include "..\..\Movement\CBASettings.inc.sqf"
        #include "..\..\Combat\CBASettings.inc.sqf"
        #include "..\..\Perception\CBASettings.inc.sqf"
        #include "..\..\Logistics\CBASettings.inc.sqf"
        #include "..\..\EnhancedMovement\CBASettings.inc.sqf"
        diag_log "VCOM: Loaded CBA settings";
    };
    missionNamespace setVariable ["VCM_CBASettingsPending", false];
};
