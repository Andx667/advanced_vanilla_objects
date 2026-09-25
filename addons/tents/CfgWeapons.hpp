// Packed tents. A tent is set up from an item that names the tent object it places in
// GVAR(object); fnc_addActions.sqf scans CfgWeapons for that property, so other addons
// (e.g. tents_bwa3) only need to define a config item to add another tent.
class CfgWeapons {
    class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;

    class GVAR(base): CBA_MiscItem {
        author = AUTHOR;
        scope = 0;
        displayName = "";
        descriptionShort = CSTRING(description);
        // Ground model of the packed tent. A CfgWeapons model cannot carry per colour textures,
        // so every tent uses the folded solar tent.
        model = "\a3\Props_F_Enoch\Military\Camps\TentSolar_01_folded_F.p3d";
        picture = "\A3\Weapons_F\Ammoboxes\Bags\data\UI\icon_B_C_Kitbag_rgr.paa";

        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 100;
        };
    };

    class GVAR(solarOlive): GVAR(base) {
        scope = 2;
        displayName = CSTRING(solarOlive);
        GVAR(object) = "Land_TentSolar_01_olive_F";
    };
    class GVAR(solarSand): GVAR(base) {
        scope = 2;
        displayName = CSTRING(solarSand);
        picture = "\A3\Weapons_F\Ammoboxes\Bags\data\UI\icon_B_C_Kitbag_tan_ca.paa";
        GVAR(object) = "Land_TentSolar_01_sand_F";
    };
    class GVAR(solarRedWhite): GVAR(base) {
        scope = 2;
        displayName = CSTRING(solarRedWhite);
        GVAR(object) = "Land_TentSolar_01_redwhite_F";
    };
    class GVAR(solarBlueWhite): GVAR(base) {
        scope = 2;
        displayName = CSTRING(solarBlueWhite);
        GVAR(object) = "Land_TentSolar_01_bluewhite_F";
    };
    class GVAR(dome): GVAR(base) {
        scope = 2;
        displayName = CSTRING(dome);
        GVAR(object) = "Land_TentDome_F";
    };
    class GVAR(a): GVAR(base) {
        scope = 2;
        displayName = CSTRING(a);
        GVAR(object) = "Land_TentA_F";
    };
};
