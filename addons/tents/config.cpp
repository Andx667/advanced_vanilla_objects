#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        author = AUTHOR;
        url = "https://github.com/Andx667/advanced_vanilla_objects";
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "avo_common",
            "ace_interaction",
            "A3_Props_F_Enoch_Military_Camps",
            "A3_Structures_F_Civ_Camping"
        };
        // Skip this addon instead of erroring when ACE or Contact content is missing
        skipWhenMissingDependencies = 1;
        units[] = {};
        weapons[] = {
            QGVAR(solarOlive),
            QGVAR(solarSand),
            QGVAR(solarRedWhite),
            QGVAR(solarBlueWhite),
            QGVAR(dome),
            QGVAR(a)
        };
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgWeapons.hpp"
