// TFAR keeps a tower with the range it was registered with until it is deregistered, so a change of
// either setting updates every antenna of this client (the updateTowers event, see XEH_postInit.sqf)
[
    QGVAR(enabled),
    "CHECKBOX",
    [LLSTRING(Setting_Enabled_DisplayName), LLSTRING(Setting_Enabled_Description)],
    COMPONENT_NAME,
    [true],
    true,
    {[QGVAR(updateTowers)] call CBA_fnc_localEvent}
] call CBA_fnc_addSetting;

[
    QGVAR(range),
    "SLIDER",
    [LLSTRING(Setting_Range_DisplayName), LLSTRING(Setting_Range_Description)],
    COMPONENT_NAME,
    [100, 50000, 20000, 0],
    true,
    {[QGVAR(updateTowers)] call CBA_fnc_localEvent}
] call CBA_fnc_addSetting;
