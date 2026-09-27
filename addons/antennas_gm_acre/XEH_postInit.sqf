#include "script_component.hpp"

if (!hasInterface) exitWith {};

// The antenna mast of the command shelters works like a Rugged communications terminal: it has to
// be extended before a radio can be connected, and the "Connect Radio"/"Disconnect Radio" actions
// nest in the same "Antenna" sub menu avo_antennas_gm already created (the fixed path is always
// QEGVAR(antennas,terminal), see avo_antennas_fnc_addActions).
["gm_shelteraceI_command_base", [QEGVAR(antennas,terminal)]] call EFUNC(antennas_acre,addActions);
