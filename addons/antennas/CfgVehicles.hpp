// The Rugged communications terminals only work once activated. The "Open terminal" editor
// attribute does that by raising the Terminal_source animation source (and its sound sources).
// GVAR(activeSources) lists them: the first one marks the state and has to be above 0 (see
// fnc_isActive.sqf), all of them are animated by fnc_setActive.sqf. This is the only thing
// comms-agnostic about the vanilla antennas; the satellite dishes and omni-directional antennas
// are always active and have nothing generic to declare here, see avo_antennas_acre for their
// CfgVehicles entries (acre_antennaPosFnc, AcreComponents) and connect/disconnect actions.
class CfgVehicles {
    class RuggedTerminal_Base_F;

    class RuggedTerminal_01_communications_F: RuggedTerminal_Base_F {
        GVAR(activeSources)[] = {"Terminal_source", "Terminal_source_sound"};
    };
    class RuggedTerminal_02_communications_F: RuggedTerminal_Base_F {
        GVAR(activeSources)[] = {"Terminal_source", "Terminal_source_sound"};
    };
    class RuggedTerminal_01_communications_hub_F: RuggedTerminal_Base_F {
        GVAR(activeSources)[] = {"Terminal_source", "Terminal_source_sound", "Terminal_source_sound_case_01", "Terminal_source_sound_case_02"};
    };
};
