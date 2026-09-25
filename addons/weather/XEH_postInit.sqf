#include "script_component.hpp"

if (!hasInterface) exitWith {};

private _readData = [
    QGVAR(readData),
    LLSTRING(readData),
    QACEPATHTOF(kestrel4500,UI\Kestrel4500_Icon.paa),
    {
        params ["_target"];
        [_target] call FUNC(readData);
    },
    {GVAR(enabled)},
    {},
    [],
    {boundingCenter _target},
    4
] call ACEFUNC(interact_menu,createAction);

// Base of the white, olive and sand variants
["Land_PortableWeatherStation_01_base_F", 0, [], _readData, true] call ACEFUNC(interact_menu,addActionToClass);
