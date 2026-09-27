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
// too: TFAR only cares about the position, not whether ACE can reach it. Rugged terminals and the
// GM command shelter antenna mast only register while active, including one already active when a
// client joins (clientInit runs for those too, closing the JIP gap the avo_antennas_activated/
// deactivated events in XEH_postInit.sqf alone would leave). gm_shelteraceI_command_base simply
// does not exist without Global Mobilization, so this is harmless without it.
class Extended_InitPost_EventHandlers {
    class Land_SatelliteAntenna_01_F {
        class ADDON {
            clientInit = QUOTE([_this select 0] call FUNC(registerTower));
        };
    };
    class Land_SatelliteAntenna_01_mounted_base_F {
        class ADDON {
            clientInit = QUOTE([_this select 0] call FUNC(registerTower));
        };
    };
    class OmniDirectionalAntenna_01_base_F {
        class ADDON {
            clientInit = QUOTE([_this select 0] call FUNC(registerTower));
        };
    };
    class RuggedTerminal_Base_F {
        class ADDON {
            clientInit = QUOTE(if ([_this select 0] call EFUNC(antennas,isActive)) then {[_this select 0] call FUNC(registerTower)});
        };
    };
    class gm_shelteraceI_command_base {
        class ADDON {
            clientInit = QUOTE(if ([_this select 0] call EFUNC(antennas,isActive)) then {[_this select 0] call FUNC(registerTower)});
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
    class RuggedTerminal_Base_F {
        ADDON = QUOTE([_this select 0] call FUNC(deregisterTower));
    };
    class gm_shelteraceI_command_base {
        ADDON = QUOTE([_this select 0] call FUNC(deregisterTower));
    };
};
