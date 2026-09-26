#include "..\script_component.hpp"
/*
 * Author: Andx
 * Opens the inventory of a tent. A tent that has none yet gets it from the server, which
 * answers with the container (avo_tents_inventoryAnswer), and it is opened then. Raises the
 * avo_tents_inventoryOpened event.
 *
 * Arguments:
 * 0: Tent <OBJECT>
 * 1: Unit <OBJECT>
 * 2: Container of the tent, when the server has made it <OBJECT> (default: objNull)
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call avo_tents_fnc_openInventory
 *
 * Public: No
 */

params ["_tent", "_unit", ["_container", objNull]];

if (isNull _container) then {
    _container = _tent getVariable [QGVAR(container), objNull];
};

// The server makes it, so two units that open the same tent for the first time never make two
if (isNull _container) exitWith {
    [QGVAR(createContainer), [_tent, _unit]] call CBA_fnc_serverEvent;
};

// The unit could have died or got into a vehicle while it waited for the server
if (!alive _unit || {!isNull objectParent _unit}) exitWith {};

_unit action ["Gear", _container];

[QGVAR(inventoryOpened), [_tent, _unit]] call CBA_fnc_globalEvent;
