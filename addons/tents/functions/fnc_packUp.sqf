#include "..\script_component.hpp"
/*
 * Author: Andx
 * Removes the tent and gives the matching tent item to the caller.
 *
 * Arguments:
 * 0: Tent <OBJECT>
 * 1: Caller <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call avo_tents_fnc_packUp
 *
 * Public: No
 */

params ["_tent", "_caller"];

private _item = GVAR(itemOfTent) getOrDefault [toLowerANSI typeOf _tent, ""];

// Room could have been used up while the progress bar was running
if (_item == "" || {!(_caller canAdd [_item, 1])}) exitWith {
    [_caller, _tent] call FUNC(cancel);
};

private _grassCutter = _tent getVariable [QGVAR(grassCutter), objNull];

if (!isNull _grassCutter) then {
    deleteVehicle _grassCutter;
};

private _posASL = getPosASL _tent;
private _vectorDirAndUp = [vectorDir _tent, vectorUp _tent];
private _classname = typeOf _tent;

deleteVehicle _tent;

_caller addItem _item;

[QGVAR(packedUp), [_classname, _posASL, _vectorDirAndUp, _caller, _item]] call CBA_fnc_globalEvent;
_caller switchMove "";

[LLSTRING(packedUp)] call ACEFUNC(common,displayText);
