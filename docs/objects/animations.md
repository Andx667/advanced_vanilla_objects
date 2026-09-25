# Animations (`avo_animations`, `avo_animations_solar`)

ACE actions for vanilla objects that have animations but no way to change them in the game. Most of them could only be changed with attributes in the editor. The classnames also cover everything derived from them. Only the variants that have the animation get their actions.

Every use raises the [`avo_animations_changed`](../scripting.md#avo_animations_changed) event.

## Drawers

### Portable cabinets

Sub menu **Drawers**: open and close each drawer. 4 drawers, 5 for the 7 drawer cabinet, 6 for the medical cabinet.

??? info "7 classes"
    `Land_PortableCabinet_01_4drawers_black_F`, `Land_PortableCabinet_01_4drawers_olive_F`, `Land_PortableCabinet_01_4drawers_sand_F`, `Land_PortableCabinet_01_7drawers_black_F`, `Land_PortableCabinet_01_7drawers_olive_F`, `Land_PortableCabinet_01_7drawers_sand_F`, `Land_PortableCabinet_01_medical_F`

### Office tables

Sub menu **Drawers**: open and close the two drawers.

`OfficeTable_01_new_F`, `OfficeTable_01_old_F`

### Coffins

The wooden coffin (`Coffin_01_F`): sub menu **Doors** to open and close its two doors. The other coffins: open and close the drawer, where the model has one.

`Coffin_01_F`, `Coffin_02_Cover_F`, `Coffin_02_Cover_US_F`, `Coffin_02_F`, `Coffin_02_US_F`

## Doors

### Fridges

Open and close the door.

`Fridge_01_closed_F`, `Fridge_01_open_F`

## Tents

Door actions for the large tents, they are not packable. The action is at the door.

### Decon tents

Sub menu **Doors**: open and close the two doors.

??? info "9 classes"
    `Land_DeconTent_01_AAF_F`, `Land_DeconTent_01_CSAT_brownhex_F`, `Land_DeconTent_01_CSAT_greenhex_F`, `Land_DeconTent_01_IDAP_F`, `Land_DeconTent_01_NATO_F`, `Land_DeconTent_01_NATO_tropic_F`, `Land_DeconTent_01_wdl_F`, `Land_DeconTent_01_white_F`, `Land_DeconTent_01_yellow_F`

### Connector tents

Sub menu **Doors**: open and close the doors, up to four, of the variants that have them.

??? info "21 classes"
    `Land_ConnectorTent_01_AAF_closed_F`, `Land_ConnectorTent_01_AAF_cross_F`, `Land_ConnectorTent_01_AAF_open_F`, `Land_ConnectorTent_01_CSAT_brownhex_closed_F`, `Land_ConnectorTent_01_CSAT_brownhex_cross_F`, `Land_ConnectorTent_01_CSAT_brownhex_open_F`, `Land_ConnectorTent_01_CSAT_greenhex_closed_F`, `Land_ConnectorTent_01_CSAT_greenhex_cross_F`, `Land_ConnectorTent_01_CSAT_greenhex_open_F`, `Land_ConnectorTent_01_NATO_closed_F`, `Land_ConnectorTent_01_NATO_cross_F`, `Land_ConnectorTent_01_NATO_open_F`, `Land_ConnectorTent_01_NATO_tropic_closed_F`, `Land_ConnectorTent_01_NATO_tropic_cross_F`, `Land_ConnectorTent_01_NATO_tropic_open_F`, `Land_ConnectorTent_01_wdl_closed_F`, `Land_ConnectorTent_01_wdl_cross_F`, `Land_ConnectorTent_01_wdl_open_F`, `Land_ConnectorTent_01_white_closed_F`, `Land_ConnectorTent_01_white_cross_F`, `Land_ConnectorTent_01_white_open_F`

### Medical tents

Open and close the door of the variants that have one. The outer tents (`*_outer_F`) have no door and no actions.

??? info "30 classes"
    `Land_MedicalTent_01_CSAT_brownhex_generic_closed_F`, `Land_MedicalTent_01_CSAT_brownhex_generic_inner_F`, `Land_MedicalTent_01_CSAT_brownhex_generic_open_F`, `Land_MedicalTent_01_CSAT_greenhex_generic_closed_F`, `Land_MedicalTent_01_CSAT_greenhex_generic_inner_F`, `Land_MedicalTent_01_CSAT_greenhex_generic_open_F`, `Land_MedicalTent_01_MTP_closed_F`, `Land_MedicalTent_01_NATO_generic_closed_F`, `Land_MedicalTent_01_NATO_generic_inner_F`, `Land_MedicalTent_01_NATO_generic_open_F`, `Land_MedicalTent_01_NATO_tropic_generic_closed_F`, `Land_MedicalTent_01_NATO_tropic_generic_inner_F`, `Land_MedicalTent_01_NATO_tropic_generic_open_F`, `Land_MedicalTent_01_aaf_generic_closed_F`, `Land_MedicalTent_01_aaf_generic_inner_F`, `Land_MedicalTent_01_aaf_generic_open_F`, `Land_MedicalTent_01_brownhex_closed_F`, `Land_MedicalTent_01_digital_closed_F`, `Land_MedicalTent_01_greenhex_closed_F`, `Land_MedicalTent_01_tropic_closed_F`, `Land_MedicalTent_01_wdl_closed_F`, `Land_MedicalTent_01_wdl_generic_closed_F`, `Land_MedicalTent_01_wdl_generic_inner_F`, `Land_MedicalTent_01_wdl_generic_open_F`, `Land_MedicalTent_01_white_IDAP_closed_F`, `Land_MedicalTent_01_white_IDAP_med_closed_F`, `Land_MedicalTent_01_white_IDAP_open_F`, `Land_MedicalTent_01_white_generic_closed_F`, `Land_MedicalTent_01_white_generic_inner_F`, `Land_MedicalTent_01_white_generic_open_F`

## Lids, screens and containers

### Laptops and computers

Open and close the laptop lid or the screens of the computer.

??? info "8 classes"
    `Land_Laptop_02_F`, `Land_Laptop_02_unfolded_F`, `Land_MultiScreenComputer_01_black_F`, `Land_MultiScreenComputer_01_closed_black_F`, `Land_MultiScreenComputer_01_closed_olive_F`, `Land_MultiScreenComputer_01_closed_sand_F`, `Land_MultiScreenComputer_01_olive_F`, `Land_MultiScreenComputer_01_sand_F`

### CBRN containers and buckets

Open and close the lid.

`CBRNContainer_01_closed_olive_F`, `CBRNContainer_01_closed_yellow_F`, `CBRNContainer_01_olive_F`, `CBRNContainer_01_yellow_F`, `Land_PlasticBucket_01_closed_F`, `Land_PlasticBucket_01_open_F`

## Equipment

### Portable servers

Sub menu **Controls**: extend and retract the server rack, turn the LED lights on and off. The server covers are separate objects and have no actions.

`Land_PortableServer_01_black_F`, `Land_PortableServer_01_olive_F`, `Land_PortableServer_01_sand_F`

### Transfer switch

Sub menu **Controls**: set the switch to position 1, off or position 2, and turn the indicator lamp on and off.

`Land_TransferSwitch_01_F`

### Data terminal

Extend and retract the antenna.

`Land_DataTerminal_01_F`

### Flag pole

Raise and lower the flag.

`PortableFlagPole_01_F`

## Solar panels

Sub menu **Solar panels**: rotate the panels in steps of 30° (±180°) and tilt each of the two panels in steps of 15° (±45°). These are in their own addon, `avo_animations_solar`, which is skipped when [Advanced Equipment](https://github.com/y0014984/Advanced-Equipment) (`ae_main`) is loaded, because it has its own controls for them. That needs Arma 3 2.22, older versions load it anyway.

`Land_SolarPanel_04_black_F`, `Land_SolarPanel_04_olive_F`, `Land_SolarPanel_04_sand_F`
