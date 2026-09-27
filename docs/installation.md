# Installation

## Requirements

AVO depends on:

- [CBA_A3](https://github.com/CBATeam/CBA_A3/releases/latest)
- [ACE3](https://github.com/acemod/ACE3)
- Arma 3 Contact content (most of the objects are from Contact)

All of them must be loaded **before** AVO.

Optional, each one is needed by a single addon only:

| Mod | Needed for |
| --- | --- |
| [ACRE2](https://github.com/IDI-Systems/acre2) | Connecting a radio to the [Antennas](objects/antennas.md) (optional addon `avo_antennas_acre`) |
| [TFAR](https://github.com/michail-nikolaev/task-force-arma-3-radio) | The [Antennas](objects/antennas.md#tfar) as radio towers instead (optional addon `avo_antennas_tfar`) |
| [BWA3](https://steamcommunity.com/sharedfiles/filedetails/?id=1200127537) | The BWA3 small tent of [Tents](objects/tents.md) |
| [Global Mobilization](https://store.steampowered.com/app/1042220) | The antenna mast of the command shelters of [Antennas](objects/antennas.md#global-mobilization-command-shelters) (optional addon `avo_antennas_gm`, plus `avo_antennas_gm_acre` together with ACRE2 to connect a radio) |

`avo_antennas` itself needs neither ACRE2 nor TFAR: it only switches the Rugged terminals on and off. ACRE2 and TFAR are independent of each other, install either, both, or neither.

If a dependency of an addon is missing, that addon is skipped instead of throwing errors (`skipWhenMissingDependencies`), the others still work. The [solar panel controls](objects/animations.md#solar-panels) are skipped when [Advanced Equipment](https://github.com/y0014984/Advanced-Equipment) is loaded, it has its own.

## Players

1. Subscribe to the mod on the Steam Workshop once it is published, or download a release from the [Releases](https://github.com/Andx667/advanced_vanilla_objects/releases) page.
2. Make sure CBA_A3 and ACE3 are also installed and enabled.
3. Enable **Advanced Vanilla Objects**, CBA_A3, and ACE3 in your mod launcher.

## Server owners

Add the mod's PBO folder alongside CBA_A3 and ACE3 in your server's mod line, keeping the same load order (CBA_A3 → ACE3 → Advanced Vanilla Objects).

## Building from source

AVO is built with [HEMTT](https://hemtt.dev/):

```cmd
winget install hemtt
```

From the repository root:

```cmd
hemtt build
```

Run `hemtt check` to validate configs, scripts, and stringtables without producing a build.

`hemtt launch` starts Arma with the mod and the test mission `.hemtt/missions/test.VR`, which has the objects of these docs placed in rows. `hemtt launch acre`, `hemtt launch bwa3`, `hemtt launch gm` and `hemtt launch tfar` also load ACRE2, BWA3, ACRE2 with Global Mobilization, or TFAR, the `gm` preset with the test mission `.hemtt/missions/gm.VR`.

`avo_antennas_acre`, `avo_antennas_gm_acre` and `avo_antennas_tfar` are skipped without their respective comms mod, so `hemtt launch` (no ACRE2, no TFAR) only exercises the comms-agnostic activation of `avo_antennas`/`avo_antennas_gm`.
