#include "script_component.hpp"

// ACRE raises events on the server when a ground spike antenna is connected or disconnected. They are
// raised again for our antennas as avo_antennas_connected and avo_antennas_disconnected.
[QACREGVAR(sys_gsa,connectGsa), {
    params ["_antenna", "_radioId", "_unit"];

    // Every antenna component of AVO is named avo_antennas_*, also the mast of avo_antennas_gm_acre
    if ((getText (configOf _antenna >> "AcreComponents" >> "componentName")) find QUOTE(DOUBLES(PREFIX,antennas)) == 0) then {
        [QEGVAR(antennas,connected), [_antenna, _radioId, _unit]] call CBA_fnc_globalEvent;
    };
}] call CBA_fnc_addEventHandler;

[QACREGVAR(sys_gsa,disconnectGsa), {
    params ["_antenna", "_unit", ["_radioId", ""]];

    // Every antenna component of AVO is named avo_antennas_*, also the mast of avo_antennas_gm_acre
    if ((getText (configOf _antenna >> "AcreComponents" >> "componentName")) find QUOTE(DOUBLES(PREFIX,antennas)) == 0) then {
        [QEGVAR(antennas,disconnected), [_antenna, _unit, _radioId]] call CBA_fnc_globalEvent;
    };
}] call CBA_fnc_addEventHandler;

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

// A radio still connected to a Rugged terminal or an antenna mast is disconnected when it is
// deactivated, ACRE does not know about the switch. avo_antennas raises the event on every machine,
// the server handles it once (isAntennaConnected is true for any radio on the object).
if (isServer) then {
    [QEGVAR(antennas,deactivated), {
        params ["_antenna", "_unit"];

        if ([_unit, _antenna] call ACREFUNC(sys_gsa,isAntennaConnected)) then {
            [_unit, _antenna] call ACREFUNC(sys_gsa,disconnect);
        };
    }] call CBA_fnc_addEventHandler;
};

if (!hasInterface) exitWith {};

GVAR(acreReady) = true;

// Bases of the Contact variants (Olive/Black/Sand, small, mounted). The mounted dishes are out of reach.
{
    [_x] call FUNC(addActions);
} forEach [
    "Land_SatelliteAntenna_01_F",
    "OmniDirectionalAntenna_01_base_F"
];

// The Rugged communications terminals, nested under the Terminal sub menu of avo_antennas
{
    [_x, [QEGVAR(antennas,terminal)]] call FUNC(addActions);
} forEach [
    "RuggedTerminal_01_communications_F",
    "RuggedTerminal_02_communications_F",
    "RuggedTerminal_01_communications_hub_F"
];
