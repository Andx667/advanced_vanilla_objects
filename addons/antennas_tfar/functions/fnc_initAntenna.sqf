#include "..\script_component.hpp"
/*
 * Author: Andx
 * Adds an antenna object that was created on this client to the ones a settings change updates
 * (see initSettings.inc.sqf), and registers it as a TFAR radio tower if it is one now, see
 * updateTower. Called by the InitPost event handlers, see CfgEventHandlers.hpp. Does nothing
 * without an interface.
 *
 * Arguments:
 * 0: Antenna object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject] call avo_antennas_tfar_fnc_initAntenna
 *
 * Public: No
 */

params ["_object"];

if (!hasInterface) exitWith {};

GVAR(objects) pushBack _object;

[_object] call FUNC(updateTower);
