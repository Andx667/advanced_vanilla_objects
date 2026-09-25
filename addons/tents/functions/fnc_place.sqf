#include "..\script_component.hpp"
/*
 * Author: Andx, ACE Team
 * Shows a local-only ghost preview of the tent that follows the caller's view and can be
 * rotated with the mouse wheel. Confirming with the default action key (usually left mouse
 * button) hands the confirmed position and orientation to the build progress bar, right
 * mouse button cancels the placement instead of raising the weapon.
 * Adapted from the tactical-tarps deployable framework, see functions\readme.md.
 *
 * Arguments:
 * 0: Caller <OBJECT>
 * 1: Tent item classname <STRING>
 * 2: Tent object classname <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "avo_tents_dome", "Land_TentDome_F"] call avo_tents_fnc_place
 *
 * Public: No
 */

params ["_caller", "_item", "_classname"];

private _ghost = _classname createVehicleLocal [0, 0, 0];
_ghost enableSimulationGlobal false;
_ghost allowDamage false;
_ghost disableCollisionWith _caller;

(boundingBoxReal _ghost) params ["_bbMin", "_bbMax"];
private _distance = (((_bbMax select 0) - (_bbMin select 0)) max ((_bbMax select 1) - (_bbMin select 1))) / 2 + 1.5;

private _updateGhostTransform = {
    private _basePos = (eyePos _caller) vectorAdd ((getCameraViewDirection _caller) vectorMultiply _distance);
    _basePos set [2, getTerrainHeightASL _basePos];

    _ghost setPosASL _basePos;
    _ghost setDir (GVAR(placeRotation) + getDir _caller);
    _ghost setVectorUp (surfaceNormal _basePos);
};

GVAR(placeState) = PLACE_WAITING;
GVAR(placeRotation) = 0;
call _updateGhostTransform;

[LLSTRING(placeConfirm), LLSTRING(placeCancel), LLSTRING(placeRotate)] call ACEFUNC(interaction,showMouseHint);

private _confirmId = [_caller, "DefaultAction", {GVAR(placeState) == PLACE_WAITING}, {GVAR(placeState) = PLACE_APPROVE}] call ACEFUNC(common,addActionEventHandler);

private _scrollDisplay = findDisplay 46;
private _scrollEventId = _scrollDisplay displayAddEventHandler ["MouseZChanged", {
    params ["", "_delta"];
    GVAR(placeRotation) = GVAR(placeRotation) + (_delta * 15);
    true
}];

// Consume RMB ourselves so it cancels placement instead of raising the weapon
private _cancelEventId = _scrollDisplay displayAddEventHandler ["MouseButtonDown", {
    params ["", "_button"];
    if (_button == 1) then {GVAR(placeState) = PLACE_CANCEL};
    _button == 1
}];

[{
    params ["_args", "_pfID"];
    _args params ["_caller", "_item", "_classname", "_ghost", "_confirmId", "_cancelEventId", "_scrollDisplay", "_scrollEventId", "_updateGhostTransform", "_distance"];

    if (_caller != ACE_player || {!alive _caller} || {isNull _ghost} || {!(_item in items _caller)}) then {
        GVAR(placeState) = PLACE_CANCEL;
    };

    // Reject an invalid spot but keep the loop running so the caller can try again
    if (GVAR(placeState) == PLACE_APPROVE && {surfaceIsWater getPosASL _ghost}) then {
        [LLSTRING(hintErrorNoSpace), true] call ACEFUNC(common,displayText);
        GVAR(placeState) = PLACE_WAITING;
    };

    if (GVAR(placeState) != PLACE_WAITING) exitWith {
        [_pfID] call CBA_fnc_removePerFrameHandler;

        call ACEFUNC(interaction,hideMouseHint);
        [_caller, "DefaultAction", _confirmId] call ACEFUNC(common,removeActionEventHandler);
        _scrollDisplay displayRemoveEventHandler ["MouseZChanged", _scrollEventId];
        _scrollDisplay displayRemoveEventHandler ["MouseButtonDown", _cancelEventId];

        if (GVAR(placeState) == PLACE_APPROVE) then {
            private _posASL = getPosASL _ghost;
            private _vectorDirAndUp = [vectorDir _ghost, vectorUp _ghost];
            deleteVehicle _ghost;
            [_caller, _item, _classname, _posASL, _vectorDirAndUp] call FUNC(startBuild);
        } else {
            deleteVehicle _ghost;
            // Nothing has started yet, so there is no animation to restore
            [LLSTRING(abort), true] call ACEFUNC(common,displayText);
        };
    };

    call _updateGhostTransform;
}, 0, [_caller, _item, _classname, _ghost, _confirmId, _cancelEventId, _scrollDisplay, _scrollEventId, _updateGhostTransform, _distance]] call CBA_fnc_addPerFrameHandler;
