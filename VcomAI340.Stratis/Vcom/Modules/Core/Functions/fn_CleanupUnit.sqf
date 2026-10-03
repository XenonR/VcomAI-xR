/*
    Parameters: [unit (OBJECT), previous owning group (GROUP)]. Returns: nil.
    Call on the previous group owner, including after locality is lost.
    Remove only locally recorded Vcom handlers; release traversal only if local.
*/
params ["_unit", "_group"];
if (isNull _unit || {!((_unit getVariable ["VCM_HandlerGroup", grpNull]) isEqualTo _group)}) exitWith {};
if (count (_unit getVariable ["VCM_EventHandlers", []]) isEqualTo 0) exitWith {};
{
    _unit removeEventHandler _x;
} forEach (_unit getVariable ["VCM_EventHandlers", []]);
_unit setVariable ["VCM_EventHandlers", nil];
_unit setVariable ["VCM_HandlerGroup", nil];

if (local _unit) then {
    if (_unit getVariable ["VCM_EMMoving", false]) then {
        _unit enableAI "MOVE";
        _unit setVariable ["VCM_EMMoving", false, true];
    };
};
_unit setVariable ["VCM_EMOwner", nil];
_unit setVariable ["VCM_VAULT", false];
