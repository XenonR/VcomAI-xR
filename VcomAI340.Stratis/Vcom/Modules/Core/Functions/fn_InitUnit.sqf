/*
    Parameters: [unit (OBJECT), owning group (GROUP)]. Returns: nil.
    Call on the group owner; handlers and ownership records remain local.
*/
params ["_unit", "_group"];
if (isNull _unit || {isPlayer _unit} || {!local _unit} || {!local _group}) exitWith {};

private _owner = _unit getVariable ["VCM_HandlerGroup", grpNull];
if (_owner isEqualTo _group && {count (_unit getVariable ["VCM_EventHandlers", []]) > 0}) exitWith {};
[_unit, _owner] call VCM_fnc_CleanupUnit;
// The movement marker is shared so the new owner can recover an interrupted climb.
if (_unit getVariable ["VCM_EMMoving", false]) then {
    _unit enableAI "MOVE";
    _unit setVariable ["VCM_EMMoving", false, true];
};

private _handlers = [];
_handlers pushBack ["Killed", _unit addEventHandler ["Killed", {_this spawn VCM_fnc_ClstWarn;}]];
_handlers pushBack ["Fired", _unit addEventHandler ["Fired", {_this call VCM_fnc_HearingAids;}]];
_handlers pushBack ["Hit", _unit addEventHandler ["Hit", {_this call VCM_fnc_AIHIT;}]];
_handlers pushBack ["PathCalculated", _unit addEventHandler ["PathCalculated", {
    params ["_unit", "_path"];
    _unit setVariable ["VCM_MVWP", _path];
    if (VCM_Debug) then {_this spawn VCM_fnc_3DPathDebug;};
}]];
_unit setVariable ["VCM_EventHandlers", _handlers];
_unit setVariable ["VCM_HandlerGroup", _group];
_unit setAnimSpeedCoef 1.15;
_unit disableAI "RADIOPROTOCOL";
_unit setVariable ["babe_em_vars", [false, false, true]];
