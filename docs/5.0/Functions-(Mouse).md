# Functions (Mouse)

&nbsp;

?> These functions are provided for convenience if you want to implement your own features using Input's mouse implementation. In general, [Player functions](Functions-(Players)) are the intended way to use Input and are preferred.

&nbsp;

## `input_mouse_check(button)`

*Returns:* Boolean, if the button is currently activated

|Name    |Datatype|Purpose                                               |
|--------|--------|------------------------------------------------------|
|`button`|integer |Button to check, using GameMaker's native [virtual button constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/mouse%20input/index.html)|

&nbsp;

## `input_mouse_check_pressed(button)`

*Returns:* Boolean, if the button is newly activated this frame

|Name    |Datatype|Purpose                                               |
|--------|--------|------------------------------------------------------|
|`button`|integer |Button to check, using GameMaker's native [virtual button constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/mouse%20input/index.html)|

&nbsp;

## `input_mouse_check_released(button)`

*Returns:* Boolean, if the button/axis is newly deactivated this frame

|Name    |Datatype|Purpose                                               |
|--------|--------|------------------------------------------------------|
|`button`|integer |Button to check, using GameMaker's native [virtual button constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/mouse%20input/index.html)|

&nbsp;

## `input_mouse_x()`

*Returns:* Integer, the x-coordinate of the active pointer device

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `input_mouse_y()`

*Returns:* Integer, the y-coordinate of the active pointer device

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `input_mouse_transform_function_set(method)`

*Returns:* N/A (`undefined`)

|Name    |Datatype|Purpose                                             |
|--------|--------|----------------------------------------------------|
|`method`|method  |                                                    |

If `method` is set to `undefined` then the mouse transformation function is disabled and no transformation is applied.

&nbsp;

## `input_mouse_transform_method_get()`

*Returns:* Method, the mouse transformation function as set by `input_mouse_transform_function_set()`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

This function will return `undefined` if no transformation function has been defined.
