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
| [ACRE2](https://github.com/IDI-Systems/acre2) | [Antennas](objects/antennas.md) |
| [BWA3](https://steamcommunity.com/sharedfiles/filedetails/?id=1200127537) | The BWA3 small tent of [Tents](objects/tents.md) |

If a dependency of an addon is missing, that addon is skipped instead of throwing errors (`skipWhenMissingDependencies`), the others still work. The [solar panel controls](objects/animations.md#solar-panels) are skipped when [Advanced Equipment](https://github.com/y0014984/Advanced-Equipment) is loaded, it has its own.

## Players

1. Subscribe to the mod on the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=0), or download a release from the [Releases](https://github.com/Andx667/advanced_vanilla_objects/releases) page.
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

`hemtt launch` starts Arma with the mod and the test mission `.hemtt/missions/test.VR`, which has the objects of these docs placed in rows. `hemtt launch acre` and `hemtt launch bwa3` also load ACRE2 or BWA3.
