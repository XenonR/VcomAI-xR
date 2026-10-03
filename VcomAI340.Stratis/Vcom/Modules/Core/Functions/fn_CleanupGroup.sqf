/*
    Parameters: [group (GROUP), previously tracked units (ARRAY)]. Returns: nil.
    Call on the machine running the exiting FSM, even if ownership changed.
*/
params ["_group", ["_trackedUnits", []]];
{
    [_x, _group] call VCM_fnc_CleanupUnit;
} forEach (_trackedUnits + (units _group));
private _index = VcmAI_ActiveList find _group;
if (_index >= 0) then {VcmAI_ActiveList deleteAt _index;};
_group setVariable ["VCOM_FSMH", nil];
if (VCM_Debug) then {diag_log format ["%1: EXITED VCOM SCRIPTS", _group];};
