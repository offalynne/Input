# Functions (Binding Creators)

&nbsp;

### `input_binding_key(key)`

*Returns:* Struct, a keyboard binding

|Name |Datatype|Purpose                                                                                                                  |
|-----|--------|-------------------------------------------------------------------------------------------------------------------------|
|`key`|integer |[Key](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/keyboard%20input/index.html) to bind|

&nbsp;

### `input_binding_mouse_button(button)`

*Returns:* Struct, a mouse button binding

|Name    |Datatype|Purpose                                                                                                                                               |
|--------|--------|------------------------------------------------------------------------------------------------------------------------------------------------------|
|`button`|integer |[Mouse button](https://docs.yoyogames.com/source/dadiospice/002_reference/mouse,%20keyboard%20and%20other%20controls/mouse%20input/index.html) to bind|

&nbsp;

### `input_binding_mouse_wheel_up()`

*Returns:* Struct, a mouse wheel binding

|Name|Datatype      |Purpose       |
|----|--------------|--------------|
|None|              |              |

&nbsp;

### `input_binding_mouse_wheel_down()`

*Returns:* Struct, a mouse wheel binding

|Name|Datatype      |Purpose       |
|----|--------------|--------------|
|None|              |              |

&nbsp;

### `input_binding_gamepad_button(button)`

*Returns:* Struct, a gamepad button binding

|Name    |Datatype|Purpose                                                                                                                            |
|--------|--------|-----------------------------------------------------------------------------------------------------------------------------------|
|`button`|integer |[Gamepad button](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) to bind|

&nbsp;

### `input_binding_gamepad_axis(axis, negative)`

*Returns:* Struct, a gamepad axis binding

|Name      |Datatype|Purpose                                                                                                                          |
|----------|--------|---------------------------------------------------------------------------------------------------------------------------------|
|`axis`    |integer |[Gamepad axis](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html) to bind|
|`negative`|boolean |Whether the axis expects negative values                                                                                         |

&nbsp;

### `input_binding_gamepad_swap_ab(state)`

*Returns:* N/A (`undefined`)

|Name   |Datatype|Purpose                                   |
|-------|--------|------------------------------------------|
|`state`|boolean |Whether to automatically swap A/B bindings|

Swapping A/O with B/X is a global setting and, once set, cannot be changed during game operation. As a result, this function should be called once at the start of the game before [`input_default_gamepad_button()`](Functions-(Default-Bindings)#input_default_gamepad_buttonbutton-verb-alternate) and [`input_default_joycon_button()`](Functions-(Default-Bindings)#input_default_joycon_buttonbutton-verb-alternate).

If you *would* like to swap A/O with B/X during gameplay, please use the [binding functions](Functions-(Bindings)).