# Radios (`avo_radios_armaradio`)

More vanilla objects that play radio stations with [ArmaRadio](https://github.com/BrettMayson/ArmaRadio) (Live Radio, [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2172022102)). ArmaRadio itself covers every car, tank, helicopter, plane and boat (`Boat_F`), and three objects: the FM radio, the survival radio and the portable speakers. This optional addon adds a few more. It needs ArmaRadio and is skipped without it, ArmaRadio does not need AVO.

Look at the object and choose **FM Radio** (the name ArmaRadio gives its action), which opens the ArmaRadio interface. Anything ArmaRadio can do, like the volume, the stations and the multiplayer sync, works as it does for its own objects. The action is shown for everyone within 5 m, ArmaRadio's settings for vehicles do not apply to these objects.

## Objects

| Object | Classname |
| --- | --- |
| Smartphone | `Land_MobilePhone_smart_F` |
| Laptops | `Land_Laptop_F`, `Land_Laptop_unfolded_F`, `Land_Laptop_02_F`, `Land_Laptop_02_unfolded_F`, `Land_Laptop_03_*` |
| Tablets (Helicopters, Apex) | `Land_Tablet_01_F`, `Land_Tablet_02_F`, `Land_Tablet_02_sand_F`, `Land_Tablet_02_black_F` |

The laptops cover every variant derived from them: the closed and unfolded ones, the scripted, Intel and device laptops, and the olive, black and sand ones of Contact. A closed laptop plays like an open one.

## Without the DLCs

The addon only needs the base game. The tablets of the Helicopters (`Land_Tablet_01_F`) and Apex (`Land_Tablet_02_F`) DLCs and the laptops of the Argo (`Land_Laptop_02_F`) and Contact (`Land_Laptop_03_*`) DLCs are told to ArmaRadio by name when they are created, so they are used when the DLC is loaded and the addon loads without it.

## Other objects

A mission can make any other object a radio with ArmaRadio's own Eden/Zeus module, like the motorboats, the satellite phone, the old mobile phone, the loudspeakers or the flat TV. The classes above are the ones that are a radio without it.
