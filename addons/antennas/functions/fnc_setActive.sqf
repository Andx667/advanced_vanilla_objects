#include "..\script_component.hpp"
/*
 * Author: Andx
 * Activates or deactivates an antenna object that has to be switched on first (Rugged
 * communications terminals). Does the same as the "Open terminal" editor attribute, but
 * animated. Has to run where the object is local, see the avo_antennas_setActive event.
 *
 * Arguments:
 * 0: Antenna object <OBJECT>
 * 1: Activate <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, true] call avo_antennas_fnc_setActive
 *
 * Public: No
 */

params ["_object", "_activate"];

private _phase = [0, 100] select _activate;

{
    _object animateSource [_x, _phase];
} forEach getArray (configOf _object >> QGVAR(activeSources));
