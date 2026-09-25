#include "..\script_component.hpp"
/*
 * Author: Andx
 * Checks if an antenna object is active. Most are always active. Objects that have to be
 * switched on first (Rugged communications terminals, "Open terminal" in the editor) name
 * the animation source that marks this in the `avo_antennas_activeSource` config property;
 * they are active while that source is above 0.
 *
 * Arguments:
 * 0: Antenna object <OBJECT>
 *
 * Return Value:
 * Active <BOOL>
 *
 * Example:
 * [cursorObject] call avo_antennas_fnc_isActive
 *
 * Public: No
 */

params ["_object"];

private _source = getText (configOf _object >> QGVAR(activeSource));

_source isEqualTo "" || {(_object animationSourcePhase _source) > 0}
