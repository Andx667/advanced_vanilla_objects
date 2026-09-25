#include "..\script_component.hpp"
/*
 * Author: Andx
 * Checks if an object has animation sources. The actions are added to base classes, and not
 * every variant of a class has all of its sources (drawers, doors, lamps), so this decides
 * whether an action is shown for a variant. Reads the config of the object's class.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Animation sources <ARRAY of STRING>
 * 2: Only one of them has to exist, instead of all <BOOL> (default: false)
 *
 * Return Value:
 * Has the sources <BOOL>
 *
 * Example:
 * [cursorObject, ["Door_1_Hide", "Door_2_Hide"]] call avo_animations_fnc_hasSources
 *
 * Public: No
 */

params ["_object", "_sources", ["_any", false, [false]]];

private _config = configOf _object >> "AnimationSources";

if (_any) exitWith {
    _sources findIf {isClass (_config >> _x)} != -1
};

_sources findIf {!isClass (_config >> _x)} == -1
