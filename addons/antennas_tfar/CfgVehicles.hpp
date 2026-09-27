// CBA switches its Extended Event Handlers off for everything derived from Static, and the mounted
// satellite dishes and the Rugged terminals are, so the InitPost and Deleted handlers of
// CfgEventHandlers.hpp would never run for them. XEH_ENABLED switches them back on for these classes
// only, the same way CBA does for Land_Communication_F, the base of TFAR's own radio tower. The
// terminals keep their vanilla init event handler, XEH is added next to it. Every class keeps its
// vanilla parent, a class reopened without one loses its inheritance.
class CfgVehicles {
    class NonStrategic;
    class RuggedTerminal_Base_F;

    class Land_SatelliteAntenna_01_mounted_base_F: NonStrategic {
        XEH_ENABLED;
    };

    class RuggedTerminal_01_communications_F: RuggedTerminal_Base_F {
        XEH_ENABLED;
    };
    class RuggedTerminal_02_communications_F: RuggedTerminal_Base_F {
        XEH_ENABLED;
    };
    class RuggedTerminal_01_communications_hub_F: RuggedTerminal_Base_F {
        XEH_ENABLED;
    };
};
