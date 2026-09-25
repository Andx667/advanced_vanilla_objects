#include "..\script_component.hpp"
/*
 * Author: Andx
 * Starts the progress bar for packing up a tent. The tent is locked while it runs so it
 * cannot be packed up twice.
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
