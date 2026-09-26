#include "..\script_component.hpp"
/*
 * Author: Andx
 * Starts the progress bar for packing up a tent, unless there is something in its inventory.
 * The tent is locked while it runs so it cannot be packed up twice.
 *
 * Arguments:
 * 0: Tent <OBJECT>
 * 1: Caller <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call avo_tents_fnc_progressPackUp
 *
 * Public: No
 */

params ["_tent", "_caller"];

// The action is only shown for an empty tent, this is for what was put in while the menu was open.
// What is in the inventory of the tent would be lost, it has to be taken out first
if !([_tent] call FUNC(isEmpty)) exitWith {
    [LLSTRING(notEmpty), true] call ACEFUNC(common,displayText);
};

_tent setVariable [QGVAR(inUse), true, true];

_caller playMove "Acts_carFixingWheel";

[
    GVAR(buildTime),
    [_tent, _caller],
    {
        (_this select 0) call FUNC(packUp);
    },
    {
        (_this select 0) params ["_tent", "_caller"];
        [_caller, _tent] call FUNC(cancel);
    },
    LLSTRING(progressPackUp)
] call ACEFUNC(common,progressBar);
