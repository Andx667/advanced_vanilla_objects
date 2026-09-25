[
    QGVAR(enabled),
    "CHECKBOX",
    [LLSTRING(Setting_Enabled_DisplayName), LLSTRING(Setting_Enabled_Description)],
    COMPONENT_NAME,
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(buildTime),
    "SLIDER",
    [LLSTRING(Setting_BuildTime_DisplayName), LLSTRING(Setting_BuildTime_Description)],
    COMPONENT_NAME,
    [2, 60, 8, 0],
    true
] call CBA_fnc_addSetting;
