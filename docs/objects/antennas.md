# Antennas (`avo_antennas`)

Connect a compatible ACRE radio (PRC-117F, PRC-152) to the vanilla antennas via the ACE interaction menu, like ACRE's ground spike antenna. The antenna sits at the real tip of the model, so height matters for signal. The link drops when the radio is more than 10 m from the antenna.

The mounted satellite dishes (`SatelliteAntenna_01_Mounted_*`, `SatelliteAntenna_01_Small_Mounted_*`) have no actions, they are out of reach.

Requires ACRE2, the shelters of Global Mobilization also need Global Mobilization. The events are in [Scripting & API](../scripting.md#events).

### Satellite dishes and omni-directional antennas

**Connect Radio** and **Disconnect Radio**.

??? info "10 classes"
    `Land_SatelliteAntenna_01_F`, `SatelliteAntenna_01_Black_F`, `SatelliteAntenna_01_Olive_F`, `SatelliteAntenna_01_Sand_F`, `SatelliteAntenna_01_Small_Black_F`, `SatelliteAntenna_01_Small_Olive_F`, `SatelliteAntenna_01_Small_Sand_F`, `OmniDirectionalAntenna_01_black_F`, `OmniDirectionalAntenna_01_olive_F`, `OmniDirectionalAntenna_01_sand_F`

### Rugged communications terminals

Sub menu **Terminal** with **Activate Terminal** and **Deactivate Terminal**, and **Connect Radio** and **Disconnect Radio** once the terminal is active. Activating does the same as the *Open terminal* attribute in the editor. A radio that is still connected is disconnected when the terminal is deactivated.

`RuggedTerminal_01_communications_F`, `RuggedTerminal_01_communications_hub_F`, `RuggedTerminal_02_communications_F`

### Global Mobilization command shelters

The command shelters have an antenna mast as an option, the editor attributes *Add antenna* and *Elevate antenna*. The actions are on the base class `gm_shelteraceI_command_base`, so they are on every shelter derived from it, for example `gm_ge_army_shelteraceI_command`. Needs Global Mobilization, addon `avo_antennas_gm`.

Shelters with the antenna have the sub menu **Antenna** with **Extend Antenna** and **Retract Antenna**, and **Connect Radio** and **Disconnect Radio** once the mast is extended. Extending does the same as *Elevate antenna* in the editor, and takes as long as the mast needs to go up. A radio that is still connected is disconnected when the antenna is retracted. Shelters without the antenna have no actions.
