#include "..\script_component.hpp"
/*
 * Author: Andx
 * Checks if a unit can pack up a tent. Any tent of a supported class can be packed up,
 * set the `avo_tents_canPackUp` object variable to false to prevent that for one tent.
 *
 * Arguments:
 * 0: Tent <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * Can pack up <BOOL>
 *
 * Example:
 * [cursorObject, player] call avo_tents_fnc_canPackUp
 *
 * Public: No
 */

params ["_tent", "_unit"];

private _item = GVAR(itemOfTent) getOrDefault [toLowerANSI typeOf _tent, ""];

GVAR(enabled)
&& {_item != ""}
&& {isNull objectParent _unit}
&& {_tent getVariable [QGVAR(canPackUp), true]}
&& {!(_tent getVariable [QGVAR(inUse), false])}
&& {_unit canAdd [_item, 1]}
