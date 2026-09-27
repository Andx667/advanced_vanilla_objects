// The GM command shelter class is already fully defined in avo_antennas_gm (activeSources and the
// rest), it is reopened here only to add the ACRE-specific properties, same as the Rugged
// terminals of avo_antennas_acre.
class CfgVehicles {
    class gm_shelteraceI_command_base {
        acre_antennaPosFnc = QEFUNC(antennas_acre,antennaPos);
        class AcreComponents {
            componentName = QGVAR(mast);
        };
    };
};
