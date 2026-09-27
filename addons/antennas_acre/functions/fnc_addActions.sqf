#include "..\script_component.hpp"
/*
 * Author: Andx
 * Adds the actions to connect and disconnect an ACRE radio to a class and its children, like
 * ACRE's ground spike antenna. Nest them under an existing sub menu (a terminal or antenna mast
 * that has to be activated first) with `_parentPath`, or leave it out for an antenna that is
 * always active (no sub menu of its own). Does nothing without an interface, and when ACRE's
 * ground spike antenna functions are missing, see XEH_postInit.sqf. Called by other addons after
 * this one is initialised.
 *
 * Arguments:
 * 0: Class, children included <STRING>
 * 1: Parent path of the action, `[]` for the top level (default: `[]`) <ARRAY of STRING>
 *
 * Return Value:
 * Actions added <BOOL>
 *
 * Example:
 * ["Land_SatelliteAntenna_01_F"] call avo_antennas_acre_fnc_addActions
 * ["RuggedTerminal_01_communications_F", [QEGVAR(antennas,terminal)]] call avo_antennas_acre_fnc_addActions
 *
 * Public: No
 */

params ["_class", ["_parentPath", []]];

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
        && {[_target] call EFUNC(antennas,isActive)}
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

[_class, _parentPath, _connect] call EFUNC(common,addClassActions);
[_class, _parentPath, _disconnect] call EFUNC(common,addClassActions);

true
