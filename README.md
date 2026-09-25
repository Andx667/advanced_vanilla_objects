# Advanced Vanilla Objects

<p align="center">
    <img src="img/AVO_logo_512.png" width="256" alt="Advanced Vanilla Objects Logo">
</p>

<p align="center">
    <a href="https://github.com/Andx667/advanced_vanilla_objects/issues">
        <img src="https://img.shields.io/github/issues-raw/Andx667/advanced_vanilla_objects.svg?style=flat-square&label=Issues" alt="Advanced Vanilla Objects Issues">
    </a>
    <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=0">
        <img src="https://img.shields.io/steam/downloads/0.svg?style=flat-square&label=Downloads" alt="Advanced Vanilla Objects Downloads">
    </a>
    <a href="https://github.com/Andx667/advanced_vanilla_objects/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-MIT-blue?style=flat-square" alt="Advanced Vanilla Objects License">
    </a>
    <br>
    <img src="https://img.shields.io/github/actions/workflow/status/Andx667/advanced_vanilla_objects/check.yml?style=flat-square&label=Check" alt="Check">
    <img src="https://img.shields.io/github/actions/workflow/status/Andx667/advanced_vanilla_objects/validate.yml?style=flat-square&label=Validate" alt="Validate">
</p>

__Requires__ [CBA_A3](https://github.com/CBATeam/CBA_A3), [ACE3](https://github.com/acemod/ACE3) and Arma 3 Contact content. The antennas also need [ACRE2](https://github.com/IDI-Systems/acre2), and the BWA3 tent needs [BWA3](https://steamcommunity.com/sharedfiles/filedetails/?id=1200127537). If a dependency of an addon is missing, that addon is skipped instead of throwing errors (`skipWhenMissingDependencies`).

__Advanced Vanilla Objects__ (AVO) fills vanilla objects with the functions they should have had. Currently: connect ACRE radios to the vanilla Contact satellite dishes and omni-directional antennas.

The project is entirely __open-source__ and any contributions are welcome.

Steam Workshop: <https://steamcommunity.com/sharedfiles/filedetails/?id=0>
Discord: <https://discord.gg/ag4v6kxYAa>

## Features

- __Antennas__ — connect a compatible ACRE radio (PRC-117F, PRC-152) to the vanilla Contact satellite antennas, omni-directional antennas and Rugged communications terminals (which must be activated first, with an ACE action or "Open terminal" in the editor) via the ACE interaction menu, like ACRE's ground spike antenna. The antenna sits at the real tip of the model, so height matters for signal. The link drops when the radio is more than 10 m from the antenna.
- __Weather__ — ACE action on the portable weather station (Contact) that reads precise weather data: wind at the anemometer, temperature, humidity, dew point and pressure from ACE weather, plus overcast, rain and fog.
- __Tents__ — packed tent items (solar tents in four colours, dome tent, A-frame tent, and the BWA3 small tent with BWA3 loaded) that are set up with ACE's 3D placement (mouse wheel rotates, left click confirms, right click cancels). Placed tents of these classes get a "Pack Up Tent" action that gives the item back. Set the `avo_tents_canPackUp` variable of a tent to false to prevent packing it up.

## Settings

Each addon has an "Enable ..." checkbox under its own category ("Advanced Vanilla Objects - <Addon>") in the CBA settings, so a function you don't want can be turned off. The tents also have a build time setting. The settings are server/mission-wide.

## Contributing

For new contributors, see the [Contributing Setup & Guidelines](./.github/CONTRIBUTING.md).

## License

Advanced Vanilla Objects is licensed under [MIT](./LICENSE).
