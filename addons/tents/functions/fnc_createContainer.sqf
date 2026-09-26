#include "..\script_component.hpp"
/*
 * Author: Andx
 * Gives a tent its inventory if it has none yet: an invisible container, attached low in the
 * middle of the tent. It runs on the server, so two units that open the same tent for the first
 * time never make two containers. Only the tents that can be set up and packed up get one, the
 * big tents (decon, connector, medical) have none. A tent that never had an inventory only gets
 * one while the "Tent inventory" setting is on.
 *
 * Arguments:
 * 0: Tent <OBJECT>
 *
 * Return Value:
 * Container of the tent, objNull if it has none <OBJECT>
 *
 * Example:
 * [cursorObject] call avo_tents_fnc_createContainer
 *
 * Public: No
 */

params [["_tent", objNull, [objNull]]];

// The tent could have been packed up while the request was on its way
if (isNull _tent) exitWith {objNull};

// Any client can send this, so it is only for the tents of AVO
if ((GVAR(itemOfTent) getOrDefault [toLowerANSI typeOf _tent, ""]) == "") exitWith {objNull};

private _container = _tent getVariable [QGVAR(container), objNull];

// It has one. Every client gets the reference again, a client that joined late may not have it
if (!isNull _container) exitWith {
    _tent setVariable [QGVAR(container), _container, true];

    _container
};

// A tent that had an inventory gets a new container, its old one is lost. One that never had it needs the setting.
if (!GVAR(inventory) && {isNil {_tent getVariable QGVAR(container)}}) exitWith {objNull};

(boundingBoxReal _tent) params ["_min", "_max"];

// Model space of the tent
private _offset = [
    ((_min select 0) + (_max select 0)) / 2,
    ((_min select 1) + (_max select 1)) / 2,
    (_min select 2) + 0.3
];

_container = createVehicle [QGVAR(container), [0, 0, 0], [], 0, "CAN_COLLIDE"];

if (isNull _container) exitWith {objNull};

_container allowDamage false;
_container attachTo [_tent, _offset];

_tent setVariable [QGVAR(container), _container, true];

_container
