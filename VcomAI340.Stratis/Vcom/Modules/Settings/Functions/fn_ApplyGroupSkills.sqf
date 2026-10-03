/* Parameters: [group (GROUP)]. Returns: nil. Call on the AI group owner. */
params ["_group"];
if (!local _group || {!VCM_SKILLCHANGE} || {_group getVariable ["VCM_Skilldisable", false]}) exitWith {};
{[_x] call VCM_fnc_ApplyUnitSkills;} forEach (units _group);
