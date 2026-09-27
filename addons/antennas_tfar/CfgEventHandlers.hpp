class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

// Satellite dishes and omni-directional antennas have no on/off switch, so they register as a
// TFAR radio tower as soon as they exist and deregister when deleted. Mounted dishes are included
// too: TFAR only cares about the position, not whether ACE can reach it. The Rugged communications
// terminals and the GM command shelter antenna mast only register while active, including one
// already active when a client joins (clientInit runs for those too, closing the JIP gap the
// avo_antennas_activated/deactivated events in XEH_postInit.sqf alone would leave), see
// updateTower. Only the three communications terminals, not RuggedTerminal_Base_F: its other
// children (RuggedTerminal_01_F) have no avo_antennas_activeSources, so avo_antennas_fnc_isActive
// would count them as always active. The mounted dishes and the terminals need CfgVehicles.hpp to
// run these handlers at all. gm_shelteraceI_command_base simply does not exist without Global
// Mobilization, so this is harmless without it.
class Extended_InitPost_EventHandlers {
    class Land_SatelliteAntenna_01_F {
        class ADDON {
            clientInit = QUOTE([_this select 0] call FUNC(initAntenna));
        };
    };
    class Land_SatelliteAntenna_01_mounted_base_F {
        class ADDON {
            clientInit = QUOTE([_this select 0] call FUNC(initAntenna));
        };
    };
    class OmniDirectionalAntenna_01_base_F {
        class ADDON {
            clientInit = QUOTE([_this select 0] call FUNC(initAntenna));
        };
    };
    class RuggedTerminal_01_communications_F {
        class ADDON {
            clientInit = QUOTE([_this select 0] call FUNC(initAntenna));
        };
    };
    class RuggedTerminal_02_communications_F {
        class ADDON {
            clientInit = QUOTE([_this select 0] call FUNC(initAntenna));
        };
    };
    class RuggedTerminal_01_communications_hub_F {
        class ADDON {
            clientInit = QUOTE([_this select 0] call FUNC(initAntenna));
        };
    };
    class gm_shelteraceI_command_base {
        class ADDON {
            clientInit = QUOTE([_this select 0] call FUNC(initAntenna));
        };
    };
};

class Extended_Deleted_EventHandlers {
    class Land_SatelliteAntenna_01_F {
        ADDON = QUOTE([_this select 0] call FUNC(deregisterTower));
    };
    class Land_SatelliteAntenna_01_mounted_base_F {
        ADDON = QUOTE([_this select 0] call FUNC(deregisterTower));
    };
    class OmniDirectionalAntenna_01_base_F {
        ADDON = QUOTE([_this select 0] call FUNC(deregisterTower));
    };
    class RuggedTerminal_01_communications_F {
        ADDON = QUOTE([_this select 0] call FUNC(deregisterTower));
    };
    class RuggedTerminal_02_communications_F {
        ADDON = QUOTE([_this select 0] call FUNC(deregisterTower));
    };
    class RuggedTerminal_01_communications_hub_F {
        ADDON = QUOTE([_this select 0] call FUNC(deregisterTower));
    };
    class gm_shelteraceI_command_base {
        ADDON = QUOTE([_this select 0] call FUNC(deregisterTower));
    };
};
