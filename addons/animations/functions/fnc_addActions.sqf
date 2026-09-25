#include "..\script_component.hpp"
/*
 * Author: Andx
 * Adds ACE interactions to vanilla objects that have animations, but no way to change them
 * in the game. Most of them can only be changed with attributes in the editor. The sources
 * and phases are the ones of those editor attributes.
 *
 * The actions are added to base classes and everything derived from them, and only shown for
 * the variants that have the animation sources they need, see avo_animations_fnc_hasSources.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call avo_animations_fnc_addActions
 *
 * Public: No
 */

// Where the actions are: the point of the model closest to the player. The centre of a tall
// or big model (flag pole, tents) is out of reach, and inside of a closed tent.
private _position = {[_target] call EFUNC(common,interactionPosition)};
private _distance = 4;

private _iconOpen = "\A3\Ui_f\data\IGUI\Cfg\Actions\open_door_ca.paa";
private _iconOn = "\a3\ui_f\data\IGUI\Cfg\Actions\ico_ON_ca.paa";
private _iconOff = "\a3\ui_f\data\IGUI\Cfg\Actions\ico_OFF_ca.paa";
private _iconUp = "\A3\ui_f\data\igui\cfg\actions\ladderup_ca.paa";
private _iconDown = "\A3\ui_f\data\igui\cfg\actions\ladderdown_ca.paa";

// Wordings of the two directions of a control: the label of the change to the second state
// (B), the label of the change back to the first state (A), and their icons
private _open = [LLSTRING(open), LLSTRING(close), _iconOpen, _iconOpen];
private _extend = [LLSTRING(extend), LLSTRING(retract), _iconOn, _iconOff];
private _raise = [LLSTRING(raise), LLSTRING(lower), _iconUp, _iconDown];
private _turnOn = [LLSTRING(turnOn), LLSTRING(turnOff), _iconOn, _iconOff];
private _turnOff = [LLSTRING(turnOff), LLSTRING(turnOn), _iconOff, _iconOn];
// Wordings of a step in the positive and the negative direction
private _rotate = [LLSTRING(rotateRight), LLSTRING(rotateLeft), _iconUp, _iconDown];
private _tilt = [LLSTRING(tiltUp), LLSTRING(tiltDown), _iconUp, _iconDown];

// Numbers from the first to the last one
private _range = {
    params ["_first", "_last"];

    private _numbers = [];
    for "_i" from _first to _last do {
        _numbers pushBack _i;
    };
    _numbers
};

// --- Controls. Each returns the ACE actions and the animation sources that show it can be used ---

// Switches between two states with the given phases of one or more sources. The state is read
// from the first source.
// Sources: [[source, phase of state A, phase of state B], ...]. A change of a whole unit is
// done in the time set in the config of the source, phases beyond that take longer, so
// those can be set to be instant.
private _toggle = {
    params ["_id", "_noun", "_verbs", "_sources", ["_instant", false]];
    _verbs params ["_labelB", "_labelA", "_iconB", "_iconA"];

    private _names = _sources apply {_x select 0};

    private _statement = {
        params ["_target", "_player", "_params"];
        _params params ["_sources", "_names", "_index", "_instant"];

        [QGVAR(animate), [_target, _sources apply {[_x select 0, _x select _index, _instant]}], _target] call CBA_fnc_targetEvent;
    };
    // Index 2 changes to B and is shown in A, index 1 changes to A and is shown in B
    private _condition = {
        params ["_target", "_player", "_params"];
        _params params ["_sources", "_names", "_index"];

        GVAR(enabled)
        && {[_target, _names] call FUNC(hasSources)}
        && {([_target, _sources] call FUNC(inState)) isEqualTo (_index == 1)}
    };

    [
        [
            [format ["%1_%2_b", QGVAR(toggle), _id], format [_labelB, _noun], _iconB, _statement, _condition, {}, [_sources, _names, 2, _instant], _position, _distance] call ACEFUNC(interact_menu,createAction),
            [format ["%1_%2_a", QGVAR(toggle), _id], format [_labelA, _noun], _iconA, _statement, _condition, {}, [_sources, _names, 1, _instant], _position, _distance] call ACEFUNC(interact_menu,createAction)
        ],
        _names
    ]
};

// Sets a source to a phase, for controls with more than two positions
private _set = {
    params ["_id", "_label", "_source", "_value"];

    private _statement = {
        params ["_target", "_player", "_params"];
        _params params ["_source", "_value"];

        [QGVAR(animate), [_target, [[_source, _value]]], _target] call CBA_fnc_targetEvent;
    };
    private _condition = {
        params ["_target", "_player", "_params"];
        _params params ["_source", "_value"];

        GVAR(enabled)
        && {[_target, [_source]] call FUNC(hasSources)}
        && {abs ((_target animationSourcePhase _source) - _value) > 0.25}
    };

    [
        [
            [format ["%1_%2", QGVAR(set), _id], _label, _iconOn, _statement, _condition, {}, [_source, _value], _position, _distance] call ACEFUNC(interact_menu,createAction)
        ],
        [_source]
    ]
};

