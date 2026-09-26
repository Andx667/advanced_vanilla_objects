#include "..\script_component.hpp"
/*
 * Author: Andx
 * Opens the inventory of a tent. A tent that has none yet gets it from the server first, the
 * inventory opens as soon as it is there. Raises the avo_tents_inventoryOpened event.
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

private _open = {
    params ["_tent", "_unit"];

    private _container = _tent getVariable [QGVAR(container), objNull];

    if (isNull _container) exitWith {};

    _unit action ["Gear", _container];

    [QGVAR(inventoryOpened), [_tent, _unit]] call CBA_fnc_globalEvent;
};

if (!isNull (_tent getVariable [QGVAR(container), objNull])) exitWith {
    [_tent, _unit] call _open;
};

[QGVAR(createContainer), [_tent]] call CBA_fnc_serverEvent;

// The variable of the tent is public, it arrives a moment after the server made the container
[
    {!isNull ((_this select 0) getVariable [QGVAR(container), objNull])},
    _open,
    [_tent, _unit],
    5
] call CBA_fnc_waitUntilAndExecute;
