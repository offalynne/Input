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
|`verb`         |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target                                                                                                                                                                                                          |
|`binding`      |binding                             |Binding to set, as returned by [`input_binding_scan_tick()`](<Functions-(Binding-Management)#input_binding_scan_ticksource-playerindex>) or [`input_binding_get()`](<Functions-(Binding-Management)#input_binding_getverb-source-playerindex-alternate>)|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                                                                                                                                                                                    |
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Alternate-Bindings) to target. If not specified, `0` is used                                                                                                                                                              |
|`[profileName]`|string                              |                                                                                                                                                                                                                                                        |

Straightforwardly sets the binding for a verb, overwriting what was already there.

&nbsp;

## `input_binding_set_safe(verb, binding, [playerIndex], [alternate], [profileName])`

_Returns:_ N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                                                                                                                                                                                 |
|---------------|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target                                                                                                                                                                                                          |
|`binding`      |binding                             |Binding to set, as returned by [`input_binding_scan_tick()`](<Functions-(Binding-Management)#input_binding_scan_ticksource-playerindex>) or [`input_binding_get()`](<Functions-(Binding-Management)#input_binding_getverb-source-playerindex-alternate>)|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                                                                                                                                                                                    |
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Alternate-Bindings) to target. If not specified, `0` is used                                                                                                                                                              |
|`[profileName]`|string                              |                                                                                                                                                                                                                                                        |

In contrast to [`input_binding_set()`](<Functions-(Binding-Management)#input_binding_setverb-binding-playerindex-alternate>), this function will set the binding for a verb but also try to automatically handle any input conflicts by swapping over bindings. This is effective for simple control schemes but may fail in more complex situations - in these cases, you'll need to handle conflict resolution yourself.

&nbsp;

## `input_binding_get(verb, [playerIndex], [alternate], [profileName])`

_Returns:_ Struct. See below.

|Name           |Datatype                            |Purpose                                                                                                                                             |
|---------------|------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target                                                                                                      |
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used. You may also use `"default"` as the player index to retrieve the default binding for this verb|
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Alternate-Bindings) to target. If not specified, `0` is used                                                          |
|`[profileName]`|string                              |                                                                                                                                                    |

This function returns a struct that describes the binding for the given verb. It has the following member variables:

