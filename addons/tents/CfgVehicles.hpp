// The holders of the packed tents, like the Item_* classes of the vanilla items. They
// are what lists an item in the Eden and Zeus object lists (Equipment, Items), an item alone is
// not listed there. They must not have a model of their own that looks like the tent: the engine
// also draws the model of the item in the holder, both are at the same place and flicker. So they
// show the item, as a dropped tent does, and the colour is the one of the item, see CfgWeapons.hpp.
class CfgVehicles {
    class ThingX;
    class Item_Base_F;

    class Item_avo_tents_solarOlive: Item_Base_F {
        author = AUTHOR;
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(solarOlive);
        vehicleClass = "Items";
        model = "\A3\Weapons_F\DummyItemHorizontal.p3d";

        class TransportItems {
            MACRO_ADDITEM(avo_tents_solarOlive,1);
        };
    };
    class Item_avo_tents_solarSand: Item_Base_F {
        author = AUTHOR;
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(solarSand);
        vehicleClass = "Items";
        model = "\A3\Weapons_F\DummyItemHorizontal.p3d";

        class TransportItems {
            MACRO_ADDITEM(avo_tents_solarSand,1);
        };
    };
    class Item_avo_tents_solarRedWhite: Item_Base_F {
        author = AUTHOR;
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(solarRedWhite);
        vehicleClass = "Items";
        model = "\A3\Weapons_F\DummyItemHorizontal.p3d";

        class TransportItems {
            MACRO_ADDITEM(avo_tents_solarRedWhite,1);
        };
    };
    class Item_avo_tents_solarBlueWhite: Item_Base_F {
        author = AUTHOR;
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(solarBlueWhite);
        vehicleClass = "Items";
        model = "\A3\Weapons_F\DummyItemHorizontal.p3d";

        class TransportItems {
            MACRO_ADDITEM(avo_tents_solarBlueWhite,1);
        };
    };
    class Item_avo_tents_dome: Item_Base_F {
        author = AUTHOR;
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(dome);
        vehicleClass = "Items";
        model = "\A3\Weapons_F\DummyItemHorizontal.p3d";

        class TransportItems {
            MACRO_ADDITEM(avo_tents_dome,1);
        };
    };
    class Item_avo_tents_a: Item_Base_F {
        author = AUTHOR;
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(a);
        vehicleClass = "Items";
        model = "\A3\Weapons_F\DummyItemHorizontal.p3d";

        class TransportItems {
            MACRO_ADDITEM(avo_tents_a,1);
        };
    };

    // The inventory of a tent. The tents are buildings, they cannot hold cargo, so a tent gets one
    // of these, invisible and attached to it, when its inventory is opened for the first time, see
    // fnc_createContainer.sqf. It derives from ThingX like the plastic cases, so it has none of the
    // ACE actions that boxes (ReammoBox_F) have.
    class GVAR(container): ThingX {
        author = AUTHOR;
        scope = 1;
        scopeCurator = 0;
        displayName = CSTRING(container);
        model = "\A3\Weapons_F\empty.p3d";
        destrType = "DestructNo";
        maximumLoad = 2000;
        transportMaxWeapons = 24;
        transportMaxMagazines = 128;
        transportMaxBackpacks = 12;

        class TransportItems {};
        class TransportMagazines {};
        class TransportWeapons {};
    };
};
