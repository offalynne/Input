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
////Handle mouse capturing
///Create event
cursor = window_get_cursor();

///Step event
//Capture the mouse when the game is clicked
if (input_mouse_check_pressed(mb_left))
{
	input_mouse_capture_set(true);
	cursor = cr_none;
}

//Release mouse capture when the game is paused or loses focus
if (input_check_pressed("pause") || !input_window_has_focus())
{
	input_mouse_capture_set(false);
	cursor = cr_default;
}

//Change the OS cursor appropriately
if (window_get_cursor() != cursor)
{
	window_set_cursor(cursor);
}
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
|`.blocked`    |boolean |Whether the display or application state prevent the cursor from being limited to the window area|

#### **Example**

```gml
//Draw mouse capture state
var _capture_state = input_mouse_capture_get();
draw_text(10, 10, string(_capture_state.capture));
draw_text(10, 30, string(_capture_state.sensitivity));
draw_text(10, 50, string(_capture_state.blocked));
```

<!-- tabs:end -->
