#include "..\script_component.hpp"
/*
 * Author: Andx
 * Position of the antenna tip for ACRE (`acre_antennaPosFnc`). Uses the top centre of the
 * object's bounding box, so the antenna sits at the real height of the model instead of a
 * hand-measured config value. A wrapper, because ACRE passes the connector index as the
 * second argument.
 *
 * Arguments:
 * 0: Antenna object <OBJECT>
 * 1: Connector index <NUMBER> (unused)
 *
 * Return Value:
 * Antenna position <ARRAY> (ASL)
 *
 * Example:
 * [cursorObject, 0] call avo_antennas_fnc_antennaPos
 *
 * Public: No
 */

params ["_object", ""];

[_object] call EFUNC(common,topPosition)
