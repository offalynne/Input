# Functions (Binding Creators)

&nbsp;

## `input_value_is_binding(value)`

_Returns:_ Boolean, if the value is a valid binding struct

|Name   |Datatype|Purpose       |
|-------|--------|--------------|
|`value`|any     |Value to check|

Useful for verifying if a value returned from [`input_binding_scan_tick()`]() or [`input_binding_get()`]() is a binding.

&nbsp;

The functions on this page allow you to create bindings, either to define [default profiles](Profiles), [change bindings](Functions-(Binding-Access)), or to build out [custom profiles](Functions-(Profiles)).

&nbsp;

## `input_binding_empty()`

*Returns:* Struct, an empty (inactive) binding

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `input_binding_key(key)`

*Returns:* Struct, a keyboard binding

|Name |Datatype|Purpose                                                                                                                  |
|-----|--------|-------------------------------------------------------------------------------------------------------------------------|
|`key`|integer |[Key](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to bind|

&nbsp;

## `input_binding_mouse_button(button)`

*Returns:* Struct, a mouse button binding

|Name    |Datatype|Purpose                                                                                                                                               |
|--------|--------|------------------------------------------------------------------------------------------------------------------------------------------------------|
|`button`|integer |[Mouse button](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FMouse_Input%252FMouse_Input.htm) to bind|

&nbsp;

## `input_binding_mouse_wheel_up()`

*Returns:* Struct, a mouse wheel binding

|Name|Datatype      |Purpose       |
|----|--------------|--------------|
|None|              |              |

&nbsp;

## `input_binding_mouse_wheel_down()`

*Returns:* Struct, a mouse wheel binding

|Name|Datatype      |Purpose       |
|----|--------------|--------------|
|None|              |              |

&nbsp;

## `input_binding_gamepad_button(button)`

*Returns:* Struct, a gamepad button binding

|Name    |Datatype|Purpose                                                                                                                            |
|--------|--------|-----------------------------------------------------------------------------------------------------------------------------------|
|`button`|integer |[Gamepad button](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to bind|

&nbsp;

## `input_binding_gamepad_axis(axis, negative)`

*Returns:* Struct, a gamepad axis binding

|Name      |Datatype|Purpose                                                                                                                          |
|----------|--------|---------------------------------------------------------------------------------------------------------------------------------|
|`axis`    |integer |[Gamepad axis](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to bind|
|`negative`|boolean |Whether the axis expects negative values                                                                                         |

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
