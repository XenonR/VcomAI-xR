/*
    Parameters: [group (GROUP), optional search distance (NUMBER, default 100)].
    Returns: BOOL. Call on the group owner; queries do not reserve a weapon.
*/
params ["_group", ["_searchDist", 100]];
((units _group) findIf {
    private _weapons = nearestObjects [_x, ["StaticWeapon"], _searchDist];
    (_weapons findIf {alive _x && {isNull (gunner _x)} && {isNull (assignedGunner _x)}}) >= 0
}) >= 0
