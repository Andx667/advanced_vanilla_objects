#include "..\script_component.hpp"
/*
 * Author: Andx
 * Deregisters an antenna object of avo_antennas as a TFAR radio tower (`TFAR_antennas_fnc_
 * deleteRadioTower`). Safe to call on an object that was never registered. Not gated by the
 * setting, so a tower that exists can still be removed when it is turned off. Does nothing
 * without an interface, or when TFAR's function is missing.
 *
 * Arguments:
 * 0: Antenna object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject] call avo_antennas_tfar_fnc_deregisterTower
 *
 * Public: No
 */

params ["_object"];

if (!hasInterface || {isNil QTFARFUNC(antennas,deleteRadioTower)}) exitWith {};

_object call TFARFUNC(antennas,deleteRadioTower);
