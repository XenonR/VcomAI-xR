/*
    Parameters: [unit (OBJECT)]. Returns: nil. Call where the AI unit is local.
    Apply general, classname, then side settings in the legacy precedence order.
*/
params ["_unit"];
if (!local _unit || {isPlayer _unit} || {!VCM_SKILLCHANGE} || {(group _unit) getVariable ["VCM_Skilldisable", false]}) exitWith {};
_unit setSkill 0.9;
_unit allowFleeing 0;
{_unit setSkill _x;} forEach VCM_AIDIFA;
if (VCM_CLASSNAMESPECIFIC) then {
    {
        if (typeOf _unit isEqualTo (_x select 0)) exitWith {
            private _values = _x select 1;
            {
                _unit setSkill [_x, _values select _forEachIndex];
            } forEach ["aimingAccuracy", "aimingShake", "spotDistance", "spotTime", "courage", "commanding", "aimingSpeed", "general", "endurance", "reloadSpeed"];
        };
    } forEach VCM_SKILL_CLASSNAMES;
};
if (VCM_SIDESPECIFICSKILL) then {_unit call VCM_AISIDESPEC;};
