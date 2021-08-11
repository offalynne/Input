# Functions (History)

---

### `input_history_global_include(verb, ...)`

*Returns:* N/A (`undefined`)

|Name           |Datatype                                                             |Purpose                                                                                                         |
|---------------|---------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](https://github.com/JujuAdams/input3/wiki/Verbs-and-Alternates)|[Verb](https://github.com/JujuAdams/input3/wiki/Verbs-and-Alternates) to track whilst history is being recording|
|`...`          |[verb](https://github.com/JujuAdams/input3/wiki/Verbs-and-Alternates)|Additional verb(s) to track                                                                                     |

Sets which verbs should be recorded by the history functions laid out below. This is a global setting and should be executed once at the start of the game.

Please see [`input_history_get()`](Functions-(History)#input_history_getplayerindex) for a description of verb events.

&nbsp;

&nbsp;

### `input_history_start([playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Starts verb history recording for the given player. This function won't wipe existing verb history, for that please use [`input_history_clear()`](Functions-(History)#input_history_clearplayerindex).

&nbsp;

&nbsp;

### `input_history_clear([playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Clears the verb history for the given player. This function won't start or end history recording, please use the associated functions for that.

&nbsp;

&nbsp;

### `input_history_get([playerIndex])`

*Returns:* Array of verb event structs, see below

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Returns the verb history for the given player, see below for the layout of the data. This function won't start or end history recording, please use the associated functions for that.

The array returned by the function contains structs representing verb events: points in time where the **value** of a verb has changed. Each struct has three member variables:

|Variable|Dataype                                                              |Purpose                                                                                                                                                                      |
|--------|---------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`  |[verb](https://github.com/JujuAdams/input3/wiki/Verbs-and-Alternates)|Verb for this event                                                                                                                                                          |
|`value` |number                                                               |Value of the verb when the state changed. For verbs driven by buttons, a value of `1` indicates a verb has been pressed and a value of `0` indicates a verb has been released|
|`time`  |number                                                               |The time when the verb's state changed. Time units are controlled by [`INPUT_TIMER_MILLISECONDS`](Functions-(System)#__input_config)                                         |

&nbsp;

&nbsp;

### `input_history_end([playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Ends verb recording for the given player. This function won't wipe existing verb history, for that please use [`input_history_clear()`](Functions-(History)#input_history_clearplayerindex).