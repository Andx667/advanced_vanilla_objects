# Scripting & API

Mission makers and modders can react to the actions, prevent a tent from being packed up, add their own tents, and use the shared functions.

## Events

Every action raises a CBA event after it was used. They are raised with `CBA_fnc_globalEvent`, so they run on every machine, use `isServer` or `hasInterface` in the handler as needed. They are not raised when an object is changed with scripts (`animateSource`, ...) or in the editor.

| Event | Payload | Raised when |
| --- | --- | --- |
| `avo_animations_changed` | `[object, control, changes, unit]` | An animation action is used, see [below](#avo_animations_changed) |
| `avo_antennas_activated` | `[terminal, unit]` | A Rugged terminal is activated |
| `avo_antennas_deactivated` | `[terminal, unit]` | A Rugged terminal is deactivated |
| `avo_antennas_connected` | `[antenna, radioId, unit]` | A radio is connected to one of the antennas or terminals |
| `avo_antennas_disconnected` | `[antenna, unit, radioId]` | A radio is disconnected from one of them. `radioId` is `""` when ACRE does not tell it |
| `avo_tents_setUp` | `[tent, unit, item]` | A tent is set up from a tent item |
| `avo_tents_packedUp` | `[classname, posASL, [vectorDir, vectorUp], unit, item]` | A tent is packed up. The tent is deleted by then, its class and place are given instead |
| `avo_weather_read` | `[object, unit, windOnly]` | Weather data is read at a weather station, or the wind at a windsock (`windOnly` is `true`) |

`avo_antennas_connected` and `avo_antennas_disconnected` are relayed from ACRE's ground spike antenna events (`acre_sys_gsa_connectGsa` and `acre_sys_gsa_disconnectGsa`), only for the antennas of AVO.

There are no "before" events, actions cannot be cancelled.

```sqf
["avo_tents_setUp", {
    params ["_tent", "_unit", "_item"];

    if (isServer) then {
        systemChat format ["%1 set up %2", name _unit, typeOf _tent];
    };
}] call CBA_fnc_addEventHandler;
```

### `avo_animations_changed`

`control` is the id of the control that was used, `changes` are the animation sources and the phases they were set to, `[["Door_1_Hide", 1]]`.

| Objects | Controls |
| --- | --- |
| Cabinets, office table | `drawer1` to `drawer6` |
| Coffin (drawer) | `drawer` |
| Wooden coffin, decon and connector tents | `door1` to `door4` |
| Medical tent, fridge | `door` |
| Laptop, CBRN container, bucket | `lid` |
| Multi-screen computer | `screens` |
| Portable server | `rack` (server rack), `leds` (LED lights) |
| Solar panels | `yaw`, `pitch1`, `pitch2`. The phase is the angle in degrees |
| Transfer switch | `position1`, `position0`, `position2`, `lamp` |
| Data terminal | `antenna` |
| Flag pole | `flag` |

```sqf
["avo_animations_changed", {
    params ["_object", "_control", "_changes", "_unit"];

    if (isServer && {_control == "flag"}) then {
        systemChat format ["%1 moved the flag on %2", name _unit, typeOf _object];
    };
}] call CBA_fnc_addEventHandler;
```

## Variables

| Variable | Object | Description |
| --- | --- | --- |
| `avo_tents_canPackUp` | Placed tent | Set to `false` to prevent packing up this tent. Default `true` |

```sqf
_tent setVariable ["avo_tents_canPackUp", false, true];
```

## Adding tents

The tents addon scans `CfgWeapons` for classes with an `avo_tents_object` property, so another addon only needs a config item to add a tent. It is set up with the 3D placement and packed up again like the tents of AVO. Derive it from `avo_tents_base`:

```cpp
class CfgWeapons {
    class avo_tents_base;

    class MYTAG_myTent: avo_tents_base {
        scope = 2;
        displayName = "My Tent";
        avo_tents_object = "MyTentObjectClass";
    };
};
```

The addon has to require `avo_tents`. The item is only used when the object class exists.

## Functions

The `avo_common` addon has functions for other addons that add actions to objects.

### `avo_common_fnc_addClassActions`

Adds an ACE interaction to a class and every class derived from it. Does the same as `ace_interact_menu_fnc_addActionToClass` with inheritance, but adds the action to each class by name. ACE's inheritance only reaches objects that run CBA's extended event handlers, and classes that define their own `EventHandlers` class do not, so they never get the action. Call it in `postInit`.

| Argument | Type | Description |
| --- | --- | --- |
| 0 | `STRING` | Base class in `CfgVehicles` |
| 1 | `ARRAY` | Parent path of the action, `[]` for the top level |
| 2 | `ARRAY` | Action from `ace_interact_menu_fnc_createAction` |
| 3 | `ARRAY of STRING` | Classes that are left out, with everything derived from them (default `[]`) |

### `avo_common_fnc_interactionPosition`

The point for an ACE interaction on an object, for the position code of `ace_interact_menu_fnc_createAction`. It depends on the size of the object, see [Where the action is](usage.md#where-the-action-is).

| Argument | Type | Description |
| --- | --- | --- |
| 0 | `OBJECT` | Object |
| 1 | `ARRAY of STRING` | Names of selections or memory points where the change happens, the first one the model has is used, for big objects (default `[]`) |

Returns the position in model space of the object.

```sqf
{[_target] call avo_common_fnc_interactionPosition}
```

### `avo_common_fnc_topPosition`

The position of the top centre of an object's bounding box, in ASL. Follows the object's orientation.

| Argument | Type | Description |
| --- | --- | --- |
| 0 | `OBJECT` | Object |
| 1 | `NUMBER` | Offset above the top, in model space (default `0`) |

```sqf
[cursorObject, 0.5] call avo_common_fnc_topPosition
```

## Config

| Property | Class | Description |
| --- | --- | --- |
| `avo_antennas_activeSources[]` | `CfgVehicles` | Animation sources that switch an antenna object on, used by the Rugged communications terminals. The first one marks the state and has to be above 0 |
| `avo_tents_object` | `CfgWeapons` | Tent object class an item sets up, see [Adding tents](#adding-tents) |