// Turns a source by a step in either direction, until it reaches its limits (in the unit of the source)
private _step = {
    params ["_id", "_noun", "_verbs", "_source", "_size", "_min", "_max"];
    _verbs params ["_labelPlus", "_labelMinus", "_iconPlus", "_iconMinus"];

    private _statement = {
        params ["_target", "_player", "_params"];
        _params params ["_source", "_delta", "_min", "_max"];

        // Instant, the time in the config is for a change of 1, a step is much more than that
        private _phase = ((_target animationSourcePhase _source) + _delta) min _max max _min;
        [QGVAR(animate), [_target, [[_source, _phase, true]]], _target] call CBA_fnc_targetEvent;
    };
    private _condition = {
        params ["_target", "_player", "_params"];
        _params params ["_source", "_delta", "_min", "_max"];

        GVAR(enabled)
        && {[_target, [_source]] call FUNC(hasSources)}
        && {
            private _phase = _target animationSourcePhase _source;
            if (_delta > 0) then {_phase < _max - 0.01} else {_phase > _min + 0.01}
        }
    };

    [
        [
            [format ["%1_%2_plus", QGVAR(step), _id], format [_labelPlus, _noun], _iconPlus, _statement, _condition, {}, [_source, _size, _min, _max], _position, _distance] call ACEFUNC(interact_menu,createAction),
            [format ["%1_%2_minus", QGVAR(step), _id], format [_labelMinus, _noun], _iconMinus, _statement, _condition, {}, [_source, -_size, _min, _max], _position, _distance] call ACEFUNC(interact_menu,createAction)
        ],
        [_source]
    ]
};

// --- Registration ---

// Adds the controls to the classes and the classes derived from them, in a sub menu when a group
// ([id, name]) is given. The sub menu is only shown for variants that have at least one of the
// sources of its controls. Actions that can be shown together have to be in a group, or their
// interaction points would be at the same place.
private _register = {
    params ["_classes", "_group", "_controls", ["_excluded", []]];

    private _path = [];

    if (_group isNotEqualTo []) then {
        _group params ["_groupId", "_groupName"];

        private _names = [];
        {
            _names append (_x select 1);
        } forEach _controls;

        private _groupAction = [
            format ["%1_%2", QGVAR(group), _groupId],
            _groupName,
            "",
            {},
            {
                params ["_target", "_player", "_params"];
                GVAR(enabled) && {[_target, _params, true] call FUNC(hasSources)}
            },
            {},
            _names,
            _position,
            _distance
        ] call ACEFUNC(interact_menu,createAction);

        {
            [_x, [], _groupAction, _excluded] call EFUNC(common,addClassActions);
        } forEach _classes;

        _path = [format ["%1_%2", QGVAR(group), _groupId]];
    };

    {
        private _actions = _x select 0;
        {
            private _action = _x;
            {
                [_x, _path, _action, _excluded] call EFUNC(common,addClassActions);
            } forEach _classes;
        } forEach _actions;
    } forEach _controls;
};

// --- Objects ---

private _groupControls = ["controls", LLSTRING(group_controls)];
private _groupDoors = ["doors", LLSTRING(group_doors)];

// Contact transfer switch. The switch has three positions.
[["Land_TransferSwitch_01_base_F"], _groupControls, [
    ["position1", LLSTRING(switchPosition1), "SwitchPosition", 1] call _set,
    ["position0", LLSTRING(switchPositionOff), "SwitchPosition", 0] call _set,
    ["position2", LLSTRING(switchPosition2), "SwitchPosition", -1] call _set,
    ["lamp", LLSTRING(noun_indicatorLamp), _turnOn, [["SwitchLight", 0, 1]]] call _toggle
]] call _register;

// Contact portable cabinets. The 7 drawer cabinet has one drawer that does not move.
private _drawers = {
    params ["_first", "_last"];

    ([_first, _last] call _range) apply {
        [format ["drawer%1", _x], format [LLSTRING(noun_drawerN), _x], _open, [[format ["Drawer_%1_move_source", _x], 0, 1]]] call _toggle
    }
};

[["Land_PortableCabinet_01_4drawers_base_F"], ["drawers", LLSTRING(group_drawers)], [1, 4] call _drawers] call _register;
[["Land_PortableCabinet_01_7drawers_base_F"], ["drawers", LLSTRING(group_drawers)], [2, 6] call _drawers] call _register;
[["Land_PortableCabinet_01_medical_base_F"], ["drawers", LLSTRING(group_drawers)], [1, 6] call _drawers] call _register;

