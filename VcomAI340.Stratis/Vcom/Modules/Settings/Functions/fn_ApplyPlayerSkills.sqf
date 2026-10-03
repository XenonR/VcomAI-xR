/*
    Parameters: [player-led group (GROUP)]. Returns: ARRAY of current AI members.
    Call on the group owner. Preserve player-squad skill arrays and base values.
*/
params ["_group"];
private _units = (units _group) select {!isPlayer _x};
if (!local _group || {!Vcm_PlayerAISkills} || {_group getVariable ["VCM_Skilldisable", false]}) exitWith {_units};
private _skills = switch (side _group) do {
    case west: {VCM_PSQUADW};
    case east: {VCM_PSQUADE};
    case resistance: {VCM_PSQUADR};
    default {[]};
};
{
    private _unit = _x;
    if (local _unit) then {{_unit setSkill _x;} forEach _skills;};
} forEach _units;
_units
