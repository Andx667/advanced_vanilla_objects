#include "..\script_component.hpp"
/*
 * Author: Andx
 * Registers the ACE interactions for tents. Every CfgWeapons item that names a tent
 * object in its `avo_tents_object` property gets a "set up" self-interaction (shown while
 * the item is carried), and every tent object gets a sub menu with "open inventory" and
 * "pack up".
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call avo_tents_fnc_addActions
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

// The tent items are found by avo_tents_fnc_scanItems, before this
if (GVAR(tentItems) isEqualTo []) exitWith {};

// Parent container in the equipment menu, opens a sub-menu with one entry per carried tent
private _setUp = [
    QGVAR(setUp),
    LLSTRING(setUp),
    QPATHTOF(data\deploy_ca.paa),
    {},
    {
        params ["", "_player"];

        private _carried = items _player;

        GVAR(enabled)
        && {isNull objectParent _player}
        && {GVAR(tentItems) findIf {(_x select 0) in _carried} != -1}
    }
] call ACEFUNC(interact_menu,createAction);

// On the class, so the actions survive respawn and unit switching
["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment"], _setUp, true] call ACEFUNC(interact_menu,addActionToClass);

{
    _x params ["_item", "_object"];

    private _child = [
        QGVAR(setUp) + "_" + _item,
        getText (configFile >> "CfgWeapons" >> _item >> "displayName"),
        QPATHTOF(data\deploy_ca.paa),
        {
            params ["", "_player", "_params"];
            _params params ["_item", "_object"];

            [_player, _item, _object] call FUNC(place);
        },
        {
            params ["", "_player", "_params"];

            (_params select 0) in items _player
        },
        {},
        [_item, _object]
    ] call ACEFUNC(interact_menu,createAction);

    ["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(setUp)], _child, true] call ACEFUNC(interact_menu,addActionToClass);
} forEach GVAR(tentItems);

// Where the actions are depends on the size of the tent, see avo_common_fnc_interactionPosition
private _position = {[_target] call EFUNC(common,interactionPosition)};
private _distance = 6;

// Pack up and the inventory can be shown together, so they are in one sub menu, or their
// interaction points would be at the same place. The sub menu is only shown when one of them is.
private _group = [
    QGVAR(group),
    LLSTRING(group),
    "",
    {},
    {GVAR(enabled)},
    {},
    [],
    _position,
    _distance
] call ACEFUNC(interact_menu,createAction);

private _openInventory = [
    QGVAR(openInventory),
    LLSTRING(openInventory),
    "\A3\ui_f\data\igui\cfg\actions\gear_ca.paa",
    {
        params ["_target", "_player"];

        [_target, _player] call FUNC(openInventory);
    },
    {
        params ["_target", "_player"];

        // A tent that has, or had, an inventory keeps it when the setting is turned off, or what is in it could not be reached
        GVAR(enabled)
        && {isNull objectParent _player}
        && {GVAR(inventory) || {!isNil {_target getVariable QGVAR(container)}}}
    },
    {},
    [],
    _position,
    _distance
] call ACEFUNC(interact_menu,createAction);

private _packUp = [
    QGVAR(packUp),
    LLSTRING(packUp),
    QPATHTOF(data\pickup_ca.paa),
    {
        params ["_target", "_player"];

        [_target, _player] call FUNC(progressPackUp);
    },
    {
        params ["_target", "_player"];

        [_target, _player] call FUNC(canPackUp)
    },
    {},
    [],
    _position,
    _distance
] call ACEFUNC(interact_menu,createAction);

// Once for every tent object. Two items can set up the same one, ACE would add the actions twice
private _registered = createHashMap;

{
    private _class = _x select 1;

    if (_registered getOrDefault [toLowerANSI _class, false]) then {continue};
    _registered set [toLowerANSI _class, true];

    [_class, 0, [], _group] call ACEFUNC(interact_menu,addActionToClass);
    [_class, 0, [QGVAR(group)], _openInventory] call ACEFUNC(interact_menu,addActionToClass);
    [_class, 0, [QGVAR(group)], _packUp] call ACEFUNC(interact_menu,addActionToClass);
} forEach GVAR(tentItems);
