#include "..\script_component.hpp"
/*
 * Author: Andx
 * Activates or deactivates an antenna object that has to be switched on first (Rugged
 * communications terminals, antenna masts). Does the same as the "Open terminal" editor
 * attribute, but animated. The animation sources go to the `avo_antennas_activePhase` config
 * property (100 when the class has none). Has to run where the object is local, see the
 * avo_antennas_setActive event.
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

private _cfg = configOf _object;
private _phase = [0, [100, getNumber (_cfg >> QGVAR(activePhase))] select isNumber (_cfg >> QGVAR(activePhase))] select _activate;

{
    _object animateSource [_x, _phase];
} forEach getArray (_cfg >> QGVAR(activeSources));
