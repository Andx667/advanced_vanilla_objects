#include "..\script_component.hpp"
/*
 * Author: Andx
 * Checks which of the two states of a toggled animation an object is in, judged by the
 * first source: the state its phase is closer to. While an animation is still running,
 * that is the state it is moving towards once it is past the middle.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Sources <ARRAY>
 *   0: Animation source <STRING>
 *   1: Phase of the first state (A) <NUMBER>
 *   2: Phase of the second state (B) <NUMBER>
 *
 * Return Value:
 * In the second state (B) <BOOL>
 *
 * Example:
 * [cursorObject, [["Lid", 0, 1]]] call avo_animations_fnc_inState
 *
 * Public: No
 */

params ["_object", "_sources"];

(_sources select 0) params ["_source", "_phaseA", "_phaseB"];

private _phase = _object animationSourcePhase _source;

abs (_phase - _phaseB) < abs (_phase - _phaseA)
