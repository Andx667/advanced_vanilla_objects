/*
 * Author: Andx
 * Position of the antenna tip for ACRE (`acre_antennaPosFnc`). Uses the top
 * centre of the object's bounding box, so the antenna sits at the real height
 * of the model instead of a hand-measured config value.
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

(boundingBoxReal _object) params ["_min", "_max"];

_object modelToWorldWorld [
    ((_min select 0) + (_max select 0)) / 2,
    ((_min select 1) + (_max select 1)) / 2,
    _max select 2
]
