# Functions

## Placement functions

The 3D ghost placement flow (`fnc_place.sqf`, `fnc_startBuild.sqf`) is adapted from the "deployable" framework of
[tactical-tarps](https://github.com/TacticalTrainingTeam/tactical-tarps), which in turn is adapted from:

- [ACE3 `fortify`](https://github.com/acemod/ACE3/tree/master/addons/fortify) addon, particularly
  `fnc_deployObject.sqf` and `fnc_deployConfirm.sqf` - Licensed under GNU General Public License
- [grad-fortifications](https://github.com/gruppe-adler/grad-fortifications) - Licensed under GNU General Public License

Both place a local-only preview object that follows the caller's view each frame and is confirmed/cancelled
with the mouse, before spawning the real object at the confirmed position/orientation.

The functions in this folder are therefore licensed under the GNU General Public License, see [LICENSE](./LICENSE),
unlike the rest of this repository.
