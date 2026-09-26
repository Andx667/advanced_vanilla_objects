// The inventory of a tent. The tents are buildings, they cannot hold cargo, so a tent gets one
// of these, invisible and attached to it, when its inventory is opened for the first time, see
// fnc_createContainer.sqf. It derives from ThingX like the plastic cases, so it has none of the
// ACE actions that boxes (ReammoBox_F) have.
class CfgVehicles {
    class ThingX;

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
