# Functions (Vibration)

&nbsp;

## `input_vibrate_constant(strength, pan, duration, [playerIndex], [force])`

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                                                                                          |
|---------------|-------------------|-----------------------------------------------------------------------------------------------------------------|
|`strength`     |number             |Strength of the vibration event, from `0.0` to `1.0`                                                             |
|`pan`          |number             |Left-to-right bias for the vibration event. `-1.0` indicates fully left and `1.0` indicates fully right          |
|`duration`     |frames/milliseconds|Duration of the vibration event, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used                                                             |
|`[force]`      |boolean            |Whether this event should ignore the "vibration paused" state for the player. If not specified, `false` is used  |

Sets up a constant-strength vibration event for the given duration.

&nbsp;

## `input_vibrate_adsr(peakStrength, sustainLevel, pan, attack, decay, sustain, release, [playerIndex], [force])`

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                                                                                                                                 |
|---------------|-------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
|`peakStrength` |number             |Peak strength of the vibration event at the top of the attack portion of the curve, from `0.0` to `1.0`                                                 |
|`sustainLevel` |number             |Relative strength of the sustain portion of the curve. `0.0` indicates no sustain, `1.0` indicates sustain strength should be equal to the peak strength|
|`pan`          |number             |Left-to-right bias for the vibration event. `-1.0` indicates fully left and `1.0` indicates fully right                                                 |
|`attack`       |frames/milliseconds|Duration of the attack portion of the curve, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)                           |
|`decay`        |frames/milliseconds|Duration of the decay portion of the curve, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)                            |
|`sustain`      |frames/milliseconds|Duration of the sustain portion of the curve, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)                          |
|`release`      |frames/milliseconds|Duration of the release portion of the curve, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)                          |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used                                                                                                    |
|`[force]`      |boolean            |Whether this event should ignore the "vibration paused" state for the player. If not specified, `false` is used                                         |

Sets up a vibration event that follows an attack-decay-sustain-release curve. This is likely familiar to you if you've fiddled with audio synthesis before, and the same principles apply to vibration events too.

&nbsp;

## `input_vibrate_pulse(strength, pan, repeats, duration, [playerIndex], [force])`

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                                                                                          |
|---------------|-------------------|-----------------------------------------------------------------------------------------------------------------|
|`strength`     |number             |Strength of the vibration event, from `0.0` to `1.0`                                                             |
|`pan`          |number             |Left-to-right bias for the vibration event. `-1.0` indicates fully left and `1.0` indicates fully right          |
|`repeats`      |integer            |Numbers of pulses to execute over the course of the vibration event                                              |
|`duration`     |frames/milliseconds|Duration of the vibration event, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used                                                             |
|`[force]`      |boolean            |Whether this event should ignore the "vibration paused" state for the player. If not specified, `false` is used  |

Sets up a vibration event that emits a fixed number of pulses over the given duration.

&nbsp;

## `input_vibrate_curve(strength, curve, pan, duration, [playerIndex], [force])`

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                                                                                          |
|---------------|-------------------|-----------------------------------------------------------------------------------------------------------------|
|`strength`     |number             |Strength of the vibration event, from `0.0` to `1.0`                                                             |
|`curve`        |animation curve    |Animation curve to follow                                                                                        |
|`pan`          |number             |Left-to-right bias for the vibration event. `-1.0` indicates fully left and `1.0` indicates fully right          |
|`duration`     |frames/milliseconds|Duration of the vibration event, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used                                                             |
|`[force]`      |boolean            |Whether this event should ignore the "vibration paused" state for the player. If not specified, `false` is used  |

Sets up a vibration event that follows an animation curve defined in the GameMaker IDE.

&nbsp;

## `input_vibrate_stop([playerIndex])`

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Immediately stops all vibration for the target player.

&nbsp;

## `input_vibrate_set_pause(state, [playerIndex])`

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`state`        |number  |Whether vibration events should be paused for the player|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used    |

Whilst player vibration is paused, typically no new vibration events can be created for the player in question. If you'd still like to create vibration events for the player even when vibration is paused (e.g. for previewing vibration strength on a settings menu), set the optional `force` argument for vibration events to `true`.

&nbsp;

## `input_vibrate_get_pause([playerIndex])`

**Returns:** Boolean, whether vibration events can proceed for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_vibrate_set_strength(strength, [playerIndex])`

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`strength`     |number  |Overall strength for all vibration events for the player|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used    |

&nbsp;

## `input_vibrate_get_strength([playerIndex])`

**Returns:** Number, the overall strength for all vibration events for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|