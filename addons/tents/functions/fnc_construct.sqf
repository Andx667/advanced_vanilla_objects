#include "..\script_component.hpp"
/*
 * Author: Andx
 * Consumes the tent item and creates the tent at the position and orientation confirmed
 * during the 3D placement step.
 *
 * Arguments:
 * 0: Caller <OBJECT>
 * 1: Tent item classname <STRING>
 * 2: Tent object classname <STRING>
 * 3: Confirmed placement position (ASL) <ARRAY>
 * 4: Confirmed placement [vectorDir, vectorUp] <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "avo_tents_dome", "Land_TentDome_F", getPosASL player, [[0, 1, 0], [0, 0, 1]]] call avo_tents_fnc_construct
 *
 * Public: No
 */

params ["_caller", "_item", "_classname", "_posASL", "_vectorDirAndUp"];

// The item could have been dropped or moved while the progress bar was running
if !(_item in items _caller) exitWith {
    [_caller] call FUNC(cancel);
};

_caller removeItem _item;

private _tent = createVehicle [_classname, [0, 0, 0], [], 0, "CAN_COLLIDE"];
_tent setPosASL _posASL;
_tent setVectorDirAndUp _vectorDirAndUp;

// Cut the grass under the tent
private _boundingSphere = boundingBoxReal _tent select 2;

private _grassCutter = switch (true) do {
    case (_boundingSphere < 2): {createVehicle ["Land_ClutterCutter_small_F", getPos _tent, [], 0, "CAN_COLLIDE"]};
    case (_boundingSphere < 6): {createVehicle ["Land_ClutterCutter_medium_F", getPos _tent, [], 0, "CAN_COLLIDE"]};
    default {createVehicle ["Land_ClutterCutter_large_F", getPos _tent, [], 0, "CAN_COLLIDE"]};
};

_tent setVariable [QGVAR(grassCutter), _grassCutter, true];

{
    _x addCuratorEditableObjects [[_tent, _grassCutter], false];
} forEach allCurators;

_caller switchMove "";
