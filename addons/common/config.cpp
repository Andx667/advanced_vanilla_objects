#include "script_component.hpp"

// Shared base of the function addons. It carries the dependencies every one of them has,
// so they only list what is specific to them and are all skipped when one of these is missing.
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        author = AUTHOR;
        url = "https://github.com/Andx667/advanced_vanilla_objects";
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "avo_main",
            "cba_main",
            "ace_common",
            "ace_interact_menu"
        };
        // Skip this addon, and with it every addon that requires it, instead of erroring when CBA or ACE is missing
        skipWhenMissingDependencies = 1;
        units[] = {};
        weapons[] = {};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
