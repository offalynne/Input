### `input_value_is_binding(value)`

*Returns:* Boolean, if the value is a valid binding struct

|Name   |Datatype|Purpose       |
|-------|--------|--------------|
|`value`|N/A     |Value to check|

Useful for verifying if a value returned from [`input_binding_scan_tick()`](Functions-(Binding-Management)#input_binding_scan_ticksource-playerindex) is a valid binding.

&nbsp;

&nbsp;

### `input_binding_scan_tick([source], [playerIndex])`

*Returns:* Various, see below

|Name           |Datatype       |Purpose                                                                                                                  |
|---------------|---------------|-------------------------------------------------------------------------------------------------------------------------|
|`[source]`     |[`INPUT_SOURCE`](Input-Sources)|[Input source](Input-Sources) to listen to. If not specified, the player's current source is used instead|
|`[playerIndex]`|integer        |Player to target. If not specified, player 0 is targeted                                                                 |

This function will scan for input from a player and then return a binding struct that reflects what input was detected. If something unexpected happens (for example, the player's controller is disconnected) then this function will return a negative integer as an error code. If no input is currently detected from the player then this function will return `undefined`.

Because this function can return multiple different datatypes, it's important to carefully test values being returned from this function before passing them into other functions. Here's an example of how to do basic remapping for your game:

```GML
//If we're currently trying to rebind a control
if (rebinding)
{
    //Scan for input from our player
    var _binding = input_binding_scan_tick();
    
    //If we have some sort of result - error or success - then proceed
    if (_binding != undefined)
    {
        if (input_value_is_binding(_binding)
        {
            //If we got a valid binding then do some rebinding...
            input_binding_set_safe(verb_to_rebind, _binding);
        }
        else
        {
            //...otherwise spit out an error into the debug log
            show_debug_message("Error during rebinding! (" + string(_binding) + ")");
        }
		
        //Whatever the weather, stop rebinding
        rebinding = false;
    }
}
```

Error codes that this function can return are as follows. These are all elements of the `INPUT_BINDING_SCAN_EVENT` enum:

|Name                 |Meaning                                                                                                                                                                                          |
|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`.SOURCE_INVALID`    |Player's source is invalid, usually because their controller was disconnected before scanning started                                                                                            |
|`.SOURCE_CHANGED`    |Player's source changed, usually because they hotswapped to another source                                                                                                                       |
|`.GAMEPAD_CHANGED`   |Player's gamepad changed                                                                                                                                                                         |
|`.GAMEPAD_INVALID`   |Player's gamepad is invalid, usually because their controller was disconnected during scanning                                                                                                   |
|`.BINDING_DOESNT_MATCH_SOURCE`|Player pressed a key/button (etc.) on a source that is different to the target source                                                                                                   |
|`.TIMEOUT`           |Either the player didn't enter a new binding or a stuck key prevented the system from working. The timeout period is defined by [`INPUT_BINDING_SCAN_TIMEOUT`](Functions-(System)#__input_config)|
|`.SUCCESS_THIS_FRAME`|Input scanning has already succeeded this frame - this is a rare error code and should only be returned if `input_binding_scan_tick()` is being called twice in a single frame for some reason   |
|`.ERROR_THIS_FRAME`  |Input scanning has already failed this frame - this is a rare error code and should only be returned if `input_binding_scan_tick()` is being called twice in a single frame for some reason      |

&nbsp;

&nbsp;

### `input_binding_set(verb, binding, [playerIndex], [alternate])`

*Returns:* N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                                                                                                                                                                             |
|---------------|------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target                                                                                                                                                                                                      |
|`binding`      |binding                             |Binding to set, as returned by [`input_binding_scan_tick()`](Functions-(Binding-Management)#input_binding_scan_ticksource-playerindex) or [`input_binding_get()`](Functions-(Binding-Management)#input_binding_getverb-source-playerindex-alternate)|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                                                                                                                                                                                |
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Alternate-Bindings) to target. If not specified, `0` is used                                                                                                                                                          |

Straightforwardly sets the binding for a verb, overwriting what was already there.

&nbsp;

&nbsp;

### `input_binding_set_safe(verb, binding, [playerIndex], [alternate])`

*Returns:* N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                                                                                                                                                                             |
|---------------|------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target                                                                                                                                                                                                      |
|`binding`      |binding                             |Binding to set, as returned by [`input_binding_scan_tick()`](Functions-(Binding-Management)#input_binding_scan_ticksource-playerindex) or [`input_binding_get()`](Functions-(Binding-Management)#input_binding_getverb-source-playerindex-alternate)|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                                                                                                                                                                                |
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Alternate-Bindings) to target. If not specified, `0` is used                                                                                                                                                          |

In contrast to [`input_binding_set()`](Functions-(Binding-Management)#input_binding_setverb-binding-playerindex-alternate), this function will set the binding for a verb but also try to automatically handle any input conflicts by swapping over bindings. This is effective for simple control schemes but may fail in more complex situations - in these cases, you'll need to handle conflict resolution yourself.

&nbsp;

&nbsp;

### `input_binding_get(verb, [source], [playerIndex], [alternate])`

*Returns:* Struct. See below.

|Name           |Datatype                            |Purpose                                                                                            |
|---------------|------------------------------------|---------------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target                                                     |
|`[source]`     |[`INPUT_SOURCE`](Input-Sources)     |[Input source](Input-Sources) to target. If not specified, the player's current source will be used|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                               |
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Alternate-Bindings) to target. If not specified, `0` is used         |

This function returns a struct that describes the binding for the given verb. It has the following member variables:

|Variable       |Datatype|Purpose                    |
|---------------|--------|---------------------------|
|`type`         |string  |Type of binding, one of the following:<br>`"key"` `"gamepad button"` `"gamepad axis"` `"mouse button"` `"mouse wheel up"` `"mouse wheel down"`|
|`value`        |integer |[Keycode](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/keyboard%20input/index.html), [gamepad button](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html), [gamepad axis](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html), or [mouse button](https://docs.yoyogames.com/source/dadiospice/002_reference/mouse,%20keyboard%20and%20other%20controls/mouse%20input/index.html) that this binding uses. This variable is `undefined` for `"mouse wheel up"` and `"mouse wheel down"` types|
|`axis_negative`|boolean |Whether this binding expects negative values (`"gamepad axis"` type only)|

&nbsp;

&nbsp;

### `input_binding_get_collisions(binding, [playerIndex])`

*Returns:* Array of structs containing conflicting verb/alternate indexes

|Name           |Datatype|Purpose                                                                                                                                                                                                                                                       |
|---------------|--------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`binding`      |binding |Binding to check against, as returned by [`input_binding_scan_tick()`](Functions-(Binding-Management)#input_binding_scan_ticksource-playerindex) or [`input_binding_get()`](Functions-(Binding-Management)#input_binding_getverb-source-playerindex-alternate)|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                                                                                                                                                                                          |

The array that this function returns contains structs that define which verb bindings conflict with the given binding. If the array is empty then there are no conflicting bindings.

The structs returned in the array contain the following:

|Variable   |Datatype                            |Purpose                     |
|-----------|------------------------------------|----------------------------|
|`verb`     |[verb](Verbs-and-Alternate-Bindings)|Verb binding that conflicts |
|`alternate`|integer                             |Alternate index for the verb|

&nbsp;

&nbsp;

### `input_binding_remove(verb, source, [playerIndex], [alternate])`

*Returns:* N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                   |
|---------------|------------------------------------|------------------------------------------------------------------------------------------|
|`verb`         |[verb](Verbs-and-Alternate-Bindings)|[Verb](Verbs-and-Alternate-Bindings) to target                                            |
|`source`       |[`INPUT_SOURCE`](Input-Sources)     |[Input source](Input-Sources) to target                                                   |
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                      |
|`[alternate]`  |integer                             |[Alternate binding](Verbs-and-Alternate-Bindings) to target. If not specified, `0` is used|

Removes a binding from Input. **Be very careful with this function!** It's possible to remove any binding and this could potentially make your game unplayable.

&nbsp;

&nbsp;

### `input_binding_swap(verbA, alternateA, verbB, alternateB, [source], [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype                            |Purpose                                                                                            |
|---------------|------------------------------------|---------------------------------------------------------------------------------------------------|
|`verbA`        |[verb](Verbs-and-Alternate-Bindings)|First [verb](Verbs-and-Alternate-Bindings) to target                                               |
|`alternateA`   |integer                             |[Alternate binding](Verbs-and-Alternate-Bindings) to target for the first verb                     |
|`verbB`        |[verb](Verbs-and-Alternate-Bindings)|Second [verb](Verbs-and-Alternate-Bindings) to target                                              |
|`alternateB`   |integer                             |[Alternate binding](Verbs-and-Alternate-Bindings) to target for the second verb                    |
|`[source]`     |[`INPUT_SOURCE`](Input-Sources)     |[Input source](Input-Sources) to target. If not specified, the player's current source will be used|
|`[playerIndex]`|integer                             |Player to target. If not specified, player 0 is used                                               |

Swaps over the two verb bindings specified.

&nbsp;

&nbsp;

### `input_binding_get_name(binding)`

*Returns:* String, the human-readable [name for the binding](Binding-Names)

|Name     |Datatype|Purpose                       |
|---------|--------|------------------------------|
|`binding`|binding |Binding to return the name for|

Returns the [name of the binding](Binding-Names) in a way that is (mostly!) human-readable. This string can be the name of a keyboard key or the name of a gamepad axis, including direction of travel. The intention is for this information to be parsed by your own code and then used to display a string or icon to the player indicating which button/key etc. is associated with which verb. All return values are listed as [Binding Names](Binding-Names).

&nbsp;

&nbsp;