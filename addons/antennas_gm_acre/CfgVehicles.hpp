// The GM command shelter class is already fully defined in avo_antennas_gm (activeSources and the
// rest), it is reopened here only to add the ACRE-specific properties, same as the Rugged
// terminals of avo_antennas_acre. It keeps its GM parent: a class reopened without one loses its
// inheritance ("Updating base class 'gm_shelteraceI_base'->''" in the RPT).
class CfgVehicles {
    class gm_shelteraceI_base;

    class gm_shelteraceI_command_base: gm_shelteraceI_base {
        acre_antennaPosFnc = QEFUNC(antennas_acre,antennaPos);
        class AcreComponents {
            componentName = QGVAR(mast);
        };
    };
};
