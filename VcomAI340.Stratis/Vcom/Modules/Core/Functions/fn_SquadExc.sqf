/*
    Parameters: group (GROUP), or [group]. Returns: nil.
    Call on the group owner. Register before spawning to prevent duplicate FSMs.
*/
params ["_group"];
if (isNull _group || {!local _group} || {!Vcm_ActivateAI} || {_group in VcmAI_ActiveList} ||
    {_group getVariable ["Vcm_Disable", false]} || {!(side _group in VCM_SIDEENABLED)} ||
    {isPlayer (leader _group)} || {!((leader _group) isKindOf "Man")} ||
    {!(simulationEnabled (leader _group))} || {((units _group) findIf {alive _x}) < 0}) exitWith {};
VcmAI_ActiveList pushBackUnique _group;
_group spawn VCM_fnc_SQUADBEH;
