# Functions (Virtual Buttons)

&nbsp;

The following functions are in global scope and can be called anywhere in your game. Virtual buttons themselves are created with `input_virtual_create()` - which returns a struct - and should be configured by executing methods on that struct. You can find a list of virtual button methods [here](Functions-(Virtual-Button-Methods)).

?> All coordinates and positions are in GUI-space.

&nbsp;

## …virtual_create

`input_virtual_create()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, an instance of `__input_class_virtual_button`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

This function creates a blank, unconfigured, virtual button. Please scroll down to see methods that are available for virtual buttons.

#### **Example**

```gml
//Create a rectangular button and bind it to the "accept" verb
vbutton_accept = input_virtual_create()
                 .rectangle(10, 210, 160, 360)
                 .button("accept");

//Create a circular button and bind it to movement verbs as a virtual "thumbstick"
vbutton_thumbstick = input_virtual_create()
                     .circle(500, 300, 120)
                     .thumbstick(undefined, "left", "right", "up", "down");
```

<!-- tabs:end -->

&nbsp;

## …virtual_destroy_all

`input_virtual_destroy_all()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Destroys all virtual buttons that have been created. This is useful when transitioning between different phases of a game, for example, between menus and gameplay.

#### **Example**

```gml
//Remove all virtual buttons if we're using a gamepad
if (input_source_using(INPUT_GAMEPAD))
{
	input_virtual_destroy_all();
}
```

<!-- tabs:end -->

&nbsp;

## …is_virtual

`input_is_virtual()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the value provided is a virtual button

|Name   |Datatype|Purpose           |
|-------|--------|------------------|
|`value`|any     |The value to check|

This function will return `false` for a virtual button that has been destroyed.

#### **Example**

```gml
//If the thumbstick is a valid thumbstick, draw the virtual button
if (input_is_virtual(vbutton_thumbstick))
{
	draw_sprite(spr_thumbstick_vbutton, 0, x, y);
}
```

<!-- tabs:end -->

&nbsp;

## …virtual_debug_draw

`input_virtual_debug_draw()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

Draws simple representations of every virtual button to the screen. This is intended for debug use only.

!> This function should be called in a [Draw GUI event](https://manual.yoyogames.com/The_Asset_Editors/Object_Properties/Draw_Events.htm) for accurate results.

#### **Example**

```gml
//Draw virtual buttons to the screen when we're in debug mode
if (debug_mode)
{
	input_virtual_debug_draw();
}
```

<!-- tabs:end -->