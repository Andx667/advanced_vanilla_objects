# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!-- TEMPLATE: `hemtt publish` looks up the entry whose heading exactly
matches the current project version (see .hemtt/project.toml's
[version] / addons/main/script_version.hpp) -- so before publishing,
rename "[Unreleased]" below to "[X.Y.Z] - YYYY-MM-DD" matching that
version, and start a fresh empty [Unreleased] section above it. -->

## [Unreleased]

### Added

- Tents - placed tents have an inventory, opened with "Open Inventory" (invisible container attached to the tent, event `avo_tents_inventoryOpened`). A tent with items in it cannot be packed up, and the server checks that when the pack up is done. Only the tents that can be set up have an inventory, not the big decon, connector and medical tents. The new "Tent inventory" setting turns it off for tents that have none yet

### Changed

- Tents - "Pack Up Tent" is now in a "Tent" sub menu together with "Open Inventory"
- Tents - the packed tent items have a picture of their tent in the inventory (solar tents in their four colours, dome tent, A-frame tent) instead of a backpack

## [1.2.0] - 2026-09-26

### Added

- Antennas - the command shelters of Global Mobilization (optional addon `avo_antennas_gm`): extend and retract the antenna mast, and connect an ACRE radio once it is extended

### Changed

- Branding - sky blue is now the DLC color and the main color of the documentation, with dark header text and darker link colors so the text stays readable (WCAG AA)

## [1.1.0] - 2026-09-25

### Added

- Weather - ACE action on the windsock to read the wind
- Weather - the weather station also shows the wind chill when it is cold and windy, and the heat index when it is warm and humid
- CBA events for all actions (`avo_animations_changed`, `avo_antennas_activated`, `avo_antennas_deactivated`, `avo_antennas_connected`, `avo_antennas_disconnected`, `avo_tents_setUp`, `avo_tents_packedUp`, `avo_weather_read`), so missions and mods can hook into them
- Documentation with MkDocs Material, published to GitHub Pages: the objects with their classnames, the events, functions and config

## [1.0.0] - 2026-09-25

### Added

- Antennas - connect ACRE radios (PRC-117F, PRC-152) to the vanilla Contact satellite antennas, omni-directional antennas and Rugged communications terminals. The terminals have a "Terminal" sub menu to activate them first, like the "Open terminal" editor attribute
- Weather - ACE action on the Contact portable weather station to read precise weather data
- Tents - packed tent items for the Contact solar tents, dome tent and A-frame tent, set up with ACE 3D placement, and a pack up action on the placed tents
- Tents (BWA3) - the same for the BWA3 small tent, in a separate addon that is skipped when BWA3 is missing
- Animations - ACE actions for vanilla objects with animations that could only be changed in the editor: drawers of the portable cabinets, office tables and coffins, doors of the fridge, coffins and the decon, connector and medical tents, lids of laptops, computers, CBRN containers and buckets, the portable server, transfer switch, data terminal antenna and flag pole
- Animations (Solar) - ACE actions to rotate and tilt the Rugged solar panels, in a separate addon that is skipped when Advanced Equipment is loaded (Arma 3 2.22)
- CBA setting per addon (Antennas, Weather, Tents, Animations, Animations (Solar)) to disable its function
- Common - shared dependencies of the addons, the top position of a model and interaction points that depend on the size of the object (centre of small objects, chest height for medium ones, where the change is or next to the player for big ones). Actions are added to classes by name, so objects that define their own event handlers get them too

## [0.1.0] - 2026-09-14

### Added

- Initial release
