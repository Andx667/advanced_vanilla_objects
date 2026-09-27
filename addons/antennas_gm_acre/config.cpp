#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        author = AUTHOR;
        url = "https://github.com/Andx667/advanced_vanilla_objects";
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "avo_antennas_gm",
            "avo_antennas_acre",
            "gm_objects_container_shelterace_ge_army_shelterace"
        };
        // Skip this addon instead of erroring when Global Mobilization or ACRE is missing.
        // avo_antennas_gm and avo_antennas_acre are requirements too, so this is skipped as well
        // when ACE, Contact content or (through avo_antennas_acre) ACRE itself is missing.
        skipWhenMissingDependencies = 1;
        units[] = {};
        weapons[] = {};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgAcreComponents.hpp"
#include "CfgVehicles.hpp"
