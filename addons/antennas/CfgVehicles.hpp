// ACRE's ground spike antenna code only needs an AcreComponents class on the
// object; the vanilla classes below are the bases of every Contact variant
// (Olive/Black/Sand, small, mounted). acre_antennaPosFnc sits on the object
// class itself, that is where ACRE's findAntenna reads it.
class CfgVehicles {
    class Items_base_F;
    class NonStrategic;

    class Land_SatelliteAntenna_01_F: Items_base_F {
        acre_antennaPosFnc = "avo_antennas_fnc_antennaPos";
        class AcreComponents {
            componentName = "avo_antennas_satDish";
        };
    };
    class Land_SatelliteAntenna_01_mounted_base_F: NonStrategic {
        acre_antennaPosFnc = "avo_antennas_fnc_antennaPos";
        class AcreComponents {
            componentName = "avo_antennas_satDish";
        };
    };

    class OmniDirectionalAntenna_01_base_F: Items_base_F {
        acre_antennaPosFnc = "avo_antennas_fnc_antennaPos";
        class AcreComponents {
            componentName = "avo_antennas_omni";
        };
    };
};
