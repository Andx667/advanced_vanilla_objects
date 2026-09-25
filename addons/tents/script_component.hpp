#define COMPONENT tents
#define COMPONENT_BEAUTIFIED Tents
#include "\z\avo\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_TENTS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_TENTS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TENTS
#endif

#include "\z\avo\addons\main\script_macros.hpp"

// States for the 3D placement ghost preview (see fnc_place.sqf)
#define PLACE_WAITING -1
#define PLACE_CANCEL 0
#define PLACE_APPROVE 1
