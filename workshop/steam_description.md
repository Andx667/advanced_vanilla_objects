# Advanced Vanilla Objects

**Advanced Vanilla Objects** (AVO) fills vanilla objects with the functions they should have had. Currently: connect ACRE radios to the vanilla Contact satellite dishes and omni-directional antennas.

# Requirements

- [CBA_A3](https://github.com/CBATeam/CBA_A3)
- [ACE3](https://github.com/acemod/ACE3)
- Arma 3 Contact content
- [ACRE2](https://github.com/IDI-Systems/acre2) (only for the antennas)
- [BWA3](https://steamcommunity.com/sharedfiles/filedetails/?id=1200127537) (only for the BWA3 tent)
- [Global Mobilization](https://store.steampowered.com/app/1042220) (only for the antenna of the command shelters)

If a dependency of an addon is missing, that addon is skipped instead of throwing errors.

# Features

- **Antennas** — connect a compatible ACRE radio (PRC-117F, PRC-152) to the vanilla Contact satellite antennas, omni-directional antennas and Rugged communications terminals (which must be activated first, with an ACE action or "Open terminal" in the editor) via the ACE interaction menu, like ACRE's ground spike antenna. The antenna sits at the real tip of the model, so height matters for signal. The command shelters of Global Mobilization (needs GM) have an antenna mast that is extended the same way: extend it, then connect a radio.
- **Weather** — ACE action on the portable weather station (Contact) that reads precise weather data: wind at the anemometer, temperature, humidity, dew point, wind chill, heat index and pressure from ACE weather, plus overcast, rain and fog. The windsock has an action that reads the wind.
- **Tents** — packed tent items (solar tents in four colours, dome tent, A-frame tent, and the BWA3 small tent with BWA3 loaded) that are set up with ACE's 3D placement. Placed tents of these classes can be packed up again with an ACE action.
- **Animations** — ACE actions for vanilla objects that have animations but no way to change them in the game (most only had editor attributes): drawers of the portable cabinets, office table and coffins, doors of the fridge, coffins and the decon, connector and medical tents, lids of laptops, computers and containers, transfer switch, portable server, data terminal antenna and flag pole. Actions only show for variants that have the animation. Solar panels (rotate and tilt) are a separate addon that is skipped when Advanced Equipment is loaded.
- **Events** — every action raises a CBA event, so missions and mods can hook into them (`avo_animations_changed`, `avo_tents_setUp`, ...). See the documentation for the list.

# Works well with Misery

AVO matches nicely with the survival framework [Misery](https://github.com/TenuredCLOUD/Misery), they work together without any setup:

- **Camping** — sleep in the tents you set up with AVO (the solar tents, dome tent and A-frame tent are beds for Misery) and pack them up in the morning
- **Weather** — the weather station shows the wind chill and heat index with the same ACE formulas Misery uses for the temperature of your character

# Source & Issues

Fully open-source. Bug reports, feature requests, and contributions are all welcome.

[Documentation](https://andx667.github.io/advanced_vanilla_objects/)
[GitHub Repository](https://github.com/Andx667/advanced_vanilla_objects)
[Report an Issue](https://github.com/Andx667/advanced_vanilla_objects/issues)
[Discord](https://discord.gg/ag4v6kxYAa)

Licensed under [MIT](https://github.com/Andx667/advanced_vanilla_objects/blob/main/LICENSE).

---

Suchst du eine deutschsprachige Arma3 und Reforger Community? -> https://tacticalteam.de/mitmachen
