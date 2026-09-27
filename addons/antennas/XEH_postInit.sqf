#include "script_component.hpp"

// The animation has to run where the object is local, which can be the server
[QGVAR(setActive), FUNC(setActive)] call CBA_fnc_addEventHandler;

if (!hasInterface) exitWith {};

// The Rugged communications terminals, which have to be activated before anything else can use them
{
    [_x, [LLSTRING(terminal), LLSTRING(activate), LLSTRING(deactivate)]] call FUNC(addActions);
} forEach [
    "RuggedTerminal_01_communications_F",
    "RuggedTerminal_02_communications_F",
    "RuggedTerminal_01_communications_hub_F"
];