// Office table
[["Land_OfficeTable_01_F"], ["drawers", LLSTRING(group_drawers)], [
    ["drawer1", format [LLSTRING(noun_drawerN), 1], _open, [["Drawer_1_source", 0, 1]]] call _toggle,
    ["drawer2", format [LLSTRING(noun_drawerN), 2], _open, [["Drawer_2_source", 0, 1]]] call _toggle
]] call _register;

// Contact portable server
// The covers of the server are separate objects that have none of this
[["Land_PortableServer_01_base_F"], _groupControls, [
    ["rack", LLSTRING(noun_serverRack), _extend, [["Server_Move_Source", 0, 1]]] call _toggle,
    ["leds", LLSTRING(noun_leds), _turnOff, [["Lights_Off_Source", 0, 1]]] call _toggle
], ["Land_PortableServer_01_cover_base_F"]] call _register;

// Contact portable solar panels
[["Land_SolarPanel_04_base_F"], ["panels", LLSTRING(group_panels)], [
    ["yaw", LLSTRING(noun_solarPanels), _rotate, "Panels_Yaw", 30, -180, 180] call _step,
    ["pitch1", format [LLSTRING(noun_panelN), 1], _tilt, "Panel_1_Pitch", 15, -45, 45] call _step,
    ["pitch2", format [LLSTRING(noun_panelN), 2], _tilt, "Panel_2_Pitch", 15, -45, 45] call _step
]] call _register;

// Coffins
[["Coffin_01_animated_base_F"], _groupDoors, [
    ["door1", format [LLSTRING(noun_doorN), 1], _open, [["Door1_Rotation", 0, 1]]] call _toggle,
    ["door2", format [LLSTRING(noun_doorN), 2], _open, [["Door2_Rotation", 0, 1]]] call _toggle
]] call _register;
[["Coffin_02_animated_base_F"], [], [
    ["drawer", LLSTRING(noun_drawer), _open, [["Drawer_1_move_source", 0, 1]]] call _toggle
]] call _register;

// Flag pole
[["PortableFlagPole_01_F"], [], [
    ["flag", LLSTRING(noun_flag), _raise, [["Flag_source", 0, 1]]] call _toggle
]] call _register;

// Tent doors. The door leaf is hidden when the door is open.
[["Land_DeconTent_01_base_F"], _groupDoors, [
    ["door1", format [LLSTRING(noun_doorN), 1], _open, [["Door_1_Hide", 0, 1]]] call _toggle,
    ["door2", format [LLSTRING(noun_doorN), 2], _open, [["Door_2_Hide", 0, 1]]] call _toggle
]] call _register;
[["Land_ConnectorTent_01_base_F"], _groupDoors, ([1, 4] call _range) apply {
    [format ["door%1", _x], format [LLSTRING(noun_doorN), _x], _open, [[format ["Door_%1_Hide", _x], 0, 1]]] call _toggle
}] call _register;
// The outer tents are the tent without the door, but their config has the source of the base
private _outerTents = ("configName _x regexMatch 'Land_MedicalTent_01_.*_outer_F'" configClasses (configFile >> "CfgVehicles")) apply {configName _x};
[["Land_MedicalTent_01_base_F"], [], [
    ["door", LLSTRING(noun_door), _open, [["Door_Hide", 0, 1]]] call _toggle
], _outerTents] call _register;

// Fridge
[["Land_Fridge_01_F"], [], [
    ["door", LLSTRING(noun_door), _open, [["Door_1_sound_source", 0, 1]]] call _toggle
]] call _register;

// Laptop and computer. The lid of the laptop is open at 1, the screens of the computer at 0.
[["Land_Laptop_02_F"], [], [
    ["lid", LLSTRING(noun_laptop), _open, [["Lid", 0, 1]]] call _toggle
]] call _register;
[["Land_MultiScreenComputer_01_base_F"], [], [
    ["screens", LLSTRING(noun_computer), _open, [["Open_Source", 1, 0]]] call _toggle
]] call _register;

// Lids of containers, they are hidden when open
[["CBRNContainer_01_base_F"], [], [
    ["lid", LLSTRING(noun_lid), _open, [["Hide_Lid", 0, 1]]] call _toggle
]] call _register;
[["Land_PlasticBucket_01_base_F"], [], [
    ["lid", LLSTRING(noun_lid), _open, [["Lid_Hide", 0, 1]]] call _toggle
]] call _register;

// Contact data terminal
[["Land_DataTerminal_01_F"], [], [
    ["antenna", LLSTRING(noun_antenna), _extend, [["Antenna_source", 0, 1]]] call _toggle
]] call _register;
