# Functions (Binding System)

&nbsp;

## `input_binding_system_reset([playerIndex], [resetThresholds])`

*Returns:* N/A (`undefined`)

|Name               |Datatype|Purpose                                                                                                                                                      |
|-------------------|--------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`[playerIndex]`    |integer |Player to target. If not specified, bindings for all players are reset                                                                                       |
|`[resetThresholds]`|boolean |Whether to reset axis thresholds as well. Defaults to `true`, resetting [axis thresholds](Functions-(Other)#input_axis_threshold_setaxis-min-max-playerindex)|

Clears the currently profiles and bindings for the given player, resetting them to the defaults set up in [`INPUT_DEFAULT_PROFILES`](Configuration?id=profiles-and-bindings). This function will remove all non-default profiles from the player.

&nbsp;

## `input_binding_system_write([playerIndex])`

*Returns:* JSON encoded as a string

|Name           |Datatype|Purpose                                                            |
|---------------|--------|-------------------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, all player bindings are encoded|

Outputs a string that contains a JSON definition for the given bindings. This can then be saved to a file etc. so that custom bindings can be restored in the future.

This function also serialises axis thresholds (as set by [`axis_threshold_set()`](Functions-(Other)#input_axis_threshold_setaxis-min-max-playerindex)).

It is reccomended to only use bindings written on the same device, as keyboard scancodes differ across device layouts and platforms.

!> Due to [up-stream bugs](https://github.com/JujuAdams/Input/issues/152) in GameMaker's JavaScript runtime, this function is not supported in HTML5.

&nbsp;

## `input_binding_system_read(string, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                              |
|---------------|--------|-----------------------------------------------------------------------------------------------------|
|`string`       |string  |JSON encoded as a string, as returned by [`input_bindings_write()`](Functions-(Binding-Management)#input_bindings_writeplayerindex)|
|`[playerIndex]`|integer |Player to target. If not specified, all player bindings are set                                      |

Reads a JSON string that contains binding definitions. Such a string should be created using [`input_bindings_write()`](Functions-(Binding-Management)#input_bindings_readstring-playerindex).

This function also deserialises axis thresholds (as set by [`axis_threshold_set()`](Functions-(Other)#input_axis_threshold_setaxis-min-max-playerindex)).

While useful for retaining player preferences across sessions, [default bindings](Functions-(Default-Bindings)) must still be set directly before reading bindings with this function. It is reccomended to only use bindings written on the same device, as keyboard scancodes differ across device layouts and platforms.

!> Due to [up-stream bugs](https://github.com/JujuAdams/Input/issues/152) in GameMaker's JavaScript runtime, this function is not supported in HTML5.

&nbsp;

## `input_binding_system_copy(sourcePlayerIndex, destinationPlayerIndex)`

*Returns:* N/A (`undefined`)

|Name                    |Datatype|Purpose                     |
|------------------------|--------|----------------------------|
|`sourcePlayerIndex`     |integer |Player to copy bindings from|
|`destinationPlayerIndex`|integer |Player to copy bindings to  |

Duplicates one player's bindings and copies them over to another player (including [axis thresholds](Functions-(Other)#input_axis_threshold_setaxis-min-max-playerindex)).

&nbsp;

## `input_binding_system_swap_gamepad_ab(state)`

*Returns:* N/A (`undefined`)

|Name   |Datatype|Purpose                                   |
|-------|--------|------------------------------------------|
|`state`|boolean |Whether to automatically swap A/B bindings|

Swapping A/O with B/X is a global setting and, once set, cannot be changed during game operation. As a result, this function should be called once at the start of the game before [`input_default_gamepad_button()`](Functions-(Default-Bindings)#input_default_gamepad_buttonbutton-verb-alternate) and [`input_default_joycon_button()`](Functions-(Default-Bindings)#input_default_joycon_buttonbutton-verb-alternate).

If you *would* like to swap A/O with B/X during gameplay, please use the [binding functions](Functions-(Bindings)).
