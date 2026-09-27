#include "script_component.hpp"

if (!hasInterface) exitWith {};

if (isNil QTFARFUNC(antennas,initRadioTower) || {isNil QTFARFUNC(antennas,deleteRadioTower)}) exitWith {
    WARNING("TFAR radio tower functions not found, TFAR antenna registration disabled");
};

// Rugged terminals are covered here (not with Extended_InitPost/Deleted_EventHandlers alone)
// because they can be switched on and off after they exist, unlike the satellite dishes and
// omni-directional antennas. avo_antennas_activated/deactivated also cover the antenna mast of
// the Global Mobilization command shelters (avo_antennas_gm), without this addon needing to know
// about that class itself.
[QEGVAR(antennas,activated), {
    params ["_terminal"];
    [_terminal] call FUNC(registerTower);
}] call CBA_fnc_addEventHandler;

[QEGVAR(antennas,deactivated), {
    params ["_terminal"];
    [_terminal] call FUNC(deregisterTower);
}] call CBA_fnc_addEventHandler;
