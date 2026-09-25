# Compatibility

## Misery

AVO matches nicely with [Misery](https://github.com/TenuredCLOUD/Misery), a survival framework for scenario designers. They work together without any setup, AVO does not need Misery and is not affiliated with it.

### Camping

Misery lets you sleep in tents, it looks at the model of the object you look at. The solar tents (four colours), the dome tent and the A-frame tent are on its list, and these are exactly the tents you can [set up and pack up](objects/tents.md) with AVO. Carry the packed tent, set it up where you want to camp, sleep in it with Misery, and pack it up again in the morning.

The larger tents (decon, connector and medical tents) have [door actions](objects/animations.md#tents) but are not beds for Misery.

### Weather

The [weather station](objects/weather.md) shows the wind chill when it is cold and windy and the heat index when it is warm and humid. They are calculated with the same ACE weather formulas Misery uses for the temperature of your character, so what you read at the station is what your character feels.

### Missions and persistence

Misery supports GRAD persistence. A tent that is set up at runtime is not saved by it on its own, use the [`avo_tents_setUp` and `avo_tents_packedUp` events](scripting.md#events) to register it in your mission.

### Advanced Equipment

Misery requires [Advanced Equipment](https://github.com/y0014984/Advanced-Equipment) (AE3). With it loaded, the [solar panel controls](objects/animations.md#solar-panels) of AVO are skipped, AE3 has its own. Everything else of AVO works as usual.
