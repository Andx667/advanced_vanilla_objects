#include "..\script_component.hpp"
/*
 * Author: Andx, ACE Team
 * Starts the progress bar for setting up a tent once its 3D placement has been confirmed.
 *
 * Arguments:
 * 0: Caller <OBJECT>
 * 1: Tent item classname <STRING>
 * 2: Tent object classname <STRING>
 * 3: Confirmed placement position (ASL) <ARRAY>
 * 4: Confirmed placement [vectorDir, vectorUp] <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "avo_tents_dome", "Land_TentDome_F", getPosASL player, [[0, 1, 0], [0, 0, 1]]] call avo_tents_fnc_startBuild
 *
 * Public: No
 */

params ["_caller", "_item", "_classname", "_posASL", "_vectorDirAndUp"];

_caller playMove "Acts_carFixingWheel";

[
    GVAR(buildTime),
    [_caller, _item, _classname, _posASL, _vectorDirAndUp],
    {
        (_this select 0) call FUNC(construct);
    },
    {
        (_this select 0) params ["_caller"];
        [_caller] call FUNC(cancel);
    },
    LLSTRING(progressSetUp)
] call ACEFUNC(common,progressBar);
