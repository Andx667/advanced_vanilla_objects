#include "script_component.hpp"

if (!hasInterface) exitWith {};

// The functions of ArmaRadio are not public API, so bail out with a log line rather than throwing
// errors from the interaction menu if it ever renames them.
if (isNil "live_radio_interface_fnc_open") exitWith {
    WARNING("ArmaRadio interface functions not found, interactions disabled");
};

// Same action as the one ArmaRadio adds to its own objects, opened from outside. The condition is our
// own and not ArmaRadio's canOpen: older versions of ArmaRadio (the Workshop build before the radio
// expansion) make it fail for everything that is not a vehicle unless the "interact outside vehicle"
// setting is on, so the action would never show. Only the classes below get it, so being alive is
// all it needs to check. The label is ArmaRadio's, so it is translated like the rest of its interface.
private _action = [
    QGVAR(open),
    localize "STR_Live_Radio_Interface_DisplayName",
    "",
    {[_target] call live_radio_interface_fnc_open},
    {alive _target},
    {},
    [],
    {[_target] call EFUNC(common,interactionPosition)},
    5
] call ACEFUNC(interact_menu,createAction);

// A class that has ArmaRadio's own action in its config (its three objects, or one it adds later)
// is left out, it would show the action twice.
private _classes = [
    "Land_MobilePhone_smart_F",
    // Laptops. The unfolded one has the scripted, Intel and device variants, the 02 (Argo) has the
    // unfolded one and the 03 (Contact) has its colours and the closed ones.
    "Land_Laptop_F",
    "Land_Laptop_unfolded_F",
    "Land_Laptop_02_F",
    "Land_Laptop_03_base_F"
] select {
    !isClass (configFile >> "CfgVehicles" >> _x >> "ACE_Actions" >> "ACE_MainActions" >> "live_radio_interface_open")
};

{
    [_x, [], _action] call EFUNC(common,addClassActions);
} forEach _classes;
