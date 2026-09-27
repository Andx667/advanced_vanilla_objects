#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        author = AUTHOR;
        url = "https://github.com/Andx667/advanced_vanilla_objects";
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "avo_antennas",
            "tfar_antennas",
            "A3_Props_F_Enoch_Military_Camps",
            "A3_Props_F_Enoch_Military_Equipment",
            "A3_Props_F_Decade_Objectives"
        };
        // Skip this addon instead of erroring when TFAR is missing. avo_antennas is a
        // requirement too, so it is skipped as well when ACE or Contact content is missing.
        skipWhenMissingDependencies = 1;
        units[] = {};
        weapons[] = {};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
