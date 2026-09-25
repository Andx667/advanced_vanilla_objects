#include "..\script_component.hpp"
/*
 * Author: Andx
 * Restores the caller's animation after a set up or pack up was aborted and releases the
 * tent if it was being packed up.
 *
 * Arguments:
 * 0: Caller <OBJECT>
 * 1: Tent <OBJECT> (default: objNull)
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call avo_tents_fnc_cancel
 *
 * Public: No
 */

params ["_caller", ["_tent", objNull]];

[LLSTRING(abort), true] call ACEFUNC(common,displayText);
_caller switchMove "";

if (!isNull _tent) then {
    _tent setVariable [QGVAR(inUse), false, true];
};
