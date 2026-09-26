#include "..\script_component.hpp"
/*
 * Author: Andx
 * Finds the tent items: every CfgWeapons item that names a tent object in its
 * `avo_tents_object` property, when that object exists. Runs on every machine, the server
 * needs the tents too, it only makes an inventory for these and not for the big ones.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call avo_tents_fnc_scanItems
 *
 * Public: No
 */

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
