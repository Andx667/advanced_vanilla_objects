class CfgAcreComponents {
    class ACRE_243CM_VHF_TNC;

    // Inherit connector type and gain pattern from ACRE's ground spike antenna.
    // `height` is 0 because the antenna position comes from acre_antennaPosFnc
    // (the real tip of the model), see fnc_antennaPos.sqf.
    class avo_antennas_satDish: ACRE_243CM_VHF_TNC {
        name = "Satellite Antenna";
        shortName = "Satellite Antenna";
        height = 0;
        compatibleRadios[] = {"ACRE_PRC117F", "ACRE_PRC152"};
    };

    class avo_antennas_omni: ACRE_243CM_VHF_TNC {
        name = "Omni-Directional Antenna";
        shortName = "Omni Antenna";
        height = 0;
        compatibleRadios[] = {"ACRE_PRC117F", "ACRE_PRC152"};
    };
};
