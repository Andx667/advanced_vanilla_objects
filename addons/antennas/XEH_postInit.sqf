#include "script_component.hpp"

// The animation has to run where the object is local, which can be the server
[QGVAR(setActive), FUNC(setActive)] call CBA_fnc_addEventHandler;

// ACRE raises events on the server when a ground spike antenna is connected or disconnected. They are
// raised again for our antennas as avo_antennas_connected and avo_antennas_disconnected.
[QACREGVAR(sys_gsa,connectGsa), {
    params ["_antenna", "_radioId", "_unit"];

    // Every antenna component of AVO is named avo_antennas_*, also the ones of the optional addons
    if ((getText (configOf _antenna >> "AcreComponents" >> "componentName")) find QUOTE(ADDON) == 0) then {
        [QGVAR(connected), [_antenna, _radioId, _unit]] call CBA_fnc_globalEvent;
    };
}] call CBA_fnc_addEventHandler;

[QACREGVAR(sys_gsa,disconnectGsa), {
    params ["_antenna", "_unit", ["_radioId", ""]];

    // Every antenna component of AVO is named avo_antennas_*, also the ones of the optional addons
    if ((getText (configOf _antenna >> "AcreComponents" >> "componentName")) find QUOTE(ADDON) == 0) then {
        [QGVAR(disconnected), [_antenna, _unit, _radioId]] call CBA_fnc_globalEvent;
    };
}] call CBA_fnc_addEventHandler;

if (!hasInterface) exitWith {};

// We reuse ACRE's ground spike antenna (sys_gsa) connect/disconnect logic. Those
// functions are not public API, so bail out with a log line rather than throwing
// errors from the interaction menu if ACRE ever renames them.
private _acreFunctions = [
    QACREFUNC(sys_gsa,connectChildrenActions),
    QACREFUNC(sys_gsa,disconnect),
    QACREFUNC(sys_gsa,isAntennaConnected),
    QACREFUNC(sys_gsa,hasCompatibleRadios)
];
private _missing = _acreFunctions select {isNil _x};
if (_missing isNotEqualTo []) exitWith {
    WARNING_1("ACRE ground spike antenna functions not found (%1), interactions disabled",_missing);
};

GVAR(acreReady) = true;

// Bases of the Contact variants (Olive/Black/Sand, small). The mounted dishes are out of reach.
{
    [_x] call FUNC(addActions);
} forEach [
    "Land_SatelliteAntenna_01_F",
    "OmniDirectionalAntenna_01_base_F"
];

// The Rugged communications terminals, which have to be activated before a radio can be connected
{
    [_x, [LLSTRING(terminal), LLSTRING(activate), LLSTRING(deactivate)]] call FUNC(addActions);
} forEach [
    "RuggedTerminal_01_communications_F",
    "RuggedTerminal_02_communications_F",
    "RuggedTerminal_01_communications_hub_F"
];
