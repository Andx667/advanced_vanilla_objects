// ArmaRadio (Live Radio) treats an object as a radio when its config has live_radio_interface_hasRadio
// set to 1, which it does for Air, Car, Tank, Boat_F and three of the vanilla radio objects. These are
// the ones it leaves out. Every class keeps its vanilla parent, a class reopened without one loses its
// inheritance. The ACE actions of the objects are added in XEH_postInit.sqf, the flag alone only makes
// ArmaRadio accept them.
class CfgVehicles {
    class Items_base_F;
    class Land_MobilePhone_smart_F: Items_base_F {
        live_radio_interface_hasRadio = 1;
    };

    // The base game laptops. Land_Laptop_unfolded_F also covers the scripted and the Intel laptops,
    // Land_Laptop_device_F and the other variants derived from it. The Argo and Contact laptops
    // are enabled in CfgEventHandlers.hpp.
    class Land_Laptop_F: Items_base_F {
        live_radio_interface_hasRadio = 1;
    };
    class Land_Laptop_unfolded_F: Items_base_F {
        live_radio_interface_hasRadio = 1;
    };
};
