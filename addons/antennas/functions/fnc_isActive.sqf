#include "..\script_component.hpp"
/*
 * Author: Andx
 * Checks if an antenna object is active. Most are always active. Objects that have to be
 * switched on first (Rugged communications terminals, "Open terminal" in the editor) list
 * their animation sources in the `avo_antennas_activeSources` config property; they are
 * active while the first one is above 0.
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

private _sources = getArray (configOf _object >> QGVAR(activeSources));

_sources isEqualTo [] || {(_object animationSourcePhase (_sources select 0)) > 0}
