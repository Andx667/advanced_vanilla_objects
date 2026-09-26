// Test for the antennas_gm addon: two command shelters, one with the antenna mast and one without.
// Runs the extend and retract cycle of the antenna and logs the animation phases to the RPT
// (search for "AVO-GM"). The ACE actions ("Antenna" on the shelter) are for you to try.
private _log = {
    params ["_step"];
    {
        _x params ["_name", "_shelter"];
        diag_log format ["[AVO-GM] %1 | %2 | unhide=%3 trigger=%4 source=%5 | equipped=%6 active=%7",
            _step, _name,
            _shelter animationSourcePhase "antennaMast_01_unhide",
            _shelter animationSourcePhase "antennamast_01_elev_trigger",
            _shelter animationSourcePhase "antennamast_01_elev_source",
            [_shelter] call avo_antennas_fnc_isEquipped, [_shelter] call avo_antennas_fnc_isActive];
    } forEach [["with antenna", shelter_antenna], ["without antenna", shelter_bare]];
};

[_log] spawn {
    params ["_log"];
    sleep 5;

    private _cfg = configOf shelter_antenna;
    diag_log format ["[AVO-GM] config | class=%1 | acre_antennaPosFnc=%2 | component=%3 | componentClass=%4 | activeSources=%5 | requiredSources=%6 | activePhase=%7",
        typeOf shelter_antenna, getText (_cfg >> "acre_antennaPosFnc"), getText (_cfg >> "AcreComponents" >> "componentName"),
        isClass (configFile >> "CfgAcreComponents" >> "avo_antennas_gm_mast"), getArray (_cfg >> "avo_antennas_activeSources"),
        getArray (_cfg >> "avo_antennas_requiredSources"), getNumber (_cfg >> "avo_antennas_activePhase")];

    ["start"] call _log;
    diag_log format ["[AVO-GM] antenna position ASL %1 | object ASL %2", [shelter_antenna, 0] call avo_antennas_fnc_antennaPos, getPosASL shelter_antenna];

    [shelter_antenna, true] call avo_antennas_fnc_setActive;
    [shelter_bare, true] call avo_antennas_fnc_setActive;
    sleep 3;
    ["3 s after extending"] call _log;
    sleep 30;
    ["33 s after extending"] call _log;
    diag_log format ["[AVO-GM] antenna position ASL, extended %1", [shelter_antenna, 0] call avo_antennas_fnc_antennaPos];

    [shelter_antenna, false] call avo_antennas_fnc_setActive;
    [shelter_bare, false] call avo_antennas_fnc_setActive;
    sleep 3;
    ["3 s after retracting"] call _log;
    diag_log "[AVO-GM] DONE";
};
