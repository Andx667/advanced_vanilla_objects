class CfgAcreComponents {
    class ACRE_243CM_VHF_TNC;

    // Same connector type, gain pattern and radios as the antennas of avo_antennas. `height` is 0
    // because the antenna position comes from acre_antennaPosFnc, set in CfgVehicles.hpp.
    class GVAR(mast): ACRE_243CM_VHF_TNC {
        name = "Antenna Mast";
        shortName = "Antenna Mast";
        height = 0;
        compatibleRadios[] = {"ACRE_PRC117F", "ACRE_PRC152"};
    };
};
