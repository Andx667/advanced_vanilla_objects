#include "script_component.hpp"

// The animation has to run where the object is local, which can be the server
[QGVAR(setActive), FUNC(setActive)] call CBA_fnc_addEventHandler;

// ACRE raises events on the server when a ground spike antenna is connected or disconnected. They are
// raised again for our antennas as avo_antennas_connected and avo_antennas_disconnected.
[QACREGVAR(sys_gsa,connectGsa), {
    params ["_antenna", "_radioId", "_unit"];

    if (getText (configOf _antenna >> "AcreComponents" >> "componentName") in [QGVAR(satDish), QGVAR(omni)]) then {
        [QGVAR(connected), [_antenna, _radioId, _unit]] call CBA_fnc_globalEvent;
    };
}] call CBA_fnc_addEventHandler;

[QACREGVAR(sys_gsa,disconnectGsa), {
    params ["_antenna", "_unit", ["_radioId", ""]];

    if (getText (configOf _antenna >> "AcreComponents" >> "componentName") in [QGVAR(satDish), QGVAR(omni)]) then {
        [QGVAR(disconnected), [_antenna, _unit, _radioId]] call CBA_fnc_globalEvent;
    };
}] call CBA_fnc_addEventHandler;

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

// The Rugged terminals are big, the centre of the hub is out of reach. This is the point of the model closest to the player.
private _position = {[_target] call EFUNC(common,interactionPosition)};

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
        params ["_target", "_player"];
        [QGVAR(setActive), [_target, true], _target] call CBA_fnc_targetEvent;
        [QGVAR(activated), [_target, _player]] call CBA_fnc_globalEvent;
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
        [QGVAR(deactivated), [_target, _player]] call CBA_fnc_globalEvent;
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

// One interaction point for the terminals, with everything they can do inside. The actions can
// be shown together (deactivate, connect, disconnect) and would overlap on the same point.
private _terminal = [
    QGVAR(terminal),
    LLSTRING(terminal),
    "\A3\ui_f\data\igui\cfg\actions\gear_ca.paa",
    {},
    {
        params ["_target", "_player"];
        GVAR(enabled) || {[_player, _target] call ACREFUNC(sys_gsa,isAntennaConnected)}
    },
    {},
    [],
    _position,
    5
] call ACEFUNC(interact_menu,createAction);

// Bases of the Contact variants (Olive/Black/Sand, small). The mounted dishes are out of reach.
{
    [_x, [], _connect] call EFUNC(common,addClassActions);
    [_x, [], _disconnect] call EFUNC(common,addClassActions);
} forEach [
    "Land_SatelliteAntenna_01_F",
    "OmniDirectionalAntenna_01_base_F"
];

// The Rugged communications terminals, which have to be activated before a radio can be connected
{
    [_x, [], _terminal] call EFUNC(common,addClassActions);
    [_x, [QGVAR(terminal)], _connect] call EFUNC(common,addClassActions);
    [_x, [QGVAR(terminal)], _disconnect] call EFUNC(common,addClassActions);
    [_x, [QGVAR(terminal)], _activate] call EFUNC(common,addClassActions);
    [_x, [QGVAR(terminal)], _deactivate] call EFUNC(common,addClassActions);
} forEach [
    "RuggedTerminal_01_communications_F",
    "RuggedTerminal_02_communications_F",
    "RuggedTerminal_01_communications_hub_F"
];
