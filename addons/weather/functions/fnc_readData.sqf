#include "..\script_component.hpp"
/*
 * Author: Andx
 * Reads the weather at a portable weather station and shows it to the player.
 * Wind is measured at the station's anemometer (top of the model) with ACE's
 * terrain and obstacle wind model. Temperature, humidity, dew point and pressure
 * come from ACE weather at the station's altitude and are left out when ACE
 * weather has no data (e.g. ACE weather simulation disabled).
 *
 * Arguments:
 * 0: Weather station <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject] call avo_weather_fnc_readData
 *
 * Public: No
 */

params ["_station"];

private _lines = [];

// Wind, measured slightly above the model so the station itself does not shade the sensor
(boundingBoxReal _station) params ["_min", "_max"];
private _sensorPos = _station modelToWorldWorld [
    ((_min select 0) + (_max select 0)) / 2,
    ((_min select 1) + (_max select 1)) / 2,
    (_max select 2) + 0.5
];
private _useGradient = missionNamespace getVariable [QACEGVAR(advanced_ballistics,enabled), false];
private _windSpeed = [_sensorPos, _useGradient, true, true] call ACEFUNC(weather,calculateWindSpeed);

if (_windSpeed < 0.3) then {
    _lines pushBack LLSTRING(windCalm);
} else {
    // `wind` points where the wind blows to, report where it comes from
    private _windFrom = (180 + ((wind select 0) atan2 (wind select 1))) % 360;
    private _directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"];
    _lines pushBack format [LLSTRING(wind), _windSpeed toFixed 1, round _windFrom, _directions select (round (_windFrom / 22.5) % 16)];
};

// ACE weather values, published by the server
if (
    !isNil QACEGVAR(weather,currentTemperature)
    && {!isNil QACEGVAR(weather,currentHumidity)}
    && {!isNil QACEGVAR(weather,currentOvercast)}
) then {
    private _altitude = (getPosASL _station) select 2;
    private _temperature = _altitude call ACEFUNC(weather,calculateTemperatureAtHeight);
    private _humidity = ACEGVAR(weather,currentHumidity);
    private _pressure = _altitude call ACEFUNC(weather,calculateBarometricPressure);
    private _dewPoint = [_temperature, _humidity] call ACEFUNC(weather,calculateDewPoint);

    _lines pushBack format [LLSTRING(temperature), _temperature toFixed 1];
    _lines pushBack format [LLSTRING(humidity), round (_humidity * 100)];
    _lines pushBack format [LLSTRING(dewPoint), _dewPoint toFixed 1];
    _lines pushBack format [LLSTRING(pressure), _pressure toFixed 1];
};

_lines pushBack format [LLSTRING(overcast), round (overcast * 100)];
_lines pushBack format [LLSTRING(rain), round (rain * 100)];
_lines pushBack format [LLSTRING(fog), round (fog * 100)];

private _text = format ["<t size='1.1' align='center'>%1</t><br/>%2", LLSTRING(title), _lines joinString "<br/>"];

[parseText _text, true, 10] call ACEFUNC(common,displayText);
