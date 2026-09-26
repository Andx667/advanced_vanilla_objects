#include "script_component.hpp"

// Every machine needs the tents, the server only makes inventories for these
[] call FUNC(scanItems);

// The server owns the inventories of the tents. It makes them, so two units that open the same
// tent for the first time never make two of them, and it decides when a tent is empty to pack
// up. It always answers the unit that asked, which is why nothing has to wait or time out.
if (isServer) then {
    [QGVAR(createContainer), {
        params [["_tent", objNull, [objNull]], ["_unit", objNull, [objNull]]];

        if (isNull _unit) exitWith {};

        [QGVAR(inventoryAnswer), [_tent, _unit, [_tent] call FUNC(createContainer)], _unit] call CBA_fnc_targetEvent;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(commitPackUp), FUNC(commitPackUp)] call CBA_fnc_addEventHandler;
};

if (!hasInterface) exitWith {};

// The answer of the server to the unit that opens the inventory of a tent, the container is
// objNull when the tent gets none, see avo_tents_fnc_createContainer
[QGVAR(inventoryAnswer), {
    params ["_tent", "_unit", "_container"];

    if (isNull _container) exitWith {
        [LLSTRING(inventoryFailed), true] call ACEFUNC(common,displayText);
    };

    [_tent, _unit, _container] call FUNC(openInventory);
}] call CBA_fnc_addEventHandler;

// The answer of the server to the unit that packs a tent up, see avo_tents_fnc_commitPackUp
[QGVAR(packUpAnswer), {
    params ["_tent", "_caller", "_empty"];

    if (isNull _tent) exitWith {
        [_caller] call FUNC(cancel);
    };

    if (_empty) exitWith {
        [_tent, _caller] call FUNC(finishPackUp);
    };

    // Something was put in at the last moment
    [_caller, _tent] call FUNC(cancel);
    [LLSTRING(notEmpty), true] call ACEFUNC(common,displayText);
}] call CBA_fnc_addEventHandler;

[] call FUNC(addActions);
