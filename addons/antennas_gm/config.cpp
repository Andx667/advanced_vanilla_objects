#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        author = AUTHOR;
        url = "https://github.com/Andx667/advanced_vanilla_objects";
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "avo_antennas",
            "gm_objects_container_shelterace_ge_army_shelterace"
        };
        // Skip this addon instead of erroring when Global Mobilization is missing. avo_antennas is a
        // requirement too, so it is skipped as well when ACE or Contact content is missing. This
        // addon is comms-agnostic (extend/retract the mast only), see avo_antennas_gm_acre for the
        // ACRE radio connection.
        skipWhenMissingDependencies = 1;
        units[] = {};
        weapons[] = {};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
