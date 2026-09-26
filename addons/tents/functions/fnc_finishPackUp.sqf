#include "..\script_component.hpp"
/*
 * Author: Andx
 * Removes the tent and gives the matching tent item to the caller. The inventory of the tent, if
 * it had one, is already gone, see avo_tents_fnc_commitPackUp. Raises the avo_tents_packedUp event.
 *
 * Arguments:
 * 0: Tent <OBJECT>
 * 1: Caller <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call avo_tents_fnc_finishPackUp
 *
 * Public: No
 */

params ["_tent", "_caller"];

private _item = GVAR(itemOfTent) getOrDefault [toLowerANSI typeOf _tent, ""];

// Somebody else could have packed the tent up meanwhile
if (isNull _tent || {_item == ""}) exitWith {
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

// The room could have been used up while the server answered, the item is left on the ground then
if (_caller canAdd [_item, 1]) then {
    _caller addItem _item;
} else {
    private _holder = createVehicle ["GroundWeaponHolder", getPosATL _caller, [], 0, "CAN_COLLIDE"];
    _holder addItemCargoGlobal [_item, 1];
};

[QGVAR(packedUp), [_classname, _posASL, _vectorDirAndUp, _caller, _item]] call CBA_fnc_globalEvent;
_caller switchMove "";

[LLSTRING(packedUp)] call ACEFUNC(common,displayText);
