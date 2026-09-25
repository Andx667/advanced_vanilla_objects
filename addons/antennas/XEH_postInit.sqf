#include "script_component.hpp"

// The animation has to run where the object is local, which can be the server
[QGVAR(setActive), FUNC(setActive)] call CBA_fnc_addEventHandler;

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

// The Rugged communications terminals have to be activated before a radio can be connected
private _activate = [
    QGVAR(activate),
    LLSTRING(activate),
    "\a3\ui_f\data\IGUI\Cfg\Actions\ico_ON_ca.paa",
    {
        params ["_target"];
        [QGVAR(setActive), [_target, true], _target] call CBA_fnc_targetEvent;
    },
    {
        params ["_target"];
        GVAR(enabled) && {!([_target] call FUNC(isActive))}
    },
    {},
    [],
    _position,
    5
] call ACEFUNC(interact_menu,createAction);

// A radio still connected when the terminal is deactivated is disconnected first
private _deactivate = [
    QGVAR(deactivate),
    LLSTRING(deactivate),
    "\a3\ui_f\data\IGUI\Cfg\Actions\ico_OFF_ca.paa",
    {
        params ["_target", "_player"];
        if ([_player, _target] call ACREFUNC(sys_gsa,isAntennaConnected)) then {
            [_player, _target] call ACREFUNC(sys_gsa,disconnect);
        };
        [QGVAR(setActive), [_target, false], _target] call CBA_fnc_targetEvent;
    },
    {
        params ["_target"];
        GVAR(enabled) && {[_target] call FUNC(isActive)}
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

{
    [_x, 0, [], _activate, true] call ACEFUNC(interact_menu,addActionToClass);
    [_x, 0, [], _deactivate, true] call ACEFUNC(interact_menu,addActionToClass);
} forEach [
    "RuggedTerminal_01_communications_F",
    "RuggedTerminal_02_communications_F",
    "RuggedTerminal_01_communications_hub_F"
];
