# Functions (Binding Creators)

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
|`key`|integer |[Key](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/keyboard%20input/index.html) to bind|

&nbsp;

## `input_binding_mouse_button(button)`

*Returns:* Struct, a mouse button binding

|Name    |Datatype|Purpose                                                                                                                                               |
|--------|--------|------------------------------------------------------------------------------------------------------------------------------------------------------|
|`button`|integer |[Mouse button](https://docs.yoyogames.com/source/dadiospice/002_reference/mouse,%20keyboard%20and%20other%20controls/mouse%20input/index.html) to bind|

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
|`button`|integer |[Gamepad button](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) to bind|

&nbsp;

## `input_binding_gamepad_axis(axis, negative)`

*Returns:* Struct, a gamepad axis binding

|Name      |Datatype|Purpose                                                                                                                          |
|----------|--------|---------------------------------------------------------------------------------------------------------------------------------|
|`axis`    |integer |[Gamepad axis](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) to bind|
|`negative`|boolean |Whether the axis expects negative values                                                                                         |

&nbsp;

## `input_binding_scan_tick(source, [playerIndex])`

_Returns:_ Various, see below

|Name            |Datatype                         |Purpose                                                                                                           |
|----------------|---------------------------------|------------------------------------------------------------------------------------------------------------------|
|`[sourceFilter]`|array of [sources](Input-Sources)|[Input sources](Input-Sources) to listen to. If not specified, all of the chosen player's current sources are used|
|`[playerIndex]` |integer                          |Player to target. If not specified, player 0 is targeted                                                          |

This function will scan for input from a player and then return a binding struct that reflects what input was detected. If something unexpected happens (for example, the player's controller is disconnected) then this function will return a negative integer as an error code. If no input is currently detected from the player then this function will return `undefined`.

Because this function can return multiple different datatypes, it's important to carefully test values being returned from this function before passing them into other functions. Here's an example of how to do basic remapping for your game:

```gml
//If we're currently trying to rebind a control
if (rebinding)
{
    //Scan for input from our player
    var _binding = input_binding_scan_tick(INPUT_SOURCE.GAMEPAD);

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

|Name                 |Meaning                                                                                                                                                                                       |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`.SOURCE_INVALID`    |Player's source is invalid, usually because they have no sources assigned or their gamepad has been disconnected                                                                              |
|`.SOURCE_CHANGED`    |The player's source (or sources) have been modified                                                                                                                                           |
|`.PLAYER_IS_GHOST`   |Player is a ghost and cannot receive hardware input                                                                                                                                           |
|`.SCAN_TIMEOUT`      |Either the player didn't enter a new binding or a stuck key prevented the system from working. The timeout period is defined by [`INPUT_BINDING_SCAN_TIMEOUT`](Configuration)                 |
|`.LOST_FOCUS`        |The application lost focus                                                                                                                                                                    |
|`.SUCCESS_THIS_FRAME`|Input scanning has already succeeded this frame - this is a rare error code and should only be returned if `input_binding_scan_tick()` is being called twice in a single frame for some reason|
|`.ERROR_THIS_FRAME`  |Input scanning has already failed this frame - this is a rare error code and should only be returned if `input_binding_scan_tick()` is being called twice in a single frame for some reason   |

&nbsp;

## `input_value_is_binding(value)`

_Returns:_ Boolean, if the value is a valid binding struct

|Name   |Datatype|Purpose       |
|-------|--------|--------------|
|`value`|any     |Value to check|

Useful for verifying if a value returned from [`input_binding_scan_tick()`]() or [`input_binding_get()`]() is a binding.