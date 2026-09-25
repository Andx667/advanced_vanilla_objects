#include "script_component.hpp"

// The animation has to run where the object is local, which can be the server
[QGVAR(animate), FUNC(animate)] call CBA_fnc_addEventHandler;

if (!hasInterface) exitWith {};

call FUNC(addActions);
