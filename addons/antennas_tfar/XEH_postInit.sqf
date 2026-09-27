#include "script_component.hpp"

if (!hasInterface) exitWith {};

if (isNil QTFARFUNC(antennas,initRadioTower) || {isNil QTFARFUNC(antennas,deleteRadioTower)}) exitWith {
    WARNING("TFAR radio tower functions not found, TFAR antenna registration disabled");
};

// Rugged terminals and the GM antenna mast are covered here in addition to
// Extended_InitPost/Deleted_EventHandlers (CfgEventHandlers.hpp), because they can be switched on
// and off after they exist, unlike the satellite dishes and omni-directional antennas. Not with
// updateTower: the animation that switches them has only just started when the event arrives, so
// avo_antennas_fnc_isActive would not see the change yet.
[QEGVAR(antennas,activated), {
    params ["_terminal"];
    [_terminal] call FUNC(registerTower);
}] call CBA_fnc_addEventHandler;

[QEGVAR(antennas,deactivated), {
    params ["_terminal"];
    [_terminal] call FUNC(deregisterTower);
}] call CBA_fnc_addEventHandler;

// Raised by both settings when they change, and once when the settings are initialised: the
// antennas of the mission were registered before that, maybe before the server's values arrived.
// Deleted antennas are only dropped from the list here, their Deleted handler deregisters them.
[QGVAR(updateTowers), {
    GVAR(objects) = GVAR(objects) select {!isNull _x};

    {
        [_x] call FUNC(updateTower);
    } forEach GVAR(objects);
}] call CBA_fnc_addEventHandler;
