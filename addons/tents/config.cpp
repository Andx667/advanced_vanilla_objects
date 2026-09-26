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
            "A3_Weapons_F",
            "A3_Props_F_Enoch_Military_Camps",
            "A3_Structures_F_Civ_Camping"
        };
        // Skip this addon instead of erroring when ACE or Contact content is missing
        skipWhenMissingDependencies = 1;
        // The holders of the packed tents, Zeus lists them by the addon that has them
        units[] = {
            "Item_avo_tents_solarOlive",
            "Item_avo_tents_solarSand",
            "Item_avo_tents_solarRedWhite",
            "Item_avo_tents_solarBlueWhite",
            "Item_avo_tents_dome",
            "Item_avo_tents_a"
        };
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
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
