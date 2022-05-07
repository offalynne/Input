# Functions (Binding System)

&nbsp;

## `input_bindings_reset([source], [playerIndex], [resetThresholds])`

*Returns:* N/A (`undefined`)

|Name               |Datatype       |Purpose                                                                                                                                                      |
|-------------------|---------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`[source]`         |[`INPUT_SOURCE`](Input-Sources)|[Input source](Input-Sources) to target. If not specified, binding for all sources are reset                                                 |
|`[playerIndex]`    |integer        |Player to target. If not specified, bindings for all players are reset                                                                                       |
|`[resetThresholds]`|boolean        |Whether to reset axis thresholds as well. Defaults to `true`, resetting [axis thresholds](Functions-(Other)#input_axis_threshold_setaxis-min-max-playerindex)|

Clears the currently bindings for the given player, resetting them to the [defaults](Functions-(Default-Bindings)).

&nbsp;

## `input_bindings_write([playerIndex])`

*Returns:* JSON encoded as a string

|Name           |Datatype|Purpose                                                            |
|---------------|--------|-------------------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, all player bindings are encoded|

Outputs a string that contains a JSON definition for the given bindings. This can then be saved to a file etc. so that custom bindings can be restored in the future.

This function also serialises axis thresholds (as set by [`axis_threshold_set()`](Functions-(Other)#input_axis_threshold_setaxis-min-max-playerindex)).

It is reccomended to only use bindings written on the same device, as keyboard scancodes differ across device layouts and platforms.

!> Due to [up-stream bugs](https://github.com/JujuAdams/Input/issues/152) in GameMaker's JavaScript runtime, this function is not supported in HTML5.

&nbsp;

## `input_bindings_read(string, [playerIndex])`

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

## `input_bindings_copy(source, destination)`

*Returns:* N/A (`undefined`)

|Name         |Datatype|Purpose                     |
|-------------|--------|----------------------------|
|`source`     |integer |Player to copy bindings from|
|`destination`|integer |Player to copy bindings to  |

Duplicates one player's bindings and copies them over to another player (including [axis thresholds](Functions-(Other)#input_axis_threshold_setaxis-min-max-playerindex)).