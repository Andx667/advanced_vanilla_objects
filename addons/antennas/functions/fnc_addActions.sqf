#include "..\script_component.hpp"
/*
 * Author: Andx
 * Adds the actions to connect and disconnect an ACRE radio to a class and its children. With
 * labels it also adds the sub menu of an antenna that has to be switched on first (activate and
 * deactivate, and connect and disconnect inside), see isActive and isEquipped. Does nothing
 * without an interface, and when ACRE's ground spike antenna functions are missing, see
 * XEH_postInit.sqf. Called by other addons after this one is initialised.
 *
 * Arguments:
 * 0: Class, children included <STRING>
 * 1: Labels of the sub menu, the activate action and the deactivate action, empty for an
 *    antenna that is always active <ARRAY> (default: [])
 *
 * Return Value:
 * Actions added <BOOL>
 *
 * Example:
 * ["Land_SatelliteAntenna_01_F"] call avo_antennas_fnc_addActions
 * ["RuggedTerminal_01_communications_F", ["Terminal", "Activate Terminal", "Deactivate Terminal"]] call avo_antennas_fnc_addActions
 *
 * Public: No
 */

params ["_class", ["_labels", [], [[]]]];

if (!hasInterface || {!(missionNamespace getVariable [QGVAR(acreReady), false])}) exitWith {false};

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

if (_labels isEqualTo []) exitWith {
    [_class, [], _connect] call EFUNC(common,addClassActions);
    [_class, [], _disconnect] call EFUNC(common,addClassActions);

    true
};

_labels params ["_menuLabel", "_activateLabel", "_deactivateLabel"];

private _activate = [
    QGVAR(activate),
    _activateLabel,
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
    _deactivateLabel,
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
// Objects with an optional antenna only have it while they are equipped.
private _terminal = [
    QGVAR(terminal),
    _menuLabel,
    "\A3\ui_f\data\igui\cfg\actions\gear_ca.paa",
    {},
    {
        params ["_target", "_player"];
        [_target] call FUNC(isEquipped)
        && {GVAR(enabled) || {[_player, _target] call ACREFUNC(sys_gsa,isAntennaConnected)}}
    },
    {},
    [],
    _position,
    5
] call ACEFUNC(interact_menu,createAction);

[_class, [], _terminal] call EFUNC(common,addClassActions);
[_class, [QGVAR(terminal)], _connect] call EFUNC(common,addClassActions);
[_class, [QGVAR(terminal)], _disconnect] call EFUNC(common,addClassActions);
[_class, [QGVAR(terminal)], _activate] call EFUNC(common,addClassActions);
[_class, [QGVAR(terminal)], _deactivate] call EFUNC(common,addClassActions);

true
