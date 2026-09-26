#include "..\script_component.hpp"
/*
 * Author: Andx
 * Gives a tent its inventory if it has none yet: an invisible container, attached low in the
 * middle of the tent. It runs on the server, so two units that open the same tent for the first
 * time never make two containers.
 *
 * Arguments:
 * 0: Tent <OBJECT>
 *
 * Return Value:
 * Container of the tent <OBJECT>
 *
 * Example:
 * [cursorObject] call avo_tents_fnc_createContainer
 *
 * Public: No
 */

params ["_tent"];

// The tent could have been packed up while the request was on its way
if (isNull _tent) exitWith {objNull};

private _container = _tent getVariable [QGVAR(container), objNull];

if (!isNull _container) exitWith {_container};

(boundingBoxReal _tent) params ["_min", "_max"];

// Model space of the tent
private _offset = [
    ((_min select 0) + (_max select 0)) / 2,
    ((_min select 1) + (_max select 1)) / 2,
    (_min select 2) + 0.3
];

_container = createVehicle [QGVAR(container), [0, 0, 0], [], 0, "CAN_COLLIDE"];
_container allowDamage false;
_container attachTo [_tent, _offset];

_tent setVariable [QGVAR(container), _container, true];

_container
