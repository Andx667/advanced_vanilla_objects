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

private _cfgVehicles = configFile >> "CfgVehicles";

// [item, tent object] for every tent item whose object is available
GVAR(tentItems) = [];
// lowercase tent object classname -> item
GVAR(itemOfTent) = createHashMap;

{
    private _object = getText (_x >> QGVAR(object));

    if (isClass (_cfgVehicles >> _object)) then {
        GVAR(tentItems) pushBack [configName _x, _object];
        GVAR(itemOfTent) set [toLowerANSI _object, configName _x];
    };
} forEach (format ["isText (_x >> '%1')", QGVAR(object)] configClasses (configFile >> "CfgWeapons"));

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

        // A tent that has an inventory keeps it when the setting is turned off, or what is in it could not be reached
        GVAR(enabled)
        && {isNull objectParent _player}
        && {GVAR(inventory) || {!isNull (_target getVariable [QGVAR(container), objNull])}}
        && {!(_target getVariable [QGVAR(inUse), false])}
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

{
    private _class = _x select 1;

    [_class, 0, [], _group] call ACEFUNC(interact_menu,addActionToClass);
    [_class, 0, [QGVAR(group)], _openInventory] call ACEFUNC(interact_menu,addActionToClass);
    [_class, 0, [QGVAR(group)], _packUp] call ACEFUNC(interact_menu,addActionToClass);
} forEach GVAR(tentItems);
