# Functions (Binding Access)

&nbsp;

## `input_binding_is_valid(binding, [playerIndex])`

_Returns:_ Boolean, if the value is a valid binding for the specified player on the current platform

|Name           |Datatype|Purpose                                                                                                                                                                                                                                                           |
|---------------|--------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`binding`      |binding |Binding to check against, as returned by [`input_binding_scan_tick()`](<Functions-(Binding-Management)#input_binding_scan_ticksource-playerindex>) or [`input_binding_get()`](<Functions-(Binding-Management)#input_binding_getverb-source-playerindex-alternate>)|
|`[playerIndex]`|integer |Player to validate against. If not specified, player 0 is targeted                                                                                                                                                                                                |

Useful for verifying if a binding returned by [`input_binding_get()`](<Functions-(Binding-Management)#input_binding_getverb-source-playerindex-alternate>) is valid for the specified player on the current platform, especially when set with [default binding functions](<Functions-(Default-Bindings)>).

&nbsp;

## `input_binding_set(verb, binding, [playerIndex], [alternate], [profileName])`

_Returns:_ N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                                                                                                                                                                                 |
|---------------|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target                                                                                                                                                                                                          |
|`binding`      |binding                             |Binding to set, as returned by [`input_binding_scan_tick()`](<Functions-(Binding-Management)#input_binding_scan_ticksource-playerindex>) or [`input_binding_get()`](<Functions-(Binding-Management)#input_binding_getverb-source-playerindex-alternate>)|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                                                                                                                                                                                    |
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Bindings) to target. If not specified, `0` is used                                                                                                                                                              |
|`[profileName]`|string                              |The [profile](Profiles) to set the verb binding for. If no profile is provided then the current profile is used                                                                                                                                         |

Straightforwardly sets the binding for a verb, overwriting what was already there.

&nbsp;

## `input_binding_set_safe(verb, binding, [playerIndex], [alternate], [profileName])`

_Returns:_ N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                                                                                                                                                                                 |
|---------------|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target                                                                                                                                                                                                          |
|`binding`      |binding                             |Binding to set, as returned by [`input_binding_scan_tick()`](<Functions-(Binding-Management)#input_binding_scan_ticksource-playerindex>) or [`input_binding_get()`](<Functions-(Binding-Management)#input_binding_getverb-source-playerindex-alternate>)|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                                                                                                                                                                                    |
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Bindings) to target. If not specified, `0` is used                                                                                                                                                              |
|`[profileName]`|string                              |                                                                                                                                                                                                                                                        |

In contrast to [`input_binding_set()`](<Functions-(Binding-Management)#input_binding_setverb-binding-playerindex-alternate>), this function will set the binding for a verb but also try to automatically handle any input conflicts by swapping over bindings. This is effective for simple control schemes but may fail in more complex situations - in these cases, you'll need to handle conflict resolution yourself.

&nbsp;

## `input_binding_get(verb, [playerIndex], [alternate], [profileName])`

_Returns:_ Struct. See below.

|Name           |Datatype                            |Purpose                                                                                                                                             |
|---------------|------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target                                                                                                      |
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used. You may also use `"default"` as the player index to retrieve the default binding for this verb|
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Bindings) to target. If not specified, `0` is used                                                          |
|`[profileName]`|string                              |                                                                                                                                                    |

This function returns a struct that describes the binding for the given verb. It has the following member variables:

|Variable        |Datatype|Purpose                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|----------------|--------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`.type`         |string  |Type of binding, one of the following:<br>`"key"` `"gamepad button"` `"gamepad axis"` `"mouse button"` `"mouse wheel up"` `"mouse wheel down"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|`.value`        |integer |[Keycode](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FKeyboard_Input%252FKeyboard_Input.htm), [gamepad button](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm), [gamepad axis](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm), or [mouse button](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FMouse_Input%252FMouse_Input.htm) that this binding uses. This variable is `undefined` for `"mouse wheel up"` and `"mouse wheel down"` types|
|`.axis_negative`|boolean |Whether this binding expects negative values (`"gamepad axis"` type only)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |

&nbsp;

## `input_binding_test_collisions(verb, binding, [playerIndex], [profileName])`

_Returns:_ Array of structs containing conflicting verb/alternate indexes

|Name           |Datatype                            |Purpose                                                                                                                                                                                                                                                           |
|---------------|------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target                                                                                                                                                                                                                    |
|`binding`      |binding                             |Binding to check against, as returned by [`input_binding_scan_tick()`](<Functions-(Binding-Management)#input_binding_scan_ticksource-playerindex>) or [`input_binding_get()`](<Functions-(Binding-Management)#input_binding_getverb-source-playerindex-alternate>)|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                                                                                                                                                                                              |
|`[profileName]`|string                              |                                                                                                                                                                                                                                                                  |

The array that this function returns contains structs that define which verb bindings conflict with the given binding. If the array is empty then there are no conflicting bindings.

The structs returned in the array contain the following:

|Variable    |Datatype                            |Purpose                     |
|------------|------------------------------------|----------------------------|
|`.verb`     |[verb](Verbs-and-Bindings)|Verb binding that conflicts |
|`.alternate`|integer                             |Alternate index for the verb|

&nbsp;

## `input_binding_remove(verb, [playerIndex], [alternate], [profileName])`

_Returns:_ N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                   |
|---------------|------------------------------------|------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Bindings)|[Verb](Verbs-and-Bindings) to target                                            |
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                      |
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Bindings) to target. If not specified, `0` is used|
|`[profileName]`|string                              |                                                                                          |

Removes a binding from Input. **Be very careful with this function!** It's possible to remove any binding and this could potentially make your game unplayable.

&nbsp;

## `input_binding_swap(verbA, alternateA, verbB, alternateB, [source], [playerIndex], [profileName])`

_Returns:_ N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                        |
|---------------|------------------------------------|-------------------------------------------------------------------------------|
|`verbA`        |[verb](Verbs-and-Bindings)|First [verb](Verbs-and-Bindings) to target                           |
|`alternateA`   |integer                             |[Alternate binding](Verbs-and-Bindings) to target for the first verb |
|`verbB`        |[verb](Verbs-and-Bindings)|Second [verb](Verbs-and-Bindings) to target                          |
|`alternateB`   |integer                             |[Alternate binding](Verbs-and-Bindings) to target for the second verb|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                           |
|`[profileName]`|string                              |                                                                               |

Swaps over the two verb bindings specified.

&nbsp;

## `input_binding_get_icon(binding, [playerIndex])`

_Returns:_ Various, the icon identifier defined in [`__input_config_icons()`](Configuration?id=icons)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`binding`      |binding |Binding to return the icon for                      |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Returns the icon associated with the given binding for the device that the given player is currently using. You should edit [`__input_config_icons()`](Configuration?id=icons) to match the requirements of your game.

For example, `input_binding_get_icon(input_binding_get("jump"))` will return an icon for the device matching the binding for the "jump" verb if it is defined.

&nbsp;

## `input_binding_get_name(binding)`

_Returns:_ String, the human-readable [name for the binding](Binding-Names)

|Name     |Datatype|Purpose                       |
|---------|--------|------------------------------|
|`binding`|binding |Binding to return the name for|

Returns the [name of the binding](Binding-Names) in a way that is (mostly!) human-readable. This string can be the name of a keyboard key or the name of a gamepad axis, including direction of travel. The intention is for this information to be parsed by your own code and then used to display a string or icon to the player indicating which button/key etc. is associated with which verb. All return values are listed as [Binding Names](Binding-Names).

For example, `input_binding_get_name(input_binding_get("jump"))` will return the name of the binding for the "jump" verb if it is defined, or "not a binding" otherwise.

?> In situations where you are displaying control prompt to a player, `input_binding_get_icon()` is likely to be more useful.

&nbsp;

## `input_binding_gamepad_set(binding. gamepad)`

_Returns:_ N/A (`undefined`)

|Name     |Datatype                     |Purpose                                          |
|---------|-----------------------------|-------------------------------------------------|
|`binding`|[binding](Verbs-and-Bindings)|[Binding](Verbs-and-Bindings) to target|

?> The gamepad index for a binding is only relevant when in the [multidevice source mode](Input-Sources?id=source-modes).

&nbsp;

## `input_binding_gamepad_get(binding)`

_Returns:_ Integer, the gamepad index for the binding

|Name     |Datatype                     |Purpose                                          |
|---------|-----------------------------|-------------------------------------------------|
|`binding`|[binding](Verbs-and-Bindings)|[Binding](Verbs-and-Bindings) to target|

If no gamepad has been set, this function returns `undefined`.

?> The gamepad index for a binding is only relevant when in the [multidevice source mode](Input-Sources?id=source-modes).

&nbsp;

## `input_binding_threshold_set(binding, min, max)`

_Returns:_ N/A (`undefined`)

|Name     |Datatype                     |Purpose                                          |
|---------|-----------------------------|-------------------------------------------------|
|`binding`|[binding](Verbs-and-Bindings)|[Binding](Verbs-and-Bindings) to target|
|`min`    |number                       |Minimum threshold for this binding               |
|`max`    |number                       |Maximum threshold for this binding               |

Sets the minimum and maximum threshold values for this binding. This is only relevant when applied to a [gamepad axis binding](Functions-(Binding-Creators)?id=input_binding_gamepad_axisaxis-negative).

This function is entirely optional. If a gamepad axis binding has no specific thresholds set then the player's axis thresholds are used, as set by [`input_axis_thresholds_set()`](Functions-(Other)?id=input_axis_threshold_setaxis-min-max-playerindex).

&nbsp;

## `input_binding_threshold_get(binding)`

_Returns:_ A struct with two member variables, `.mini` and `.maxi`, containing the minimum and maximum thresholds

|Name     |Datatype                     |Purpose                                          |
|---------|-----------------------------|-------------------------------------------------|
|`binding`|[binding](Verbs-and-Bindings)|[Binding](Verbs-and-Bindings) to target|
