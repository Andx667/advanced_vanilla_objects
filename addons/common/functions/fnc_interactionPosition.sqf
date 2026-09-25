#include "..\script_component.hpp"
/*
 * Author: Andx
 * Point for an ACE interaction on an object: the point of the object's bounding box that is
 * closest to the player, at chest height where the model allows it. For the position code
 * of an interaction. The centre of a big or tall model can be out of reach, and this
 * is always within reach of a player who stands next to it.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * Position <ARRAY> (model space of the object)
 *
 * Example:
 * {[_target] call avo_common_fnc_interactionPosition}
 *
 * Public: Yes
 */

params ["_object"];

(boundingBoxReal _object) params ["_min", "_max"];

private _player = _object worldToModelVisual (ACE_player modelToWorldVisual [0, 0, 1.2]);

[
    ((_player select 0) max (_min select 0)) min (_max select 0),
    ((_player select 1) max (_min select 1)) min (_max select 1),
    ((_player select 2) max ((_min select 2) + 0.5)) min (_max select 2)
]
