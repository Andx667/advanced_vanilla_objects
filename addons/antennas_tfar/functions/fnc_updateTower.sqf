#include "..\script_component.hpp"
/*
 * Author: Andx
 * Registers an antenna object as a TFAR radio tower while the setting is on and the object is
 * active (see avo_antennas_fnc_isActive), and deregisters it otherwise. Registering an object again
 * updates its range. Called when the object is initialised, and for every antenna object of this
 * client when a setting changes.
 *
 * Arguments:
 * 0: Antenna object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject] call avo_antennas_tfar_fnc_updateTower
 *
 * Public: No
 */

params ["_object"];

if (GVAR(enabled) && {[_object] call EFUNC(antennas,isActive)}) then {
    [_object] call FUNC(registerTower);
} else {
    [_object] call FUNC(deregisterTower);
};
