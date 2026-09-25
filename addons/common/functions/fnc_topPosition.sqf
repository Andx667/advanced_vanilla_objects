#include "..\script_component.hpp"
/*
 * Author: Andx
 * Position of the top centre of an object's bounding box. Follows the object's
 * orientation, so the position stays at the top of the model when it is tilted.
 * Used to put antennas and sensors at the real height of a model instead of a
 * hand-measured value.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Offset above the top, in model space <NUMBER> (default: 0)
 *
 * Return Value:
 * Position <ARRAY> (ASL)
 *
 * Example:
 * [cursorObject] call avo_common_fnc_topPosition
 * [cursorObject, 0.5] call avo_common_fnc_topPosition
 *
 * Public: Yes
 */

params ["_object", ["_offset", 0, [0]]];

(boundingBoxReal _object) params ["_min", "_max"];

_object modelToWorldWorld [
    ((_min select 0) + (_max select 0)) / 2,
    ((_min select 1) + (_max select 1)) / 2,
    (_max select 2) + _offset
]
