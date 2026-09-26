#include "..\script_component.hpp"
/*
 * Author: Andx
 * The progress bar of packing up a tent is done. A tent that has an inventory is looked at by
 * the server, which owns it: it checks that the inventory is empty and removes it in one step,
 * so what another player puts in at the last moment is not lost. It answers with
 * avo_tents_packUpAnswer. The tent is finished right away when it has no inventory.
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

if (!isNil {_tent getVariable QGVAR(container)}) exitWith {
    [QGVAR(commitPackUp), [_tent, _caller]] call CBA_fnc_serverEvent;

    // The tent must not stay locked when the answer does not come
    [{
        params ["_tent", "_caller"];

        if (!isNull _tent && {_tent getVariable [QGVAR(inUse), false]}) then {
            [_caller, _tent] call FUNC(cancel);
        };
    }, [_tent, _caller], 10] call CBA_fnc_waitAndExecute;
};

[_tent, _caller] call FUNC(finishPackUp);
