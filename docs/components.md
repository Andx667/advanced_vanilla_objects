# Components

AVO follows the standard ACE-style addon layout: functionality is split across several `avo_*` PBOs (addons), each with a single responsibility.

| PBO | Purpose |
| --- | --- |
| `avo_main` | Shared macros, mod metadata |
| `avo_common` | Shared dependencies, the [public functions](scripting.md#functions) for class actions, interaction points and model positions |
| `avo_antennas` | [Antennas](objects/antennas.md): ACRE connection, activation of the Rugged terminals |
| `avo_weather` | [Weather](objects/weather.md): weather station and windsock readout |
| `avo_tents` | [Tents](objects/tents.md): tent items, 3D placement, pack up |
| `avo_tents_bwa3` | Optional: the BWA3 small tent, skipped without BWA3 |
| `avo_animations` | [Animations](objects/animations.md): drawers, doors, lids, switches and more |
| `avo_animations_solar` | Optional: [solar panel controls](objects/animations.md#solar-panels), skipped with Advanced Equipment |

Every addon requires `avo_common`, and is skipped when CBA or ACE is missing. Each has its own CBA setting to turn it off.
