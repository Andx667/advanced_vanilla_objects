class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

// The classes of the Heli, Apex, Argo and Contact DLCs are not in the config of the base game, a
// patch in CfgVehicles.hpp would need those DLCs to be loaded. Instead ArmaRadio is told on the client
// that they are radios, with the same object variable its own module sets
// (live_radio_interface_hasRadio does the same in config). The entries cover derived classes, and for
// a class that does not exist they are harmless. The ACE actions are added in XEH_postInit.sqf.
class Extended_InitPost_EventHandlers {
    class Land_Tablet_01_F {
        class ADDON {
            clientInit = QUOTE((_this select 0) setVariable [ARR_2('live_radio_interface_enabled',true)]);
        };
    };
    class Land_Tablet_02_F {
        class ADDON {
            clientInit = QUOTE((_this select 0) setVariable [ARR_2('live_radio_interface_enabled',true)]);
        };
    };
    class Land_Laptop_02_F {
        class ADDON {
            clientInit = QUOTE((_this select 0) setVariable [ARR_2('live_radio_interface_enabled',true)]);
        };
    };
    class Land_Laptop_03_base_F {
        class ADDON {
            clientInit = QUOTE((_this select 0) setVariable [ARR_2('live_radio_interface_enabled',true)]);
        };
    };
};
