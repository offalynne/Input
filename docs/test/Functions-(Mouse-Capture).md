# Functions (Mouse Capture)

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