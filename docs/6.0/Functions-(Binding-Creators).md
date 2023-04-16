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

Useful for verifying if a value returned from [`input_binding_scan_tick()`]() or [`input_binding_get()`]() is a binding.

#### **Example**

```gml
//TODO lol
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

#### **Example**

```gml
//TODO lol
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

#### **Example**

```gml
//TODO lol
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

#### **Example**

```gml
//TODO lol
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

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …binding_mouse_wheel_dow

`input_binding_mouse_wheel_down()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, a mouse wheel binding

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
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

#### **Example**

```gml
//TODO lol
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

#### **Example**

```gml
//TODO lol
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

#### **Example**

```gml
//TODO lol
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

!> This function fully resets all player profiles and bindings to what's found in [`INPUT_DEFAULT_PROFILES`](Configuration?id=profiles-and-bindings). This function is intended to be called when the game is started before loading any player-defined bindings.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->