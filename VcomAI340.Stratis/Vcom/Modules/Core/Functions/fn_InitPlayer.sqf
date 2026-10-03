/*
    Parameters: [local player (OBJECT)]. Returns: nil. Call on interface clients.
    Install one hearing/respawn handler pair and one IR monitor per client.
*/
params ["_unit"];
if (!hasInterface || {isNull _unit} || {!local _unit}) exitWith {};
if (count (_unit getVariable ["VCM_PlayerHandlers", []]) > 0) exitWith {};
private _handlers = [];
_handlers pushBack ["Fired", _unit addEventHandler ["Fired", {_this call VCM_fnc_HearingAids;}]];
_handlers pushBack ["Respawn", _unit addEventHandler ["Respawn", {
    params ["_newUnit", "_oldUnit"];
    {_oldUnit removeEventHandler _x;} forEach (_oldUnit getVariable ["VCM_PlayerHandlers", []]);
    // Respawn itself is persistent. Remove its inherited ID before reinstalling.
    {
        if ((_x select 0) isEqualTo "Respawn") then {_newUnit removeEventHandler _x;};
    } forEach (_oldUnit getVariable ["VCM_PlayerHandlers", []]);
    _oldUnit setVariable ["VCM_PlayerHandlers", nil];
    _newUnit setVariable ["VCM_PlayerHandlers", nil];
    [_newUnit] call VCM_fnc_InitPlayer;
}]];
_unit setVariable ["VCM_PlayerHandlers", _handlers];
private _monitor = missionNamespace getVariable ["VCM_IRHandle", scriptNull];
if (scriptDone _monitor) then {VCM_IRHandle = [] spawn VCM_fnc_IRCHECK;};
