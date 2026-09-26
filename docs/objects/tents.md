# Tents (`avo_tents`, `avo_tents_bwa3`)

Packed tents are inventory items that are set up with ACE's 3D placement, and the placed tents can be packed up again.

## Set up

In the ACE self-interaction menu, **Equipment** → **Set Up Tent** lists the tents you carry. Pick one, then place it: the mouse wheel rotates the preview, left click confirms, right click cancels. The tent is built after the **Build time** set in the CBA settings, and the grass under it is cut.

## Pack up

Placed tents of these classes have a **Tent** sub menu, **Pack Up Tent** in it gives the item back. You need room for the item in your inventory, and the tent has to be [empty](#inventory). Set the `avo_tents_canPackUp` variable of a tent to `false` to prevent packing it up, see [Scripting & API](../scripting.md#variables).

## Inventory

Placed tents have an inventory. **Tent** → **Open Inventory** opens it, to store items, magazines, weapons and backpacks in the tent. A tent with something in its inventory cannot be packed up, **Pack Up Tent** is not shown until everything is taken out.

The tents are buildings and cannot hold cargo, so the inventory is an invisible container (`avo_tents_container`) that is attached to the tent the first time the inventory is opened. It holds as much as an ammo box (2000 mass). If you delete a tent with a script, delete its container as well, see [Scripting & API](../scripting.md#variables).

Only the tents in the [table](#tents) have an inventory, the big tents (decon, connector and medical tents) have none. The server makes the containers, so the mod has to be on the server for the inventory to work. When the server cannot make one, a message says the inventory cannot be opened.

The **Tent inventory** setting turns this off: tents that have no inventory yet do not get one, and pack up works as before. A tent that already has an inventory keeps it, so nothing in it is lost.

The server also decides that a tent is empty when it is packed up, so what another player puts in at the last moment is not lost, the pack up stops instead. A tent whose container got lost, for example by a script that deleted it, counts as not empty. Opening its inventory makes a new one.

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

The pack up and inventory actions are only for these exact classes, not for the classes derived from them. Other mods can add their own tents, see [Adding tents](../scripting.md#adding-tents).

The larger tents (decon, connector and medical tents) are not packable, they only have [door actions](animations.md#tents).
