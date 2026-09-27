[
    QGVAR(enabled),
    "CHECKBOX",
    [LLSTRING(Setting_Enabled_DisplayName), LLSTRING(Setting_Enabled_Description)],
    COMPONENT_NAME,
    [true],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(range),
    "SLIDER",
    [LLSTRING(Setting_Range_DisplayName), LLSTRING(Setting_Range_Description)],
    COMPONENT_NAME,
    [100, 50000, 20000, 0],
    true
] call CBA_fnc_addSetting;
