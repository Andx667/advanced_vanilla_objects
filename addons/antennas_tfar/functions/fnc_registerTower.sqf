#include "..\script_component.hpp"
/*
 * Author: Andx
 * Registers an antenna object of avo_antennas as a TFAR radio tower (`TFAR_antennas_fnc_
 * initRadioTower`), so every radio within range gets the same boost as being at the tower. TFAR
 * has no concept of connecting one specific radio, unlike ACRE's ground spike antenna: every
 * antenna that is active boosts everyone nearby. Does nothing without an interface, when the
 * setting is off, or when TFAR's function is missing.
 *
 * Arguments:
 * 0: Antenna object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject] call avo_antennas_tfar_fnc_registerTower
 *
 * Public: No
 */

params ["_object"];

if (!hasInterface || {!GVAR(enabled)} || {isNil QTFARFUNC(antennas,initRadioTower)}) exitWith {};

[_object, GVAR(range)] call TFARFUNC(antennas,initRadioTower);
