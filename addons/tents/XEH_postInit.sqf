#include "script_component.hpp"

// The inventory of a tent is made on the server, so two units that open the same tent for the
// first time never make two of them
if (isServer) then {
    [QGVAR(createContainer), FUNC(createContainer)] call CBA_fnc_addEventHandler;
};

if (!hasInterface) exitWith {};

[] call FUNC(addActions);
