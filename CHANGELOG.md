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

## [1.0.0] - 2026-09-25

### Added

- Antennas - connect ACRE radios (PRC-117F, PRC-152) to the vanilla Contact satellite antennas, omni-directional antennas and Rugged communications terminals. The terminals have a "Terminal" sub menu to activate them first, like the "Open terminal" editor attribute
- Weather - ACE action on the Contact portable weather station to read precise weather data
- Tents - packed tent items for the Contact solar tents, dome tent and A-frame tent, set up with ACE 3D placement, and a pack up action on the placed tents
- Tents (BWA3) - the same for the BWA3 small tent, in a separate addon that is skipped when BWA3 is missing
- Animations - ACE actions for vanilla objects with animations that could only be changed in the editor: drawers of the portable cabinets, office tables and coffins, doors of the fridge, coffins and the decon, connector and medical tents, lids of laptops, computers, CBRN containers and buckets, the portable server, transfer switch, data terminal antenna and flag pole
- Animations (Solar) - ACE actions to rotate and tilt the Rugged solar panels, in a separate addon that is skipped when Advanced Equipment is loaded (Arma 3 2.22)
- CBA setting per addon (Antennas, Weather, Tents, Animations, Animations (Solar)) to disable its function
- Common - shared dependencies of the addons, the top position of a model and interaction points that are within reach of big models. Actions are added to classes by name, so objects that define their own event handlers get them too

## [0.1.0] - 2026-09-14

### Added

- Initial release
