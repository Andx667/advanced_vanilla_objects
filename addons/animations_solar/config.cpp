#include "script_component.hpp"

// Tilt and rotate actions for the Rugged solar panels, apart from the other animations because
// Advanced Equipment (AE3) has its own controls for them and the two would be doubled.
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        author = AUTHOR;
        url = "https://github.com/Andx667/advanced_vanilla_objects";
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "avo_animations"
        };
        // Skip this addon instead of erroring when ACE is missing
        skipWhenMissingDependencies = 1;
        // Skip this addon when Advanced Equipment is loaded, it does the same. Needs Arma 3 2.22,
        // older versions ignore it and load the addon.
        skipWhenAnyAddonPresent[] = {"ae_main"};
        units[] = {};
        weapons[] = {};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
