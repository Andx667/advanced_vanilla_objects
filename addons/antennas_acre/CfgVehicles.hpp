// ACRE's ground spike antenna code only needs an AcreComponents class on the object; the vanilla
// classes below are the bases of every Contact variant (Olive/Black/Sand, small, mounted).
// acre_antennaPosFnc sits on the object class itself, that is where ACRE's findAntenna reads it.
// The Rugged terminal classes are already fully defined in avo_antennas (activeSources and the
// rest), they are reopened here only to add the ACRE-specific properties. Every class keeps its
// vanilla parent: a class reopened without one loses its inheritance ("Updating base class
// 'RuggedTerminal_Base_F'->''" in the RPT), the editor attributes and animation sources with it.
class CfgVehicles {
    class Items_base_F;
    class NonStrategic;
    class RuggedTerminal_Base_F;

    class Land_SatelliteAntenna_01_F: Items_base_F {
        acre_antennaPosFnc = QFUNC(antennaPos);
        class AcreComponents {
            componentName = QGVAR(satDish);
        };
    };
    class Land_SatelliteAntenna_01_mounted_base_F: NonStrategic {
        acre_antennaPosFnc = QFUNC(antennaPos);
        class AcreComponents {
            componentName = QGVAR(satDish);
        };
    };

    class OmniDirectionalAntenna_01_base_F: Items_base_F {
        acre_antennaPosFnc = QFUNC(antennaPos);
        class AcreComponents {
            componentName = QGVAR(omni);
        };
    };

    class RuggedTerminal_01_communications_F: RuggedTerminal_Base_F {
        acre_antennaPosFnc = QFUNC(antennaPos);
        class AcreComponents {
            componentName = QGVAR(satDish);
        };
    };
    class RuggedTerminal_02_communications_F: RuggedTerminal_Base_F {
        acre_antennaPosFnc = QFUNC(antennaPos);
        class AcreComponents {
            componentName = QGVAR(satDish);
        };
    };
    class RuggedTerminal_01_communications_hub_F: RuggedTerminal_Base_F {
        acre_antennaPosFnc = QFUNC(antennaPos);
        class AcreComponents {
            componentName = QGVAR(satDish);
        };
    };
};
