#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// The antenna objects of this client that can be a TFAR radio tower, registered or not, see initAntenna
GVAR(objects) = [];

#include "initSettings.inc.sqf"

ADDON = true;
