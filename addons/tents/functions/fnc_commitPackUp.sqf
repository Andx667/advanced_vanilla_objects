#include "..\script_component.hpp"
/*
 * Author: Andx
 * Runs on the server when a unit is done packing up a tent that has an inventory. The server
 * owns the container, so it sees what was put in a moment ago, and it looks and removes the
 * container in one step: nothing can be put in afterwards. The unit always gets the answer,
 * with avo_tents_packUpAnswer.
 *
 * Arguments:
 * 0: Tent <OBJECT>
 * 1: Caller <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call avo_tents_fnc_commitPackUp
 *
 * Public: No
 */

params [["_tent", objNull, [objNull]], ["_caller", objNull, [objNull]]];

// Nobody to answer
if (isNull _caller) exitWith {};

// Somebody else could have packed the tent up meanwhile. Any client can send this, so it is only for the tents of AVO.
private _empty = !isNull _tent
    && {(GVAR(itemOfTent) getOrDefault [toLowerANSI typeOf _tent, ""]) != ""}
    && {[_tent] call FUNC(isEmpty)};

if (_empty) then {
    deleteVehicle (_tent getVariable [QGVAR(container), objNull]);

    // It is a tent without an inventory again
    _tent setVariable [QGVAR(container), nil, true];
};

[QGVAR(packUpAnswer), [_tent, _caller, _empty], _caller] call CBA_fnc_targetEvent;
