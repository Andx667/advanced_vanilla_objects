if (!hasInterface) exitWith {};

// We reuse ACRE's ground spike antenna (sys_gsa) connect/disconnect logic. Those
// functions are not public API, so bail out with a log line rather than throwing
// errors from the interaction menu if ACRE ever renames them.
private _acreFunctions = [
    "acre_sys_gsa_fnc_connectChildrenActions",
    "acre_sys_gsa_fnc_disconnect",
    "acre_sys_gsa_fnc_isAntennaConnected",
    "acre_sys_gsa_fnc_hasCompatibleRadios"
];
private _missing = _acreFunctions select {isNil _x};
if (_missing isNotEqualTo []) exitWith {
    diag_log format ["[AVO] Antennas: ACRE ground spike antenna functions not found (%1), interactions disabled", _missing];
};

private _icons = "\idi\acre\addons\ace_interact\data\icons\";
private _position = {boundingCenter _target};

private _connect = [
    "avo_antennas_connect",
    localize "STR_avo_antennas_connect",
    _icons + "connect.paa",
    {},
    {
        params ["_target", "_player"];
        !([_player, _target] call acre_sys_gsa_fnc_isAntennaConnected)
        && {[_player, _target] call acre_sys_gsa_fnc_hasCompatibleRadios}
    },
    {
        params ["_target", "_player"];
        [_player, _target] call acre_sys_gsa_fnc_connectChildrenActions
    },
    [],
    _position,
    5
] call ace_interact_menu_fnc_createAction;

private _disconnect = [
    "avo_antennas_disconnect",
    localize "STR_avo_antennas_disconnect",
    _icons + "disconnect.paa",
    {
        params ["_target", "_player"];
        [_player, _target] call acre_sys_gsa_fnc_disconnect;
    },
    {
        params ["_target", "_player"];
        [_player, _target] call acre_sys_gsa_fnc_isAntennaConnected
    },
    {},
    [],
    _position,
    5
] call ace_interact_menu_fnc_createAction;

// Bases of every Contact variant (Olive/Black/Sand, small, mounted)
{
    [_x, 0, [], _connect, true] call ace_interact_menu_fnc_addActionToClass;
    [_x, 0, [], _disconnect, true] call ace_interact_menu_fnc_addActionToClass;
} forEach [
    "Land_SatelliteAntenna_01_F",
    "Land_SatelliteAntenna_01_mounted_base_F",
    "OmniDirectionalAntenna_01_base_F"
];
