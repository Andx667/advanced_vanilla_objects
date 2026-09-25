#include "..\script_component.hpp"
/*
 * Author: Andx
 * Adds an ACE interaction to a class and every class derived from it. Does the same as
 * ace_interact_menu_fnc_addActionToClass with inheritance, but adds the action to each
 * class by name instead. ACE's inheritance only reaches objects that run CBA's extended
 * event handlers, and classes that define their own EventHandlers class (the Rugged
 * terminals, the weather station, the cabinets, coffins...) do not, so they never get the action.
 *
 * Only classes that can be placed (scope above 0) are used. Call it in postInit, when all
 * classes of the loaded addons exist.
 *
 * Arguments:
 * 0: Base class in CfgVehicles <STRING>
 * 1: Parent path of the action, [] for the top level <ARRAY>
 * 2: Action from ace_interact_menu_fnc_createAction <ARRAY>
 * 3: Classes that are left out, with everything derived from them <ARRAY of STRING> (default: [])
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Land_Fridge_01_F", [], _action] call avo_common_fnc_addClassActions
 *
 * Public: Yes
 */

params ["_base", "_path", "_action", ["_excluded", [], [[]]]];

private _cfgVehicles = configFile >> "CfgVehicles";

// Children of every class, by lowercase name of the parent. Built once.
if (isNil QGVAR(children)) then {
    GVAR(children) = createHashMap;

    {
        private _parent = toLowerANSI configName inheritsFrom _x;
        (GVAR(children) getOrDefault [_parent, [], true]) pushBack configName _x;
    } forEach ("true" configClasses _cfgVehicles);
};

private _excludedLower = _excluded apply {toLowerANSI _x};
private _found = [];
private _queue = [configName (_cfgVehicles >> _base)];

while {_queue isNotEqualTo []} do {
    private _class = _queue deleteAt 0;

    if (_class == "" || {toLowerANSI _class in _excludedLower}) then {continue};

    if (getNumber (_cfgVehicles >> _class >> "scope") > 0) then {
        _found pushBack _class;
    };

    _queue append (GVAR(children) getOrDefault [toLowerANSI _class, []]);
};

{
    [_x, 0, _path, _action] call ACEFUNC(interact_menu,addActionToClass);
} forEach _found;
