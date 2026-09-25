#include "script_component.hpp"

if (!hasInterface) exitWith {};

private _readData = [
    QGVAR(readData),
    LLSTRING(readData),
    QPATHTOF(data\readData_ca.paa),
    {
        params ["_target"];
        [_target] call FUNC(readData);
    },
    {GVAR(enabled)},
    {},
    [],
    {[_target] call EFUNC(common,interactionPosition)},
    4
] call ACEFUNC(interact_menu,createAction);

// Base of the white, olive and sand variants
["Land_PortableWeatherStation_01_base_F", [], _readData] call EFUNC(common,addClassActions);

// The windsock only shows the wind
private _readWind = [
    QGVAR(readWind),
    LLSTRING(readWind),
    QPATHTOF(data\readData_ca.paa),
    {
        params ["_target"];
        [_target, true] call FUNC(readData);
    },
    {GVAR(enabled)},
    {},
    [],
    {[_target] call EFUNC(common,interactionPosition)},
    4
] call ACEFUNC(interact_menu,createAction);

["Windsock_01_F", [], _readWind] call EFUNC(common,addClassActions);
