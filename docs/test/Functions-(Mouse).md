# Mouse (Direct)

&nbsp;

## …mouse_capture_set

`input_mouse_capture_set(state, [sensitivity])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                                                                                                    |
|---------------|--------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`state`        |boolean |Whether to capture the mouse in the game window                                                                                                                            |
|`[sensitivity]`|number  |The relative movement speed for Input's built-in mouse tracking. Higher values increase speed, lower values decrease speed. If not specified, the sensitivity is set to `1`|

?> This function will not hide (or unhide) the OS mouse cursor. Please use GameMaker's native [`window_set_cursor()`](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Cameras_And_Display/The_Game_Window/window_set_cursor.htm).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …mouse_capture_get

`input_mouse_capture_get()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the mouse capture state. See below

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned by the function contains the following member variables:

|Name          |Datatype|Purpose                                   |
|--------------|--------|------------------------------------------|
|`.capture`    |boolean |Whether the mouse is being captured or not|
|`.sensitivity`|number  |The sensitivity for mouse movement        |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …mouse_x

`input_mouse_x([coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the x-coordinate of the active pointer device

|Name          |Datatype                |Purpose                                                                                                     |
|--------------|------------------------|------------------------------------------------------------------------------------------------------------|
|`[coordSpace]`|`INPUT_COORD_SPACE` enum|The coordinate space to use. If not specified, the value set by `input_mouse_coord_space_set()` will be used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …mouse_y

`input_mouse_y([coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the y-coordinate of the active pointer device

|Name          |Datatype                |Purpose                                                                                                     |
|--------------|------------------------|------------------------------------------------------------------------------------------------------------|
|`[coordSpace]`|`INPUT_COORD_SPACE` enum|The coordinate space to use. If not specified, the value set by `input_mouse_coord_space_set()` will be used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …mouse_dx

`input_mouse_dx([coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, how far the mouse has moved in the x-axis between frames

|Name          |Datatype                |Purpose                                                                                                     |
|--------------|------------------------|------------------------------------------------------------------------------------------------------------|
|`[coordSpace]`|`INPUT_COORD_SPACE` enum|The coordinate space to use. If not specified, the value set by `input_mouse_coord_space_set()` will be used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …mouse_dy

`input_mouse_dy([coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, how far the mouse has moved in the y-axis between frames

|Name          |Datatype                |Purpose                                                                                                     |
|--------------|------------------------|------------------------------------------------------------------------------------------------------------|
|`[coordSpace]`|`INPUT_COORD_SPACE` enum|The coordinate space to use. If not specified, the value set by `input_mouse_coord_space_set()` will be used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …mouse_moved

`input_mouse_moved()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the mouse has moved

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …mouse_coord_space_set

`input_mouse_coord_space_set(coordSpace)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name        |Datatype                |Purpose                                                  |
|------------|------------------------|---------------------------------------------------------|
|`coordSpace`|`INPUT_COORD_SPACE` enum|The coordinate space the mouse will operate in. See below|

`INPUT_COORD_SPACE` contains the following members:

|Name     |Purpose                                                                                   |
|---------|------------------------------------------------------------------------------------------|
|`.ROOM`  |Room coordinates; should be the same as `mouse_x` and `mouse_y`. This is the default value|
|`.GUI`   |GUI coordinates                                                                           |
|`.DEVICE`|Raw device-space coordinates                                                              |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …mouse_coord_space_get

`input_mouse_coord_space_get()`

<!-- tabs:start -->

#### **Description**

**Returns:** A member of `INPUT_COORD_SPACE`, the mouse coordinate space that has been set

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

?> The following functions are provided for convenience if you want to implement your own features using Input's mouse implementation. In general, [verbs](Verbs-and-Bindings) are the intended way to use Input and are preferred.

&nbsp;

## …mouse_check

`input_mouse_check(button)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the button is currently activated

|Name    |Datatype|Purpose                                               |
|--------|--------|------------------------------------------------------|
|`button`|integer |Button to check, using GameMaker's native [virtual button constants](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FMouse_Input%252FMouse_Input.htm)|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …mouse_check_pressed

`input_mouse_check_pressed(button)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the button is newly activated this frame

|Name    |Datatype|Purpose                                               |
|--------|--------|------------------------------------------------------|
|`button`|integer |Button to check, using GameMaker's native [virtual button constants](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FMouse_Input%252FMouse_Input.htm)|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …mouse_check_released

`input_mouse_check_released(button)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the button/axis is newly deactivated this frame

|Name    |Datatype|Purpose                                               |
|--------|--------|------------------------------------------------------|
|`button`|integer |Button to check, using GameMaker's native [virtual button constants](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FMouse_Input%252FMouse_Input.htm)|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …mouse_in_bounds

`input_mouse_in_bounds()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, returns whether the mouse is inside the window bounds

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->