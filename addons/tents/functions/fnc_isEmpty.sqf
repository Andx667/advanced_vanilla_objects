#include "..\script_component.hpp"
/*
 * Author: Andx
 * Checks if the inventory of a tent is empty. A tent that never had an inventory is empty.
 * A tent that has one, but whose container is not there, is not known to be empty: the reference
 * can be invalid on a machine that joined late, or the container was deleted.
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

private _container = _tent getVariable QGVAR(container);

// Never had an inventory
if (isNil "_container") exitWith {true};

!isNull _container
&& {itemCargo _container isEqualTo []
&& {weaponCargo _container isEqualTo []
&& {magazineCargo _container isEqualTo []
&& {backpackCargo _container isEqualTo []}}}}
