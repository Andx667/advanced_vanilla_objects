#include "script_component.hpp"

if (!hasInterface) exitWith {};

if (isNil QTFARFUNC(antennas,initRadioTower) || {isNil QTFARFUNC(antennas,deleteRadioTower)}) exitWith {
    WARNING("TFAR radio tower functions not found, TFAR antenna registration disabled");
};

// Rugged terminals and the GM antenna mast are covered here in addition to
// Extended_InitPost/Deleted_EventHandlers (CfgEventHandlers.hpp), because they can be switched on
// and off after they exist, unlike the satellite dishes and omni-directional antennas.
[QEGVAR(antennas,activated), {
    params ["_terminal"];
    [_terminal] call FUNC(registerTower);
}] call CBA_fnc_addEventHandler;

[QEGVAR(antennas,deactivated), {
    params ["_terminal"];
    [_terminal] call FUNC(deregisterTower);
}] call CBA_fnc_addEventHandler;
