#include "script_component.hpp"

if (!hasInterface) exitWith {};

// We reuse ACRE's ground spike antenna (sys_gsa) connect/disconnect logic. Those
// functions are not public API, so bail out with a log line rather than throwing
// errors from the interaction menu if ACRE ever renames them.
private _acreFunctions = [
    QACREFUNC(sys_gsa,connectChildrenActions),
    QACREFUNC(sys_gsa,disconnect),
    QACREFUNC(sys_gsa,isAntennaConnected),
    QACREFUNC(sys_gsa,hasCompatibleRadios)
];
private _missing = _acreFunctions select {isNil _x};
if (_missing isNotEqualTo []) exitWith {
    WARNING_1("ACRE ground spike antenna functions not found (%1), interactions disabled",_missing);
};

private _position = {boundingCenter _target};

private _connect = [
    QGVAR(connect),
    LLSTRING(connect),
    QACREPATHTOF(ace_interact,data\icons\connect.paa),
    {},
    {
        params ["_target", "_player"];
        GVAR(enabled)
        && {[_target] call FUNC(isActive)}
        && {!([_player, _target] call ACREFUNC(sys_gsa,isAntennaConnected))}
        && {[_player, _target] call ACREFUNC(sys_gsa,hasCompatibleRadios)}
    },
    {
        params ["_target", "_player"];
        [_player, _target] call ACREFUNC(sys_gsa,connectChildrenActions)
    },
    [],
    _position,
    5
] call ACEFUNC(interact_menu,createAction);

// Not gated by the setting, so a link that exists can still be removed when it is turned off
private _disconnect = [
    QGVAR(disconnect),
    LLSTRING(disconnect),
    QACREPATHTOF(ace_interact,data\icons\disconnect.paa),
    {
        params ["_target", "_player"];
        [_player, _target] call ACREFUNC(sys_gsa,disconnect);
    },
    {
        params ["_target", "_player"];
        [_player, _target] call ACREFUNC(sys_gsa,isAntennaConnected)
    },
    {},
    [],
    _position,
    5
] call ACEFUNC(interact_menu,createAction);

// Bases of every Contact variant (Olive/Black/Sand, small, mounted) and the Rugged communications terminals
{
    [_x, 0, [], _connect, true] call ACEFUNC(interact_menu,addActionToClass);
    [_x, 0, [], _disconnect, true] call ACEFUNC(interact_menu,addActionToClass);
} forEach [
    "Land_SatelliteAntenna_01_F",
    "Land_SatelliteAntenna_01_mounted_base_F",
    "OmniDirectionalAntenna_01_base_F",
    "RuggedTerminal_01_communications_F",
    "RuggedTerminal_02_communications_F",
    "RuggedTerminal_01_communications_hub_F"
];
