#include "..\script_component.hpp"
/*
 * Author: Andx
 * Registers the ACE interactions for tents. Every CfgWeapons item that names a tent
 * object in its `avo_tents_object` property gets a "set up" self-interaction (shown while
 * the item is carried), and every tent object gets a "pack up" interaction.
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
    {boundingCenter _target},
    6
] call ACEFUNC(interact_menu,createAction);

{
    [_x select 1, 0, [], _packUp] call ACEFUNC(interact_menu,addActionToClass);
} forEach GVAR(tentItems);
