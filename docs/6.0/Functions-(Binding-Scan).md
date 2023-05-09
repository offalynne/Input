# Functions (Binding Scan)

&nbsp;

## `input_binding_scan_start(successCallback, [failureCallback], [sourceFilter], [playerIndex])`

_Returns:_ N/A (`undefined`)

|Name               |Datatype                         |Purpose                                                                                                                 |
|-------------------|---------------------------------|------------------------------------------------------------------------------------------------------------------------|
|`successCallback`  |method                           |Callback function to execute when the binding scan process completes successfully                                       |
|`[failureCallback]`|method                           |Callback function to execute when the binding scan process fails. If not specified, no function is executed upon failure|
|`[sourceFilter]`   |array of [sources](Input-Sources)|[Input sources](Input-Sources) to listen to. If not specified, all of the chosen player's current sources are used      |
|`[playerIndex]`    |integer                          |Player to target. If not specified, player 0 is targeted                                                                |

This function will scan for input from a player and then execute a callback when a new, valid input was detected. The success callback is passed a single argument which is the new binding that corresponds to the detected input. After you receive the new binding in the success callback, you should then set that binding for the desired verb using `input_binding_set_safe()` (or `input_binding_set()` if you want to live dangerously).

Bindings that have not been emitted by [sources](Input-Sources) defined by the `sourceFilter` argument will be ignored.

If something unexpected happens (for example, the player's gamepad is disconnected) then this function will attempt to execute the failure callback. The failure callback is given a single argument too, though this time the value is an error code from the `INPUT_BINDING_SCAN_EVENT` enum. Error codes that this function can return are as follows:

|Name                 |Meaning                                                                                                                                                                      |
|---------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`.SOURCE_INVALID`    |Player's source is invalid, usually because they have no sources assigned or their gamepad has been disconnected                                                             |
|`.SOURCE_CHANGED`    |The player's source (or sources) have been modified                                                                                                                          |
|`.PLAYER_IS_GHOST`   |Player is a ghost and cannot receive hardware input                                                                                                                          |
|`.SCAN_TIMEOUT`      |Either the player didn't enter a new binding or a stuck key prevented the system from working. The timeout period is defined by [`INPUT_BINDING_SCAN_TIMEOUT`](Configuration)|
|`.LOST_FOCUS`        |The application lost focus                                                                                                                                                   |
|`.PLAYER_DISCONNECTED`        |The player disconnected                                                                                                                                                   |
|`.ABORTED`           |Binding scan was aborted early due to `input_binding_scan_abort()` being called                                                                                              |

&nbsp;

## `input_binding_scan_abort([playerIndex])`

_Returns:_ N/A (`undefined`)

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is targeted|

Aborts binding scanning for the given player.

&nbsp;

## `input_binding_scan_in_progress([playerIndex])`

_Returns:_ Boolean, whether the given player is currently scanning for bindings

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is targeted|

&nbsp;

## `input_binding_scan_set_params([ignoreArray], [allowArray], [sourceFilter], [playerIndex])`

_Returns:_ N/A (`undefined`)

|Name            |Datatype|Purpose                                                                                                                                                    |
|----------------|--------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
|`[ignoreArray]` |array   |Array of keyboard keys (`vk_*`, `"A"`), mouse buttons (`mb_*`), or gamepad constants (`gp_*`) to explicitly disallow being scanned                         |
|`[allowArray]`  |array   |Array of keyboard keys (`vk_*`, `"A"`), mouse buttons (`mb_*`), or gamepad constants (`gp_*`) to explicitly scan for, excluding all other possible bindings|
|`[sourceFilter]`|array   |Array of sources to scan. If not specified, the sources currently assigned to the target player will be scanned                                            |
|`[playerIndex]` |integer |Player to target. If not specified, player 0 is targeted                                                                                                   |

This function sets up arrays of potential bindings to ignore or allow. This allows the developer to filter out potentially problematic rebindings that could interfere with stable operation.

?> If a constant appear in both lists, the "ignore" array takes precedence and the binding will be ignored.

!> Unfortunately, earlier versions of GameMaker don't have a constant for mouse wheel up/down. Instead, to specify that mouse wheel bindings should be ignore/allowed, please use the strings `"mouse wheel up"` and `"mouse wheel down"` in lieu of constants.

&nbsp;

## `input_binding_scan_get_params([playerIndex])`

_Returns:_ Struct, the binding scanning parameters set by `input_binding_scan_set_params()`

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is targeted|

The struct returned by this function has three elements (`.ignore_array` `.allow_array` `.source_filter`) which corresponds to the values passed to `input_binding_scan_set_params()`. Editing the content in the returned struct will not implictly change behaviour for binding scanning, and the order of elements in arrays returned by this function may not exactly match what was set via `input_binding_scan_set_params()`.

&nbsp;

## `input_binding_scan_clear_params([playerIndex])`

_Returns:_ N/A (`undefined`)

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is targeted|

Clears the parameters set for binding scanning for the given player. No bindings are ignored, no bindings are explicitly allowed.