#include "..\script_component.hpp"
/*
 * Author: Andx
 * Checks if an antenna object has its antenna. Objects where the antenna is an option (the
 * antenna of the GM shelters) list the animation sources that show it in the
 * `avo_antennas_requiredSources` config property; they are equipped while all of them are
 * above 0. Objects without the property are always equipped.
 *
 * Arguments:
 * 0: Antenna object <OBJECT>
 *
 * Return Value:
 * Equipped <BOOL>
 *
 * Example:
 * [cursorObject] call avo_antennas_fnc_isEquipped
 *
 * Public: No
 */

params ["_object"];

(getArray (configOf _object >> QGVAR(requiredSources))) findIf {(_object animationSourcePhase _x) <= 0} < 0
