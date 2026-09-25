#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        author = AUTHOR;
        url = "https://github.com/Andx667/advanced_vanilla_objects";
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "avo_main",
            "cba_main",
            "ace_interact_menu",
            "acre_sys_antenna",
            "acre_sys_gsa",
            "acre_ace_interact",
            "A3_Props_F_Enoch_Military_Camps",
            "A3_Props_F_Enoch_Military_Equipment"
        };
        // Skip this addon instead of erroring when ACRE, ACE or Contact content is missing
        skipWhenMissingDependencies = 1;
        units[] = {};
        weapons[] = {};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgAcreComponents.hpp"
#include "CfgVehicles.hpp"
