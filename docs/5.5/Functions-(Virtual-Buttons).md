# Functions (Virtual Buttons)

&nbsp;

The following functions are in global scope and can be called anywhere in your game. Virtual buttons themselves are created with `input_virtual_create()` - which returns a struct - and should be configured by executing methods on that struct.

&nbsp;

## `input_virtual_destroy_all()`

*Returns:* N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Destroys all virtual buttons that have been created. This is useful when transitioning between different phases of a game, for example, between menus and gameplay.

&nbsp;

## `input_is_virtual()`

*Returns:* Boolean, whether the value provided is a virtual button

|Name   |Datatype|Purpose           |
|-------|--------|------------------|
|`value`|any     |The value to check|

This function will return `false` for a virtual button that has been destroyed.

&nbsp;

## `input_virtual_debug_draw()`

*Returns:* N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Draws simple representations of every virtual button to the screen. This is intended for debug use only.

!> This function should be called in a [Draw GUI event](https://manual.yoyogames.com/The_Asset_Editors/Object_Properties/Draw_Events.htm) for accurate results.

&nbsp;

## `input_virtual_create()`

*Returns:* Struct, an instance of `__input_class_virtual_button`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

This function creates a blank, unconfigured, virtual button. Please scroll down to see methods that are available for virtual buttons.

&nbsp;

# Virtual Button Methods

&nbsp;

Virtual buttons can be configured using the following functions. Many functions return `self` meaning that methods can be chained together as a fluent interface.

?> All coordinates and positions are in GUI-space.

&nbsp;

## `.destroy()`

*Returns:* N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.debug_draw()`

*Returns:* N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.rectangle(left, top, right, bottom)`

*Returns:* `self`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.circle(x, y, radius)`

*Returns:* `self`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.get_position()`

*Returns:* Struct, see below

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.button(clickVerb)`

*Returns:* `self`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.dpad(clickVerb, leftVerb, rightVerb, upVerb, downVerb, [4dir=false])`

*Returns:* `self`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.thumbstick(clickVerb, leftVerb, rightVerb, upVerb, downVerb)`

*Returns:* `self`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.get_type()`

*Returns:* Member of the `INPUT_VIRTUAL_TYPE` enum, see below

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The `INPUT_VIRTUAL_TYPE` enum contains the following elements:

|Name         |Method         |Purpose|
|-------------|---------------|-------|
|`.BUTTON`    |`.button()`    |       |
|`.DPAD_8DIR` |`.dpad()`      |       |
|`.DPAD_4DIR` |`.dpad()`      |       |
|`.THUMBSTICK`|`.thumbstick()`|       |

&nbsp;

## `.get_verbs()`

*Returns:* Struct, the verb bindings for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned from this method has the following member variables:

|Name    |Datatype|Purpose|
|--------|--------|-------|
|`.click`|string  |       |
|`.left` |string  |       |
|`.right`|string  |       |
|`.up`   |string  |       |
|`.dwon` |string  |       |

&nbsp;

## `.threshold(min, max)`

*Returns:* `self`

|Name |Datatype|Purpose|
|-----|--------|-------|
|`min`|number  |       |
|`max`|number  |       |

?> This method is only relevant for dpad- and thumbstick-type virtual buttons.

&nbsp;

## `.get_threshold()`

*Returns:* Struct, containing the minimum and maximum thresholds

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned from this method has the following member variables:

|Name   |Datatype|Purpose|
|-------|--------|-------|
|`.mini`|number  |       |
|`.maxi`|number  |       |

&nbsp;

## `.active(state)`

*Returns:* `self`

|Name   |Datatype|Purpose|
|-------|--------|-------|
|`state`|boolean |       |

When a virtual button's active state is set to `false`, it will immediately stop responding to player input, including any current input.

&nbsp;

## `.get_active()`

*Returns:* Boolean, whether the virtual button is active

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.priority(priority)`

*Returns:* `self`

|Name      |Datatype|Purpose|
|----------|--------|-------|
|`priority`|number  |       |

&nbsp;

## `.get_priority()`

*Returns:* Number, the priority of the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.follow(state)`

*Returns:* `self`

|Name   |Datatype|Purpose|
|-------|--------|-------|
|`state`|boolean |       |

&nbsp;

## `.get_follow()`

*Returns:* Boolean, whether the virtual button is following the touch point

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.release_behaviour(option)`

*Returns:* `self`

|Name   |Datatype                    |Purpose|
|-------|----------------------------|-------|
|`state`|`INPUT_VIRTUAL_RELEASE` enum|       |

The `INPUT_VIRTUAL_RELEASE` enum contains the following elements:

|Name         |Method         |Purpose|
|-------------|---------------|-------|
|`.BUTTON`    |`.button()`    |       |
|`.DPAD_8DIR` |`.dpad()`      |       |
|`.DPAD_4DIR` |`.dpad()`      |       |
|`.THUMBSTICK`|`.thumbstick()`|       |

&nbsp;

## `.get_release_behaviour()`

*Returns:* Member of the `INPUT_VIRTUAL_RELEASE` enum

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.first_touch_only(state)`

*Returns:* `self`

|Name   |Datatype|Purpose|
|-------|--------|-------|
|`state`|boolean |       |

&nbsp;

## `.get_first_touch_only()`

*Returns:* Boolean, whether the virtual button will only respond to the first touch

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.pressed()`

*Returns:* Boolean, whether the virtual button was pressed this frame

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.check()`

*Returns:* Boolean, whether the virtual button has been pressed and held

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.released()`

*Returns:* Boolean, whether the virtual button was released this frame

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.get_x()`

*Returns:* Number, the normalized x value for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The number returned from this function will range from `-1` (fully left) to `1` (fully right). This value respects the threshold values set by `.threshold()`.

&nbsp;

## `.get_y()`

*Returns:* Number, the normalized y value for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The number returned from this function will range from `-1` (fully top) to `1` (fully bottom). This value respects the threshold values set by `.threshold()`.

&nbsp;

## `.get_touch_x()`

*Returns:* Number, the current x-coordinate of the touch point captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.get_touch_y()`

*Returns:* Number, the current y-coordinate of the touch point captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.get_touch_start_x()`

*Returns:* Number, the initial x-coordinate of the touch point when captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.get_touch_start_y()`

*Returns:* Number, the initial y-coordinate of the touch point when captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.record_history(state)`

*Returns:* `self`

|Name   |Datatype|Purpose|
|-------|--------|-------|
|`state`|boolean |       |

Starts recording touch point history for the virtual button. This can be used to detect swipe and flick gestures.

?> Input only keeps track of a limited number of frames of data. This is controlled by the `INPUT_TOUCH_HISTORY_FRAMES` config macro.

&nbsp;

## `.get_history()`

*Returns:* Array of structs, see below

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Structs in the returned array contain x/y coordinate pairs. These coordinates are the position of the touch point captured by the virtual button, going back into the past. New data is pushed into the array every frame, with index 0 in the array being 1 frame before present, the index 1 being 2 frames before presents, and so on.

&nbsp;

## `.get_history_direction([frames])`

*Returns:* N/A (`undefined`)

|Name      |Datatype|Purpose                                                                                        |
|----------|--------|-----------------------------------------------------------------------------------------------|
|`[frames]`|integer |Number of frames in the past to analyze. If not specified, `INPUT_TOUCH_HISTORY_FRAMES` is used|

`frames`

&nbsp;

## `.get_history_distance([frames])`

*Returns:* Number, how far the touch point moved over

|Name      |Datatype|Purpose                                                                                        |
|----------|--------|-----------------------------------------------------------------------------------------------|
|`[frames]`|integer |Number of frames in the past to analyze. If not specified, `INPUT_TOUCH_HISTORY_FRAMES` is used|

&nbsp;

## `.get_history_speed([frames])`

*Returns:* Number, the speed of the touch point's movement

|Name      |Datatype|Purpose                                                                                        |
|----------|--------|-----------------------------------------------------------------------------------------------|
|`[frames]`|integer |Number of frames in the past to analyze. If not specified, `INPUT_TOUCH_HISTORY_FRAMES` is used|