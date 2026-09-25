#include "..\script_component.hpp"
/*
 * Author: Andx
 * Point for an ACE interaction on an object, for the position code of an interaction. Where it
 * is depends on the size of the object:
 * - Small (up to 1 m in every direction): the centre of the object.
 * - Medium (up to 3.5 m wide): centred on the object at chest height.
 * - Big: near where the change happens. That is the position of the given selection (the door
 *   of a tent) when the model has it, else the point of the object that is closest to the
 *   player, at chest height, which is always within reach of a player who stands next to it.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Names of selections or memory points of the model that are where the change happens, the
 *    first one the model has is used, for big objects <ARRAY of STRING> (default: [])
 *
 * Return Value:
 * Position <ARRAY> (model space of the object)
 *
 * Example:
 * {[_target] call avo_common_fnc_interactionPosition}
 * {[_target, ["Door_1"]] call avo_common_fnc_interactionPosition}
 *
 * Public: Yes
 */

params ["_object", ["_selections", [], [[]]]];

(boundingBoxReal _object) params ["_min", "_max"];

private _width = ((_max select 0) - (_min select 0)) max ((_max select 1) - (_min select 1));
private _height = (_max select 2) - (_min select 2);

private _centreX = ((_min select 0) + (_max select 0)) / 2;
private _centreY = ((_min select 1) + (_max select 1)) / 2;
private _chest = ((_min select 2) + 1.2) min (_max select 2);

if (_width max _height <= 1) exitWith {
    [_centreX, _centreY, ((_min select 2) + (_max select 2)) / 2]
};

if (_width <= 3.5) exitWith {
    [_centreX, _centreY, _chest]
};

// Big object. The selections of a model are not known, so look for the first one it has
private _position = [];

{
    private _selection = _x;

    {
        private _point = _object selectionPosition [_selection, _x];

        if (_point isNotEqualTo [0, 0, 0]) exitWith {
            _position = [_point select 0, _point select 1, (_point select 2) max ((_min select 2) + 0.8) min ((_min select 2) + 1.6)];
        };
    } forEach ["Memory", "FireGeometry", "Geometry", "ViewGeometry"];

    if (_position isNotEqualTo []) exitWith {};
} forEach _selections;

if (_position isNotEqualTo []) exitWith {_position};

// Closest point of the object to the player
private _player = _object worldToModelVisual (ACE_player modelToWorldVisual [0, 0, 1.2]);

[
    ((_player select 0) max (_min select 0)) min (_max select 0),
    ((_player select 1) max (_min select 1)) min (_max select 1),
    _chest
]
