// ACRE's ground spike antenna code only needs an AcreComponents class on the
// object; the vanilla classes below are the bases of every Contact variant
// (Olive/Black/Sand, small, mounted). acre_antennaPosFnc sits on the object
// class itself, that is where ACRE's findAntenna reads it.
//
// The Rugged communications terminals only work once activated. The "Open terminal"
// editor attribute does that by raising the Terminal_source animation source, so
// GVAR(activeSource) names the source that has to be above 0 (see fnc_isActive.sqf).
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
        GVAR(activeSource) = "Terminal_source";
        class AcreComponents {
            componentName = QGVAR(satDish);
        };
    };
    class RuggedTerminal_02_communications_F: RuggedTerminal_Base_F {
        acre_antennaPosFnc = QFUNC(antennaPos);
        GVAR(activeSource) = "Terminal_source";
        class AcreComponents {
            componentName = QGVAR(satDish);
        };
    };
    class RuggedTerminal_01_communications_hub_F: RuggedTerminal_Base_F {
        acre_antennaPosFnc = QFUNC(antennaPos);
        GVAR(activeSource) = "Terminal_source";
        class AcreComponents {
            componentName = QGVAR(satDish);
        };
    };
};
