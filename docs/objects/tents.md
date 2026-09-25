# Tents (`avo_tents`, `avo_tents_bwa3`)

Packed tents are inventory items that are set up with ACE's 3D placement, and the placed tents can be packed up again.

## Set up

In the ACE self-interaction menu, **Equipment** → **Set Up Tent** lists the tents you carry. Pick one, then place it: the mouse wheel rotates the preview, left click confirms, right click cancels. The tent is built after the **Build time** set in the CBA settings, and the grass under it is cut.

## Pack up

Placed tents of these classes get **Pack Up Tent**, which gives the item back. You need room for the item in your inventory. Set the `avo_tents_canPackUp` variable of a tent to `false` to prevent packing it up, see [Scripting & API](../scripting.md#variables).

## Tents

| Tent | Item | Object |
| --- | --- | --- |
| Solar tent, olive | `avo_tents_solarOlive` | `Land_TentSolar_01_olive_F` |
| Solar tent, sand | `avo_tents_solarSand` | `Land_TentSolar_01_sand_F` |
| Solar tent, red and white | `avo_tents_solarRedWhite` | `Land_TentSolar_01_redwhite_F` |
| Solar tent, blue and white | `avo_tents_solarBlueWhite` | `Land_TentSolar_01_bluewhite_F` |
| Dome tent | `avo_tents_dome` | `Land_TentDome_F` |
| A-frame tent | `avo_tents_a` | `Land_TentA_F` |
| BWA3 small tent (needs BWA3, addon `avo_tents_bwa3`) | `avo_tents_bwa3_smallFleck` | `BWA3_Tent_small_Fleck` |

The pack up action is only for these exact classes, not for the classes derived from them. Other mods can add their own tents, see [Adding tents](../scripting.md#adding-tents).

The larger tents (decon, connector and medical tents) are not packable, they only have [door actions](animations.md#tents).
