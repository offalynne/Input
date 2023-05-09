# Functions (Virtual Buttons)

&nbsp;

The following functions are in global scope and can be called anywhere in your game. Virtual buttons themselves are created with `input_virtual_create()` - which returns a struct - and should be configured by executing methods on that struct. You can find a list of virtual button methods [here](Functions-(Virtual-Button-Methods)).

?> All coordinates and positions are in GUI-space.

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
//TODO lol
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
//TODO lol
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
//TODO lol
```

<!-- tabs:end -->

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
//TODO lol
```

<!-- tabs:end -->