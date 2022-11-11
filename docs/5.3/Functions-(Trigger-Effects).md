# Functions (Trigger Effects)

&nbsp;

Adaptive trigger effects are available for the DualSense gamepad on the PlayStation 5 console platform, as well as [Windows and Linux via Steamworks extension](Steamworks.md). In `MIXED` and `MULTIDEVICE` [source modes](Input-Sources.md#source-modes), only the first controller is used.

&nbsp;

## `input_trigger_effect_feedback(trigger, position, strength, [playerIndex])`

|Name           |Datatype|Purpose                                                                               |
|---------------|--------|--------------------------------------------------------------------------------------|
|`trigger`      |integer |Trigger to set using GameMaker’s native constants (`gp_shoulderlb` or `gp_shoulderrb`)|
|`position`     |number  |Analogue trigger axis value where feedback effect should activate, between 0 and 1    |
|`strength`     |number  |Strength of trigger effect, between 0 and 1                                           |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                  |

&nbsp;

## `input_trigger_effect_vibration(trigger, position, amplitude, frequency, [playerIndex])`

|Name           |Datatype|Purpose                                                                               |
|---------------|--------|--------------------------------------------------------------------------------------|
|`trigger`      |integer |Trigger to set using GameMaker’s native constants (`gp_shoulderlb` or `gp_shoulderrb`)|
|`position`     |number  |Analogue trigger axis value where vibration effect should activate, between 0 and 1   |
|`amplitude`    |number  |Amplitude of trigger effect, between 0 and 1                                          |
|`frequency`    |number  |Frequency of trigger effect, between 0 and 1                                          |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                  |

&nbsp;

## `input_trigger_effect_weapon(trigger, start, end, strength, [playerIndex])`

|Name           |Datatype|Purpose                                                                               |
|---------------|--------|--------------------------------------------------------------------------------------|
|`trigger`      |integer |Trigger to set using GameMaker’s native constants (`gp_shoulderlb` or `gp_shoulderrb`)|
|`start`        |number  |Analogue trigger axis value where weapon effect should start, between 0 and 1         |
|`end`          |number  |Analogue trigger axis value where weapon effect should end, between `start` and 1     |
|`strength`     |number  |Strength of trigger effect, between 0 and 1                                           |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                  |

&nbsp;

## `input_trigger_effect_get_state(trigger, [playerIndex])`

*Returns:* [Trigger effect state constant](Library-Constants?id=trigger-effect-states)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`trigger`      |integer |Trigger to set using GameMaker’s native constants (`gp_shoulderlb` or `gp_shoulderrb`)|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_trigger_effect_set_pause(state, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                                |
|---------------|--------|-------------------------------------------------------|
|`state`        |integer |Whether trigger effects should be paused for the player|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used   |

Pauses all trigger effects when `state` is `<false>`.  While paused, no new trigger effects are set.

&nbsp;

## `input_trigger_effect_get_pause([playerIndex])`

*Returns:* Boolean, whether trigger effects can proceed for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_trigger_effect_set_strength(strength, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`strength`     |number  |Overall strength for all trigger effects for the player |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used    |

&nbsp;

## `input_trigger_effect_strength([playerIndex])`

*Returns:* Number, the overall strength for all trigger effects for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;
