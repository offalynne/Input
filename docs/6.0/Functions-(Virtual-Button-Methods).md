# Functions (Virtual Button Methods)

&nbsp;

Virtual buttons can be configured using the following functions. Many functions return `self` meaning that methods can be chained together as a fluent interface.

?> All coordinates and positions are in GUI-space.

&nbsp;

## .destroy

`<virtual button>.destroy()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Immediately destroys a virtual button, making it inoperative and any methods for the destroyed virtual button will do nothing.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .debug_draw

`<virtual button>.debug_draw()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Draws simple representations of the virtual button to the screen. This is intended for debug use only.

!> This function should be called in a [Draw GUI event](https://manual.yoyogames.com/The_Asset_Editors/Object_Properties/Draw_Events.htm) for accurate results.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .rectangle

`<virtual button>.rectangle(left, top, right, bottom)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name    |Datatype|Purpose                         |
|--------|--------|--------------------------------|
|`left`  |number  |Left position of the rectangle  |
|`top`   |number  |Top position of the rectangle   |
|`right` |number  |Right position of the rectangle |
|`bottom`|number  |Bottom position of the rectangle|

Sets the shape of the virtual button to a rectangle.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .circle

`<virtual button>.circle(x, y, radius)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name    |Datatype|Purpose                                 |
|--------|--------|----------------------------------------|
|`x`     |number  |x-coordinate of the centre of the circle|
|`y`     |number  |y-coordinate of the centre of the circle|
|`radius`|number  |Radius of the circle                    |

Sets the shape of the virtual button to a circle.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_position

`<virtual button>.get_position()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, see below

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

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .button

`<virtual button>.button(clickVerb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name       |Datatype|Purpose                            |
|-----------|--------|-----------------------------------|
|`clickVerb`|string  |Verb to bind clicking the button to|

Binds the virtual button to a basic Input verb. Pressing the button will also "press" the verb.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .dpad

`<virtual button>.dpad(clickVerb, leftVerb, rightVerb, upVerb, downVerb, [4dir])`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

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

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .thumbstick

`<virtual button>.thumbstick(clickVerb, leftVerb, rightVerb, upVerb, downVerb)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name       |Datatype|Purpose                                                                                                    |
|-----------|--------|-----------------------------------------------------------------------------------------------------------|
|`clickVerb`|string  |Verb to bind clicking the button to                                                                        |
|`leftVerb` |string  |Verb to bind touching the left of the button to                                                            |
|`rightVerb`|string  |Verb to bind touching the right of the button to                                                           |
|`upVerb`   |string  |Verb to bind touching the top of the button to                                                             |
|`downVerb` |string  |Verb to bind touching the bottom of the to                                                                 |

Binds the virtual button to a set of basic Input verbs, one for each direction and an extra one for touching the dpad at all. Verbs are triggered as **analogue**, meaning that verbs will be sent values from `0` to `1` as a hardware thumbstick would.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_type

`<virtual button>.get_type()`

<!-- tabs:start -->

#### **Description**

**Returns:** Member of the `INPUT_VIRTUAL_TYPE` enum, what type of virtual button this is

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

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_verbs

`<virtual button>.get_verbs()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the verb bindings for the virtual button

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

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .threshold

`<virtual button>.threshold(min, max)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name |Datatype|Purpose                |
|-----|--------|-----------------------|
|`min`|number  |Minimum threshold value|
|`max`|number  |Maximum threshold value|

?> This method is only relevant for dpad- and thumbstick-type virtual buttons.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_threshold

`<virtual button>.get_threshold()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, containing the minimum and maximum thresholds

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned from this method has the following member variables:

|Name   |Datatype|Purpose                |
|-------|--------|-----------------------|
|`.mini`|number  |Minimum threshold value|
|`.maxi`|number  |Maximum threshold value|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .active

`<virtual button>.active(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose                            |
|-------|--------|-----------------------------------|
|`state`|boolean |Active state for the virtual button|

When a virtual button's active state is set to `false`, it will immediately stop responding to player input, including any current input.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_active

`<virtual button>.get_active()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button is active

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .priority

`<virtual button>.priority(priority)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name      |Datatype|Purpose                                |
|----------|--------|---------------------------------------|
|`priority`|number  |Capture priority for the virtual button|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_priority

`<virtual button>.get_priority()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the priority of the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .follow

`<virtual button>.follow(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose                                                         |
|-------|--------|----------------------------------------------------------------|
|`state`|boolean |Whether the virtual button should move to follow the touch point|

?> As the follow state moves the virtual button around, you may want to call `.release_behaviour(INPUT_VIRTUAL_RELEASE.RESET_POSITION)` to reset the position of the button.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_follow

`<virtual button>.get_follow()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button is following the touch point

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .release_behavior

`<virtual button>.release_behavior(option)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype                    |Purpose|
|-------|----------------------------|-------|
|`state`|`INPUT_VIRTUAL_RELEASE` enum|       |

The `INPUT_VIRTUAL_RELEASE` enum contains the following elements:

|Name             |Purpose                                                                         |
|-----------------|--------------------------------------------------------------------------------|
|`.DO_NOTHING`    |Default setting. Does nothing!                                                  |
|`.DESTROY`       |Destroys the virtual button when released. This is useful for ad hoc thumbsticks|
|`.RESET_POSITION`|Resets the position of the button to where it was created when released         |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_release_behavior

`<virtual button>.get_release_behavior()`

<!-- tabs:start -->

#### **Description**

**Returns:** Member of the `INPUT_VIRTUAL_RELEASE` enum

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .first_touch_only

`<virtual button>.first_touch_only(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose                                                                    |
|-------|--------|---------------------------------------------------------------------------|
|`state`|boolean |Whether the virtual button should only try to capture the first touch point|

On devices that support multiple touch points (typically mobile phones), setting this behaviour to `true` will filter out any touch points after the first one. This is useful for preventing multiple touches on a menu.

On devices that do not support multiple touch points, this function will not change any behaviour.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_first_touch_only

`<virtual button>.get_first_touch_only()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button will only respond to the first touch point

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .pressed

`<virtual button>.pressed()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button was pressed this frame

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .check

`<virtual button>.check()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button has been pressed and held

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .released

`<virtual button>.released()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the virtual button was released this frame

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_x

`<virtual button>.get_x()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the normalized x value for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The number returned from this function will range from `-1` (fully left) to `1` (fully right). This value respects the threshold values set by `.threshold()`.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_y

`<virtual button>.get_y()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the normalized y value for the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The number returned from this function will range from `-1` (fully top) to `1` (fully bottom). This value respects the threshold values set by `.threshold()`.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_touch_x

`<virtual button>.get_touch_x()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the current x-coordinate of the touch point captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_touch_y

`<virtual button>.get_touch_y()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the current y-coordinate of the touch point captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_touch_start_x

`<virtual button>.get_touch_start_x()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the initial x-coordinate of the touch point when captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_touch_start_y

`<virtual button>.get_touch_start_y()`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the initial y-coordinate of the touch point when captured by the virtual button

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .record_history

`<virtual button>.record_history(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** `self`

|Name   |Datatype|Purpose|
|-------|--------|-------|
|`state`|boolean |       |

Starts recording touch point history for the virtual button. This can be used to detect swipe and flick gestures.

?> Input only keeps track of a limited number of frames of data. This is controlled by the `INPUT_TOUCH_HISTORY_FRAMES` config macro.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_history

`<virtual button>.get_history()`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of structs, see below

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Structs in the returned array contain x/y coordinate pairs. These coordinates are the position of the touch point captured by the virtual button, going back into the past. New data is pushed into the array every frame, with index 0 in the array being 1 frame before present, the index 1 being 2 frames before presents, and so on.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_history_direction

`<virtual button>.get_history_direction([frames])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name      |Datatype|Purpose                                                                                        |
|----------|--------|-----------------------------------------------------------------------------------------------|
|`[frames]`|integer |Number of frames in the past to analyze. If not specified, `INPUT_TOUCH_HISTORY_FRAMES` is used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_history_distance

`<virtual button>.get_history_distance([frames])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, how far the touch point moved over

|Name      |Datatype|Purpose                                                                                        |
|----------|--------|-----------------------------------------------------------------------------------------------|
|`[frames]`|integer |Number of frames in the past to analyze. If not specified, `INPUT_TOUCH_HISTORY_FRAMES` is used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## .get_history_speed

`<virtual button>.get_history_speed([frames])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the speed of the touch point's movement

|Name      |Datatype|Purpose                                                                                        |
|----------|--------|-----------------------------------------------------------------------------------------------|
|`[frames]`|integer |Number of frames in the past to analyze. If not specified, `INPUT_TOUCH_HISTORY_FRAMES` is used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->