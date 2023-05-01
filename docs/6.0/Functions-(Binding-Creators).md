# Functions (Binding Creators)

&nbsp;

Binding are the rules that teach Input how to tie physical button input to in-game verbs. The functions on this page allow you to create bindings, either to define [default profiles](Profiles), [change bindings](Functions-(Binding-Access)), or to build out [custom profiles](Functions-(Profiles)).

&nbsp;

## …value_is_binding

`input_value_is_binding(value)`

<!-- tabs:start -->

#### **Description**

_Returns:_ Boolean, if the value is a valid binding struct

|Name   |Datatype|Purpose       |
|-------|--------|--------------|
|`value`|any     |Value to check|

#### **Example**

```gml
//Show the correct text depending on whether this alternate has a binding already
if (value_is_binding(binding_get(verb_to_change, alternate_to_change)))
{
	draw_text(x, y, "Replace");
}
else
{
	draw_text(x, y, "New");
}
```

<!-- tabs:end -->

&nbsp;

&nbsp;

## …binding_empty

`input_binding_empty()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, an empty (inactive) binding

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Represents a binding that cannot be activated. Empty bindings should be used to represent inactive or inacccessible bindings.

#### **Example**

```gml
//If the player has confirmed they want to clear the binding...
if (input_check_pressed("accept") and (binding_clear == true))
{
	//...then clear the binding by setting it to "empty"
	input_binding_set(verb_to_clear, input_binding_empty());
}
```

<!-- tabs:end -->

&nbsp;

## …binding_key

`input_binding_key(key)`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, a keyboard binding

|Name |Datatype|Purpose                                                                                                                           |
|-----|--------|----------------------------------------------------------------------------------------------------------------------------------|
|`key`|integer |[Key](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to bind|

Represents a binding that is activated by pressing a keyboard key. Keyboard bindings return a digital value internally.

#### **Example**

```gml
/// Default profiles setup, found in __input_config_verbs()

return {

	... //Other bindings
    
    keyboard_and_mouse: {

    	//WASD to move
    	left:  input_binding_key("A"),
    	right: input_binding_key("D"),
    	up:    input_binding_key("W"),
    	down:  input_binding_key("S"),
    }

    ...

}
```

<!-- tabs:end -->

&nbsp;

## …binding_mouse_button

`input_binding_mouse_button(button)`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, a mouse button binding

|Name    |Datatype|Purpose                                                                                                                                        |
|--------|--------|-----------------------------------------------------------------------------------------------------------------------------------------------|
|`button`|integer |[Mouse button](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FMouse_Input%252FMouse_Input.htm) to bind|

Represents a binding that is activated by pressing a mouse button. Mouse button bindings return a digital value internally.

#### **Example**

```gml
/// Default profiles setup, found in __input_config_verbs()

return {

	... //Other bindings
    
    keyboard_and_mouse: {

    	//Click the left mouse button to shoot
    	shoot: input_binding_mouse(mb_left),

    }

    ...

}
```

<!-- tabs:end -->

&nbsp;

## …binding_mouse_wheel_up

`input_binding_mouse_wheel_up()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, a mouse wheel binding

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Represents a binding that is activated by scrolling the mouse wheel up. Mouse wheel bindings return a digital value internally.

#### **Example**

```gml
/// Default profiles setup, found in __input_config_verbs()

return {

	... //Other bindings
    
    keyboard_and_mouse: {

    	//Use either the "up" arrow or the mouse wheel to navigate UI
    	ui_up: [input_binding_keyboard(vk_up), input_binding_mouse_wheel_up()],

    }

    ...

}
```

<!-- tabs:end -->

&nbsp;

## …binding_mouse_wheel_down

`input_binding_mouse_wheel_down()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, a mouse wheel binding

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Represents a binding that is activated by scrolling the mouse wheel down. Mouse wheel bindings return a digital value internally.

#### **Example**

```gml
/// Default profiles setup, found in __input_config_verbs()

return {

	... //Other bindings
    
    keyboard_and_mouse: {

    	//Use either the "down" arrow or the mouse wheel to navigate UI
    	ui_down: [input_binding_keyboard(vk_down), input_binding_mouse_wheel_down()],

    }

    ...

}
```

<!-- tabs:end -->

&nbsp;

## …binding_gamepad_button

`input_binding_gamepad_button(button)`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, a gamepad button binding

|Name    |Datatype|Purpose                                                                                                                                      |
|--------|--------|---------------------------------------------------------------------------------------------------------------------------------------------|
|`button`|integer |[Gamepad button](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to bind|

Represents a binding that is activated by pressing a physical button on a gamepad. Gamepad button bindings return a digital value internally.

?> To port between Xbox/PlayStation and Switch platforms more easily, you may want to use `input_gamepad_swap_ab()` to adjust between different button layout conventions.

#### **Example**

```gml
/// Default profiles setup, found in __input_config_verbs()

return {

	... //Other bindings
    
    gamepad: {

    	//Press A (Xbox), X (PlayStation), or B (Switch) to jump
    	jump: input_binding_gamepad_button(gp_face1),

    }

    ...

}
```

<!-- tabs:end -->

&nbsp;

## …binding_gamepad_axis

`input_binding_gamepad_axis(axis, negative)`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, a gamepad axis binding

|Name      |Datatype|Purpose                                                                                                                                    |
|----------|--------|-------------------------------------------------------------------------------------------------------------------------------------------|
|`axis`    |integer |[Gamepad axis](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to bind|
|`negative`|boolean |Whether the axis expects negative values                                                                                                   |

Represents a binding that is activated by moving a thumbstick or trigger. Axis bindings return an analogue value internally.

#### **Example**

```gml
/// Default profiles setup, found in __input_config_verbs()

return {

	... //Other bindings
    
    gamepad: {

    	left:  input_binding_gamepad_axis(gp_axislh, true),
    	right: input_binding_gamepad_axis(gp_axislh, false),

    }

    ...

}
```

<!-- tabs:end -->

&nbsp;

## …binding_virtual_button

`input_binding_virtual_button()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, a virtual button binding

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Represents a binding that can only be activated by a [virtual button](Functions-(Virtual-Buttons)). This type of binding is only intended for use when setting up default bindings. It is helpful to indicate which verbs are accessible only with virtual buttons, but creating this sort of binding is never required by Input and you can use virtual buttons without ever calling `input_binding_virtual_button()`.

#### **Example**

```gml
/// Default profiles setup, found in __input_config_verbs()

return {

	... //Other bindings
    
    touch: {

    	jump: input_binding_virtual_button(),

    }

    ...

}
```

<!-- tabs:end -->

&nbsp;

## …swap_gamepad_ab

`input_swap_gamepad_ab(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                     |
|-------|--------|----------------------------|
|`state`|boolean |Whether to swap A/B bindings|

Swaps gamepad button bindings that target `gp_face1` and `gp_face2`. This is a convenience function to make adapting default gamepad bindings designed for Xbox work on Switch (and vice versa) when porting your game. This isn't strictly needed, Input will work fine cross-platform, but button layout conventions differ slightly between platforms and it's usually a good idea to respect that.

!> This function fully resets all player profiles and bindings to what's found in [`INPUT_DEFAULT_PROFILES`](Configuration?id=profiles-and-bindings). This function is intended to be called when the game is started before loading any player-defined bindings.

#### **Example**

```gml
if (os_type == os_switch)
{
	//Swap A/B buttons to match the standard hardware
	input_swap_gamepad_ab(true);
}
```

<!-- tabs:end -->