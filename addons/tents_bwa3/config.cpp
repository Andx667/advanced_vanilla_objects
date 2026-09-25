#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        author = AUTHOR;
        url = "https://github.com/Andx667/advanced_vanilla_objects";
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "avo_tents",
            "bwa3_props"
        };
        // Skip this addon instead of erroring when BWA3 is missing. avo_tents is a
        // requirement too, so it is skipped as well when the tents addon is.
        skipWhenMissingDependencies = 1;
        units[] = {};
        weapons[] = {
            QGVAR(smallFleck)
        };
        VERSION_CONFIG;
    };
};

#include "CfgWeapons.hpp"
