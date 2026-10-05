# Components

AVO follows the standard ACE-style addon layout: functionality is split across several `avo_*` PBOs (addons), each with a single responsibility.

| PBO | Purpose |
| --- | --- |
| `avo_main` | Shared macros, mod metadata |
| `avo_common` | Shared dependencies, the [public functions](scripting.md#functions) for class actions, interaction points and model positions |
| `avo_antennas` | [Antennas](objects/antennas.md): activation of the Rugged terminals. Comms-agnostic, no ACRE or TFAR dependency of its own |
| `avo_antennas_acre` | Optional: connect an ACRE radio to the antennas and terminals, skipped without ACRE2 |
| `avo_antennas_gm` | Optional: the antenna mast of the [Global Mobilization command shelters](objects/antennas.md#global-mobilization-command-shelters), skipped without Global Mobilization |
| `avo_antennas_gm_acre` | Optional: connect an ACRE radio to the GM antenna mast, skipped without Global Mobilization and ACRE2 |
| `avo_antennas_tfar` | Optional: registers the antennas and active terminals (and the GM antenna mast, if loaded) as [TFAR](https://github.com/michail-nikolaev/task-force-arma-3-radio) radio towers, skipped without TFAR |
| `avo_radios_armaradio` | Optional: more [radio objects](objects/radios.md) (smartphone, tablets, laptops) for [ArmaRadio](https://github.com/BrettMayson/ArmaRadio), skipped without ArmaRadio |
| `avo_weather` | [Weather](objects/weather.md): weather station and windsock readout |
| `avo_tents` | [Tents](objects/tents.md): tent items, 3D placement, pack up |
| `avo_tents_bwa3` | Optional: the BWA3 small tent, skipped without BWA3 |
| `avo_animations` | [Animations](objects/animations.md): drawers, doors, lids, switches and more |
| `avo_animations_solar` | Optional: [solar panel controls](objects/animations.md#solar-panels), skipped with Advanced Equipment |

Feature addons depend on `avo_common` (directly or through `avo_tents`) and are skipped when CBA or ACE is missing. Only the feature addons listed in [Usage](usage.md#settings) have their own CBA setting; optional addons are additionally skipped when their specific dependency is missing.
