#include "..\script_component.hpp"
/*
 * Author: Andx
 * Adds ACE interactions to the Rugged solar panels to rotate the panels and tilt each of the
 * two panels in steps, which could only be done with editor attributes. The sources and
 * their limits (in degrees) are the ones of those attributes. Uses the animation and source
 * check of the animations addon.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call avo_animations_solar_fnc_addActions
 *
 * Public: No
 */

private _iconUp = "\A3\ui_f\data\igui\cfg\actions\ladderup_ca.paa";
private _iconDown = "\A3\ui_f\data\igui\cfg\actions\ladderdown_ca.paa";

// [id, name, wording of a step in the positive and the negative direction, source, step, minimum, maximum]
private _controls = [
    ["yaw", LLSTRING(noun_solarPanels), [LLSTRING(rotateRight), LLSTRING(rotateLeft)], "Panels_Yaw", 30, -180, 180],
    ["pitch1", format [LLSTRING(noun_panelN), 1], [LLSTRING(tiltUp), LLSTRING(tiltDown)], "Panel_1_Pitch", 15, -45, 45],
    ["pitch2", format [LLSTRING(noun_panelN), 2], [LLSTRING(tiltUp), LLSTRING(tiltDown)], "Panel_2_Pitch", 15, -45, 45]
];

private _position = {[_target] call EFUNC(common,interactionPosition)};
private _distance = 4;

private _statement = {
    params ["_target", "_player", "_params"];
    _params params ["_source", "_delta", "_min", "_max", "_id"];

    // Instant, the time in the config is for a change of 1, a step is much more than that
    private _phase = ((_target animationSourcePhase _source) + _delta) min _max max _min;
    [QEGVAR(animations,animate), [_target, [[_source, _phase, true]]], _target] call CBA_fnc_targetEvent;
    [QEGVAR(animations,changed), [_target, _id, [[_source, _phase]], _player]] call CBA_fnc_globalEvent;
};
private _condition = {
    params ["_target", "_player", "_params"];
    _params params ["_source", "_delta", "_min", "_max"];

    GVAR(enabled)
    && {[_target, [_source]] call EFUNC(animations,hasSources)}
    && {
        private _phase = _target animationSourcePhase _source;
        if (_delta > 0) then {_phase < _max - 0.01} else {_phase > _min + 0.01}
    }
};

// One sub menu, the actions would be at the same point otherwise
private _group = [
    QGVAR(panels),
    LLSTRING(group_panels),
    "",
    {},
    {
        params ["_target"];
        GVAR(enabled) && {[_target, ["Panels_Yaw", "Panel_1_Pitch", "Panel_2_Pitch"], true] call EFUNC(animations,hasSources)}
    },
    {},
    [],
    _position,
    _distance
] call ACEFUNC(interact_menu,createAction);

["Land_SolarPanel_04_base_F", [], _group] call EFUNC(common,addClassActions);

{
    _x params ["_id", "_noun", "_labels", "_source", "_size", "_min", "_max"];
    _labels params ["_labelPlus", "_labelMinus"];

    private _plus = [
        format ["%1_%2_plus", QGVAR(step), _id],
        format [_labelPlus, _noun],
        _iconUp,
        _statement,
        _condition,
        {},
        [_source, _size, _min, _max, _id],
        _position,
        _distance
    ] call ACEFUNC(interact_menu,createAction);

    private _minus = [
        format ["%1_%2_minus", QGVAR(step), _id],
        format [_labelMinus, _noun],
        _iconDown,
        _statement,
        _condition,
        {},
        [_source, -_size, _min, _max, _id],
        _position,
        _distance
    ] call ACEFUNC(interact_menu,createAction);

    ["Land_SolarPanel_04_base_F", [QGVAR(panels)], _plus] call EFUNC(common,addClassActions);
    ["Land_SolarPanel_04_base_F", [QGVAR(panels)], _minus] call EFUNC(common,addClassActions);
} forEach _controls;