|Variable        |Datatype|Purpose                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|----------------|--------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`.type`         |string  |Type of binding, one of the following:<br>`"key"` `"gamepad button"` `"gamepad axis"` `"mouse button"` `"mouse wheel up"` `"mouse wheel down"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|`.value`        |integer |[Keycode](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/keyboard%20input/index.html), [gamepad button](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html), [gamepad axis](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html), or [mouse button](https://docs.yoyogames.com/source/dadiospice/002_reference/mouse,%20keyboard%20and%20other%20controls/mouse%20input/index.html) that this binding uses. This variable is `undefined` for `"mouse wheel up"` and `"mouse wheel down"` types|
|`.axis_negative`|boolean |Whether this binding expects negative values (`"gamepad axis"` type only)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |

&nbsp;

## `input_binding_test_collisions(verb, binding, [playerIndex], [profileName])`

_Returns:_ Array of structs containing conflicting verb/alternate indexes

|Name           |Datatype                            |Purpose                                                                                                                                                                                                                                                           |
|---------------|------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target                                                                                                                                                                                                                    |
|`binding`      |binding                             |Binding to check against, as returned by [`input_binding_scan_tick()`](<Functions-(Binding-Management)#input_binding_scan_ticksource-playerindex>) or [`input_binding_get()`](<Functions-(Binding-Management)#input_binding_getverb-source-playerindex-alternate>)|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                                                                                                                                                                                              |
|`[profileName]`|string                              |                                                                                                                                                                                                                                                                  |

The array that this function returns contains structs that define which verb bindings conflict with the given binding. If the array is empty then there are no conflicting bindings.

The structs returned in the array contain the following:

|Variable    |Datatype                            |Purpose                     |
|------------|------------------------------------|----------------------------|
|`.verb`     |[verb](Verbs-and-Alternate-Bindings)|Verb binding that conflicts |
|`.alternate`|integer                             |Alternate index for the verb|

&nbsp;

## `input_binding_remove(verb, [playerIndex], [alternate], [profileName])`

_Returns:_ N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                   |
|---------------|------------------------------------|------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target                                            |
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                      |
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Alternate-Bindings) to target. If not specified, `0` is used|
|`[profileName]`|string                              |                                                                                          |

Removes a binding from Input. **Be very careful with this function!** It's possible to remove any binding and this could potentially make your game unplayable.

&nbsp;

## `input_binding_swap(verbA, alternateA, verbB, alternateB, [source], [playerIndex], [profileName])`

_Returns:_ N/A (`undefined`)

|Name            |Datatype                            |Purpose                                                                        |
|----------------|------------------------------------|-------------------------------------------------------------------------------|
|`.verbA`        |[verb](Verbs-and-Alternate-Bindings)|First [verb](Verbs-and-Alternate-Bindings) to target                           |
|`.alternateA`   |integer                             |[Alternate binding](Verbs-and-Alternate-Bindings) to target for the first verb |
|`.verbB`        |[verb](Verbs-and-Alternate-Bindings)|Second [verb](Verbs-and-Alternate-Bindings) to target                          |
|`.alternateB`   |integer                             |[Alternate binding](Verbs-and-Alternate-Bindings) to target for the second verb|
|`[.playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                           |
|`[.profileName]`|string                              |                                                                               |

Swaps over the two verb bindings specified.

&nbsp;

## `input_binding_get_name(binding)`

_Returns:_ String, the human-readable [name for the binding](Binding-Names)

|Name     |Datatype|Purpose                       |
|---------|--------|------------------------------|
|`binding`|binding |Binding to return the name for|

Returns the [name of the binding](Binding-Names) in a way that is (mostly!) human-readable. This string can be the name of a keyboard key or the name of a gamepad axis, including direction of travel. The intention is for this information to be parsed by your own code and then used to display a string or icon to the player indicating which button/key etc. is associated with which verb. All return values are listed as [Binding Names](Binding-Names).

&nbsp;

## `input_binding_gamepad_set(binding. gamepad)`

_Returns:_ N/A (`undefined`)

|Name     |Datatype                     |Purpose                                          |
|---------|-----------------------------|-------------------------------------------------|
|`binding`|[binding](Verbs-and-Bindings)|[Binding](Verbs-and-Alternate-Bindings) to target|

?> The gamepad index for a binding is only relevant when in the [multidevice source mode](Input-Sources?id=source-modes).

&nbsp;

## `input_binding_gamepad_get(binding)`

_Returns:_ Integer, the gamepad index for the binding

|Name     |Datatype                     |Purpose                                          |
|---------|-----------------------------|-------------------------------------------------|
|`binding`|[binding](Verbs-and-Bindings)|[Binding](Verbs-and-Alternate-Bindings) to target|

If no gamepad has been set, this function returns `undefined`.

?> The gamepad index for a binding is only relevant when in the [multidevice source mode](Input-Sources?id=source-modes).

&nbsp;

## `input_binding_threshold_set(binding, min, max)`

_Returns:_ N/A (`undefined`)

|Name     |Datatype                     |Purpose                                          |
|---------|-----------------------------|-------------------------------------------------|
|`binding`|[binding](Verbs-and-Bindings)|[Binding](Verbs-and-Alternate-Bindings) to target|
|`min`    |number                       |Minimum threshold for this binding               |
|`max`    |number                       |Maximum threshold for this binding               |

Sets the minimum and maximum threshold values for this binding. This is only relevant when applied to a [gamepad axis binding](Functions-(Binding-Creators)?id=input_binding_gamepad_axisaxis-negative).

This function is entirely optional. If a gamepad axis binding has no specific thresholds set then the player's axis thresholds are used, as set by [`input_axis_thresholds_set()`](Functions-(Other)?id=input_axis_threshold_setaxis-min-max-playerindex).

&nbsp;

## `input_binding_threshold_get(binding)`

_Returns:_ A struct with two member variables, `.mini` and `.maxi`, containing the minimum and maximum thresholds

|Name     |Datatype                     |Purpose                                          |
|---------|-----------------------------|-------------------------------------------------|
|`binding`|[binding](Verbs-and-Bindings)|[Binding](Verbs-and-Alternate-Bindings) to target|