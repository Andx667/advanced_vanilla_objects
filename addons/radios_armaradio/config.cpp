#include "script_component.hpp"

// Only base game addons are required next to ArmaRadio, the classes of the DLCs (Argo, Contact)
// are not patched in CfgVehicles.hpp but enabled by name in CfgEventHandlers.hpp, so this addon still
// loads without those DLCs.
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        author = AUTHOR;
        url = "https://github.com/Andx667/advanced_vanilla_objects";
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "avo_common",
            "live_radio_interface",
            "A3_Structures_F_Items_Electronics",
            "A3_Structures_F_Civ_Accessories",
            "A3_Boat_F_Gamma_Boat_Civil_01"
        };
        // Skip this addon instead of erroring when ArmaRadio (Live Radio) is missing
        skipWhenMissingDependencies = 1;
        units[] = {};
        weapons[] = {};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
