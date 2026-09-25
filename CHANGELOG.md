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

- Antennas - connect ACRE radios (PRC-117F, PRC-152) to the vanilla Contact satellite antennas, omni-directional antennas and Rugged communications terminals, which have an ACE action to activate them first
- Weather - ACE action on the Contact portable weather station to read precise weather data
- Tents - packed tent items for the Contact solar tents, dome tent and A-frame tent, set up with ACE 3D placement, and a pack up action on the placed tents
- Tents (BWA3) - the same for the BWA3 small tent, in a separate addon that is skipped when BWA3 is missing
- CBA setting per addon (Antennas, Weather, Tents) to disable its function

## [0.1.0] - 2026-09-14

### Added

- Initial release
