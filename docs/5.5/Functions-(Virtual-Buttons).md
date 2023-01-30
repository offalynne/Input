# Functions (Virtual Buttons)

&nbsp;

The following functions are in global scope and can be called anywhere in your game. Virtual buttons themselves are created with `input_virtual_create()` - which returns a struct - and should be configured by executing methods on that struct.

?> All coordinates and positions are in GUI-space.

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

Immediately destroys a virtual button, making it inoperative and any methods for the destroyed virtual button will do nothing.

&nbsp;

## `.debug_draw()`

*Returns:* N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Draws simple representations of the virtual button to the screen. This is intended for debug use only.

!> This function should be called in a [Draw GUI event](https://manual.yoyogames.com/The_Asset_Editors/Object_Properties/Draw_Events.htm) for accurate results.

&nbsp;

## `.rectangle(left, top, right, bottom)`

*Returns:* `self`

|Name    |Datatype|Purpose                         |
|--------|--------|--------------------------------|
|`left`  |number  |Left position of the rectangle  |
|`top`   |number  |Top position of the rectangle   |
|`right` |number  |Right position of the rectangle |
|`bottom`|number  |Bottom position of the rectangle|

Sets the shape of the virtual button to a rectangle.

&nbsp;

## `.circle(x, y, radius)`

*Returns:* `self`

|Name    |Datatype|Purpose                                 |
|--------|--------|----------------------------------------|
|`x`     |number  |x-coordinate of the centre of the circle|
|`y`     |number  |y-coordinate of the centre of the circle|
|`radius`|number  |Radius of the circle                    |

Sets the shape of the virtual button to a circle.

&nbsp;

## `.get_position()`

*Returns:* Struct, see below

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned from this method has the following member variables:

|Name     |Datatype|Purpose                                                                |
|---------|--------|-----------------------------------------------------------------------|
|`.left`  |number  |Left position of the bounding box                                      |
|`.top`   |number  |Top position of the bounding box                                       |
|`.right` |number  |Right position of the bounding box                                     |
|`.bottom`|number  |Bottom position of the bounding box                                    |
|`.width` |number  |Width of the bounding box                                              |
|`.height`|number  |Height of the bounding box                                             |
|`.x`     |number  |x-coordinate of the centre of the button                               |
|`.y`     |number  |y-coordinate of the centre of the button                               |
|`.radius`|number  |Radius of the circle. This value is `undefined` for rectangular buttons|

&nbsp;

## `.button(clickVerb)`

*Returns:* `self`

|Name       |Datatype|Purpose                            |
|-----------|--------|-----------------------------------|
|`clickVerb`|string  |Verb to bind clicking the button to|

Binds the virtual button to a basic Input verb. Pressing the button will also "press" the verb.

&nbsp;

## `.dpad(clickVerb, leftVerb, rightVerb, upVerb, downVerb, [4dir])`

*Returns:* `self`

|Name       |Datatype|Purpose                                                                                                    |
|-----------|--------|-----------------------------------------------------------------------------------------------------------|
|`clickVerb`|string  |Verb to bind clicking the button to                                                                        |
|`leftVerb` |string  |Verb to bind touching the left of the button to                                                            |
|`rightVerb`|string  |Verb to bind touching the right of the button to                                                           |
|`upVerb`   |string  |Verb to bind touching the top of the button to                                                             |
|`downVerb` |string  |Verb to bind touching the bottom of the to                                                                 |
|`[4dir]`   |boolean |Whether the dpad should be limited to 4 directions only. Defaults to `false`, allowing 8-directional output|

Binds the virtual button to a set of basic Input verbs, one for each direction and an extra one for touching the dpad at all. Verbs are triggered as **digital**, meaning that verbs are either on or off without values in between.

By default, a dpad-type virtual button can trigger one or two verbs at once (left, right+up etc.) allowing for 8-directional output. Set `4dir` to `false` to restrict output to 4 directions only.

&nbsp;

## `.thumbstick(clickVerb, leftVerb, rightVerb, upVerb, downVerb)`

*Returns:* `self`

|Name       |Datatype|Purpose                                                                                                    |
|-----------|--------|-----------------------------------------------------------------------------------------------------------|
|`clickVerb`|string  |Verb to bind clicking the button to                                                                        |
|`leftVerb` |string  |Verb to bind touching the left of the button to                                                            |
|`rightVerb`|string  |Verb to bind touching the right of the button to                                                           |
|`upVerb`   |string  |Verb to bind touching the top of the button to                                                             |
|`downVerb` |string  |Verb to bind touching the bottom of the to                                                                 |

Binds the virtual button to a set of basic Input verbs, one for each direction and an extra one for touching the dpad at all. Verbs are triggered as **analogue**, meaning that verbs will be sent values from `0` to `1` as a hardware thumbstick would.

&nbsp;

## `.get_type()`

*Returns:* Member of the `INPUT_VIRTUAL_TYPE` enum, what type of virtual button this is

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The `INPUT_VIRTUAL_TYPE` enum contains the following elements:

|Name         |Purpose                                                                         |
|-------------|--------------------------------------------------------------------------------|
|`.BUTTON`    |Virtual button bindings set by `.button()`                                      |
|`.DPAD_8DIR` |Virtual button bindings set by `.dpad()` with the `4dir` argument set to `false`|
|`.DPAD_4DIR` |Virtual button bindings set by `.dpad()` with the `4dir` argument set to `true` |
|`.THUMBSTICK`|Virtual button bindings set by `.thumbstick()`                                  |

&nbsp;

## `.get_verbs()`

*Returns:* Struct, the verb bindings for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned from this method has the following member variables:

|Name    |Datatype|Purpose                                                    |
|--------|--------|-----------------------------------------------------------|
|`.click`|string  |Verb bound to touching the virtual button at all           |
|`.left` |string  |Verb bound to touching the virtual button on the left side |
|`.right`|string  |Verb bound to touching the virtual button on the right side|
|`.up`   |string  |Verb bound to touching the virtual button on the up side   |
|`.down` |string  |Verb bound to touching the virtual button on the down side |

&nbsp;

## `.threshold(min, max)`

*Returns:* `self`

|Name |Datatype|Purpose                |
|-----|--------|-----------------------|
|`min`|number  |Minimum threshold value|
|`max`|number  |Maximum threshold value|

?> This method is only relevant for dpad- and thumbstick-type virtual buttons.

&nbsp;

## `.get_threshold()`

*Returns:* Struct, containing the minimum and maximum thresholds

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned from this method has the following member variables:

|Name   |Datatype|Purpose                |
|-------|--------|-----------------------|
|`.mini`|number  |Minimum threshold value|
|`.maxi`|number  |Maximum threshold value|

&nbsp;

## `.active(state)`

*Returns:* `self`

|Name   |Datatype|Purpose                            |
|-------|--------|-----------------------------------|
|`state`|boolean |Active state for the virtual button|

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

|Name      |Datatype|Purpose                                |
|----------|--------|---------------------------------------|
|`priority`|number  |Capture priority for the virtual button|

&nbsp;

## `.get_priority()`

*Returns:* Number, the priority of the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.follow(state)`

*Returns:* `self`

|Name   |Datatype|Purpose                                                         |
|-------|--------|----------------------------------------------------------------|
|`state`|boolean |Whether the virtual button should move to follow the touch point|

?> As the follow state moves the virtual button around, you may want to call `.release_behaviour(INPUT_VIRTUAL_RELEASE.RESET_POSITION)` to reset the position of the button. 

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

|Name             |Purpose                                                                         |
|-----------------|--------------------------------------------------------------------------------|
|`.DO_NOTHING`    |Default setting. Does nothing!                                                  |
|`.DESTROY`       |Destroys the virtual button when released. This is useful for ad hoc thumbsticks|
|`.RESET_POSITION`|Resets the position of the button to where it was created when released         |

&nbsp;

## `.get_release_behaviour()`

*Returns:* Member of the `INPUT_VIRTUAL_RELEASE` enum

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `.first_touch_only(state)`

*Returns:* `self`

|Name   |Datatype|Purpose                                                                    |
|-------|--------|---------------------------------------------------------------------------|
|`state`|boolean |Whether the virtual button should only try to capture the first touch point|

Setting this behaviour to `true` will filter out any presses after the first press. This is useful for preventing multiple touches on a menu.

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