# Weather (`avo_weather`)

ACE actions that read the weather at the object, shown as a hint for 10 seconds.

### Portable weather stations

**Read Weather Data**:

- Wind speed and the direction it comes from, measured at the top of the model with ACE's terrain and obstacle wind model
- Temperature, humidity, dew point and pressure from ACE weather, at the altitude of the station (left out when ACE weather has no data)
- How it feels: the wind chill when it is cold and windy (10 °C or less, wind from 1.4 m/s) and the heat index when it is warm and humid (27 °C or more). Each is only shown when it differs from the temperature. They are calculated with ACE's formulas, the same as for the temperature of a player in survival mods like [Misery](https://github.com/TenuredCLOUD/Misery)
- Overcast, rain and fog

`Land_PortableWeatherStation_01_olive_F`, `Land_PortableWeatherStation_01_sand_F`, `Land_PortableWeatherStation_01_white_F`

### Windsock

**Read Wind**: the wind speed and the direction it comes from, measured at the top of the windsock. It has no other weather data.

`Windsock_01_F`
