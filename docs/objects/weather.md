# Weather (`avo_weather`)

ACE actions that read the weather at the object, shown as a hint for 10 seconds.

### Portable weather stations

**Read Weather Data**:

- Wind speed and the direction it comes from, measured at the top of the model with ACE's terrain and obstacle wind model
- Temperature, humidity, dew point and pressure from ACE weather, at the altitude of the station (left out when ACE weather has no data)
- Overcast, rain and fog

`Land_PortableWeatherStation_01_olive_F`, `Land_PortableWeatherStation_01_sand_F`, `Land_PortableWeatherStation_01_white_F`

### Windsock

**Read Wind**: the wind speed and the direction it comes from, measured at the top of the windsock. It has no other weather data.

`Windsock_01_F`
