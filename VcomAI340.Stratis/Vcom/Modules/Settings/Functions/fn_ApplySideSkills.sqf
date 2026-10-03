/* Parameters: [unit (OBJECT)]. Returns: nil. Call where the AI unit is local. */
params ["_unit"];
if (!local _unit || {isPlayer _unit}) exitWith {};
private _skills = switch (side (group _unit)) do {
    case west: {VCM_AIDIFWEST};
    case east: {VCM_AIDIFEAST};
    case resistance: {VCM_AIDIFRESISTANCE};
    default {[]};
};
{_unit setSkill _x;} forEach _skills;
