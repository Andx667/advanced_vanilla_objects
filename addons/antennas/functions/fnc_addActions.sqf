#include "..\script_component.hpp"
/*
 * Author: Andx
 * Adds the actions to switch an antenna object on and off (Rugged communications terminals, GM
 * antenna masts), in a sub menu with the given labels; see isActive and isEquipped. Comms mods
 * (avo_antennas_acre, ...) nest their own connect/disconnect actions in the same sub menu, under
 * the fixed path `[QGVAR(terminal)]`. Does nothing without an interface. Called by other addons
 * after this one is initialised.
 *
 * Arguments:
 * 0: Class, children included <STRING>
 * 1: Labels of the sub menu, the activate action and the deactivate action <ARRAY>
 *
 * Return Value:
 * Actions added <BOOL>
 *
 * Example:
 * ["RuggedTerminal_01_communications_F", ["Terminal", "Activate Terminal", "Deactivate Terminal"]] call avo_antennas_fnc_addActions
 *
 * Public: No
 */

params ["_class", "_labels"];

if (!hasInterface) exitWith {false};

_labels params ["_menuLabel", "_activateLabel", "_deactivateLabel"];

// The Rugged terminals are big, the centre of the hub is out of reach. This is the point of the model closest to the player.
private _position = {[_target] call EFUNC(common,interactionPosition)};

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

private _deactivate = [
    QGVAR(deactivate),
    _deactivateLabel,
    "\a3\ui_f\data\IGUI\Cfg\Actions\ico_OFF_ca.paa",
    {
        params ["_target", "_player"];
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

// One interaction point for everything the object can do (activate, deactivate, and whatever a
// comms mod nests here). Shown whenever the antenna is equipped, so a comms mod's own actions
// stay reachable even while GVAR(enabled) is off, they are gated by their own setting instead.
private _terminal = [
    QGVAR(terminal),
    _menuLabel,
    "\A3\ui_f\data\igui\cfg\actions\gear_ca.paa",
    {},
    {
        params ["_target"];
        [_target] call FUNC(isEquipped)
    },
    {},
    [],
    _position,
    5
] call ACEFUNC(interact_menu,createAction);

[_class, [], _terminal] call EFUNC(common,addClassActions);
[_class, [QGVAR(terminal)], _activate] call EFUNC(common,addClassActions);
[_class, [QGVAR(terminal)], _deactivate] call EFUNC(common,addClassActions);

true
