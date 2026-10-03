/* Parameters: none. Returns: nil. Spawn once on every participating machine. */
if (missionNamespace getVariable ["VCM_InitializationStarted", false]) exitWith {};
missionNamespace setVariable ["VCM_InitializationStarted", true];
VCM_PublicScript = compileFinal "_this call VCM_fnc_ApplySettings;";
VCM_ServerAsk = compileFinal "_this spawn {params ['_name', '_owner']; waitUntil {sleep 0.1; !(isNil _name)}; _owner publicVariableClient _name;};";

[] spawn {
    CBAACT = isClass (configFile >> "CfgPatches" >> "cba_main");
    VCOM_EM_ENABLED = !(isNil "EM_debug");
    if (isServer) then {
        private _settingsFile = "Vcom\Functions\VcomAI_DefaultSettings.sqf";
        if (isFilePatchingEnabled && {!((loadFile "\userconfig\VCOM_AI\AISettingsV3.hpp") isEqualTo "")}) then {
            _settingsFile = "\userconfig\VCOM_AI\AISettingsV3.hpp";
        };
        [] call compile preprocessFileLineNumbers _settingsFile;
        [Vcm_Settings] call VCM_fnc_ApplySettings;
        [Vcm_Settings] remoteExec ["VCM_PublicScript", 0, false];
    } else {
        ["Vcm_Settings", clientOwner] remoteExec ["VCM_ServerAsk", 2, false];
        waitUntil {sleep 0.1; !(isNil "Vcm_Settings")};
        [Vcm_Settings] call VCM_fnc_ApplySettings;
    };
    waitUntil {sleep 0.1; !(isNil "VCM_AIMagLimit")};
    // Only force medical OFF for the legacy ACE integration; respect configured false.
    if (!(isNil "ACE_Medical_enableFor") && {ACE_Medical_enableFor isEqualTo 1}) then {VCM_MEDICALACTIVE = false;};
    [] call VCM_fnc_CBASettings;

    Vcm_PMN = compileFinal "(_this select 0) playMoveNow (_this select 1);";
    Vcm_SM = compileFinal "(_this select 0) switchMove (_this select 1);";
    Vcm_PAN = compileFinal "(_this select 0) playActionNow (_this select 1);";
    VCOM_MINEARRAY = [];
    VCM_CoverQueue = [];
    ["VCMMINEMONITOR", "onEachFrame", {[] call VCM_fnc_MineMonitor}] call BIS_fnc_addStackedEventHandler;

    sleep 2;
    if (hasInterface) then {
        [] spawn {
            waitUntil {sleep 0.1; !isNull player};
            [player] call VCM_fnc_InitPlayer;
            if (Vcm_PlayerAISkills) then {[] spawn VCM_fnc_PLAYERSQUAD;};
        };
    };
    [] spawn VCM_fnc_AIDRIVEBEHAVIOR;
    [] spawn VCM_fnc_Scheduler;
    missionNamespace setVariable ["VCM_Initialized", true];
};
