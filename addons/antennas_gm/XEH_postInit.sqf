#include "script_component.hpp"

if (!hasInterface) exitWith {};

// The antenna mast of the command shelters works like a Rugged communications terminal: it has to
// be extended before a radio can be connected. avo_antennas is initialised before this addon.
[
    "gm_shelteraceI_command_base",
    [LLSTRING(menu), LLSTRING(extend), LLSTRING(retract)]
] call EFUNC(antennas,addActions);
