#include "..\script_component.hpp"
/*
 * Author: Andx
 * Sets animation sources of an object to the given phases. Has to run where the object
 * is local, see the avo_animations_animate event.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Sources and their phases <ARRAY>
 *   0: Animation source <STRING>
 *   1: Phase <NUMBER>
 *   2: Instant, instead of the time set in the config of the source <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, [["Drawer_1_move_source", 1]]] call avo_animations_fnc_animate
 *
 * Public: No
 */

params ["_object", "_sources"];

{
    _x params ["_source", "_phase", ["_instant", false]];
    _object animateSource [_source, _phase, _instant];
} forEach _sources;
