# Radios (`avo_radios_armaradio`)

More vanilla objects that play radio stations with [ArmaRadio](https://github.com/BrettMayson/ArmaRadio) (Live Radio, [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2172022102)). ArmaRadio itself covers every car, tank, helicopter, plane and boat (`Boat_F`), and three objects: the FM radio, the survival radio and the portable speakers. This optional addon adds the rest. It needs ArmaRadio and is skipped without it, ArmaRadio does not need AVO.

Look at the object and choose **FM Radio** (the name ArmaRadio gives its action), which opens the ArmaRadio interface. Anything ArmaRadio can do, like the volume, the stations and the multiplayer sync, works as it does for its own objects. The action is shown for everyone within 5 m, ArmaRadio's settings for vehicles do not apply to these objects.

## Objects

| Object | Classname |
| --- | --- |
| Motorboat, rescue boat, police boat | `C_Boat_Civil_01_F`, `C_Boat_Civil_01_rescue_F`, `C_Boat_Civil_01_police_F` |
| Portable long range radio | `Land_PortableLongRangeRadio_F` |
| Satellite phone | `Land_SatellitePhone_F` |
| Mobile phones | `Land_MobilePhone_old_F`, `Land_MobilePhone_smart_F` |
| Loudspeakers | `Land_Loudspeakers_F` |
| Flat TV (Helicopters) | `Land_FlatTV_01_F` |
| Laptops | `Land_Laptop_F`, `Land_Laptop_unfolded_F`, `Land_Laptop_02_F`, `Land_Laptop_02_unfolded_F`, `Land_Laptop_03_*` |

The laptops cover every variant derived from them: the closed and unfolded ones, the scripted, Intel and device laptops, and the olive, black and sand ones of Contact. A closed laptop plays like an open one.

The motorboats are not new actions: they are derived from `Ship_F` and not `Boat_F`, so ArmaRadio did not count them as a radio, the addon only does that. ArmaRadio's own action reaches them.

## Without the DLCs

The addon only needs the base game. The objects of the Helicopters (`Land_FlatTV_01_F`), Argo (`Land_Laptop_02_F`) and Contact (`Land_Laptop_03_*`) DLCs are told to ArmaRadio by name when they are created, so they are used when the DLC is loaded and the addon loads without it.

## Other objects

A mission can make any other object a radio with ArmaRadio's own Eden/Zeus module. The classes above are the ones that are a radio without it.
