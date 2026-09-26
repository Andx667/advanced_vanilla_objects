// The command shelters of Global Mobilization (all nations, they share this base) have an
// antenna mast as an option: "antennaMast_01_unhide" shows the antenna, and the elevate
// trigger extends it (only useful with the antenna, the GM config resets it without). Raising the
// mast works like activating a Rugged terminal, see the actions in XEH_postInit.sqf. The GM
// sources are 0 to 1, so the animation goes to exactly 1: their trigger only extends the mast on 1.
class CfgVehicles {
    class gm_shelteraceI_base;

    class gm_shelteraceI_command_base: gm_shelteraceI_base {
        acre_antennaPosFnc = QEFUNC(antennas,antennaPos);
        EGVAR(antennas,requiredSources)[] = {"antennaMast_01_unhide"};
        EGVAR(antennas,activeSources)[] = {"antennamast_01_elev_trigger", "antennamast_01_elev_source"};
        EGVAR(antennas,activePhase) = 1;
        class AcreComponents {
            componentName = QGVAR(mast);
        };
    };
};
