#include "..\script_component.hpp"
/*
 * Author: Andx
 * Opens the inventory of a tent. A tent that has none yet gets it from the server first, the
 * inventory opens as soon as it is there, or a message says it could not. Raises the
 * avo_tents_inventoryOpened event.
 *
 * Arguments:
 * 0: Tent <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call avo_tents_fnc_openInventory
 *
 * Public: No
 */

params ["_tent", "_unit"];

// One request at a time. The variable is not public, it is about this machine
if (_tent getVariable [QGVAR(opening), false]) exitWith {};

private _open = {
    params ["_tent", "_unit"];

    _tent setVariable [QGVAR(opening), nil];

    private _container = _tent getVariable [QGVAR(container), objNull];

    // The unit could have died or got into a vehicle while it waited
    if (isNull _container || {!alive _unit} || {!isNull objectParent _unit}) exitWith {};

    _unit action ["Gear", _container];

    [QGVAR(inventoryOpened), [_tent, _unit]] call CBA_fnc_globalEvent;
};

if (!isNull (_tent getVariable [QGVAR(container), objNull])) exitWith {
    [_tent, _unit] call _open;
};

_tent setVariable [QGVAR(opening), true];
[QGVAR(createContainer), [_tent]] call CBA_fnc_serverEvent;

// The variable of the tent is public, it arrives a moment after the server made the container
[
    {!isNull ((_this select 0) getVariable [QGVAR(container), objNull])},
    _open,
    [_tent, _unit],
    5,
    {
        (_this select 0) setVariable [QGVAR(opening), nil];

        [LLSTRING(inventoryFailed), true] call ACEFUNC(common,displayText);
    }
] call CBA_fnc_waitUntilAndExecute;
