#include "..\script_component.hpp"
/*
 * Author: Andx
 * Checks if the inventory of a tent is empty. A tent whose inventory has not been opened yet
 * has none, and is empty.
 *
 * Arguments:
 * 0: Tent <OBJECT>
 *
 * Return Value:
 * Is empty <BOOL>
 *
 * Example:
 * [cursorObject] call avo_tents_fnc_isEmpty
 *
 * Public: No
 */

params ["_tent"];

private _container = _tent getVariable [QGVAR(container), objNull];

isNull _container
|| {itemCargo _container isEqualTo []
&& {weaponCargo _container isEqualTo []
&& {magazineCargo _container isEqualTo []
&& {backpackCargo _container isEqualTo []}}}}
