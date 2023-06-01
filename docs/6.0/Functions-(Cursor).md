# Functions (Cursor)

&nbsp;

The "cursor" is Input's own native solution for cross-platform and cross-device mouse emulation. The cursor allows quick and easy replication of mouse-like behaviour whilst using a gamepad or keyboard. The cursor can also be directly driven by the mouse or a touchscreen as well in situations where that is available.

&nbsp;

## …cursor_x

`input_cursor_x([playerIndex], [coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the x-coordinate of the given player's cursor

|Name           |Datatype                |Purpose                                                                                                        |
|---------------|------------------------|---------------------------------------------------------------------------------------------------------------|
|`[playerIndex]`|number                  |Player to target. If not specified, player 0 is used                                                           |
|`[coordSpace]` |`INPUT_COORD_SPACE` enum|Coordinate space to use. If not specified, the coordinate space set by `input_cursor_coord_space_set()` is used|

Please see `input_cursor_coord_space_set()` for information on the `INPUT_COORD_SPACE` enum.

#### **Example**

```gml
//Draw the cursor at the correct position
draw_sprite(spr_cursor, 0, input_cursor_x(), input_cursor_y());
```

<!-- tabs:end -->

&nbsp;

## …cursor_y

`input_cursor_y([playerIndex], [coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the y-coordinate of the given player's cursor

|Name           |Datatype                |Purpose                                                                                                        |
|---------------|------------------------|---------------------------------------------------------------------------------------------------------------|
|`[playerIndex]`|number                  |Player to target. If not specified, player 0 is used                                                           |
|`[coordSpace]` |`INPUT_COORD_SPACE` enum|Coordinate space to use. If not specified, the coordinate space set by `input_cursor_coord_space_set()` is used|

Please see `input_cursor_coord_space_set()` for information on the `INPUT_COORD_SPACE` enum.

#### **Example**

```gml
//Grab the x/y coordinates of the cursor
//We ensure we're in room space here
var _x = input_cursor_x(INPUT_COORD_SPACE.ROOM);
var _y = input_cursor_y(INPUT_COORD_SPACE.ROOM);

//If the cursor is far enough away from us, aim at the cursor
if (point_distance(x, y, _x, _y) > 10)
{
	aim_direction = point_direction(x, y, _x, _y);
}

```

<!-- tabs:end -->

&nbsp;

## …cursor_dx

`input_cursor_dx([playerIndex], [coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, how far the cursor has moved in the x-axis between frames

|Name           |Datatype                |Purpose                                                                                                        |
|---------------|------------------------|---------------------------------------------------------------------------------------------------------------|
|`[playerIndex]`|number                  |Player to target. If not specified, player 0 is used                                                           |
|`[coordSpace]` |`INPUT_COORD_SPACE` enum|Coordinate space to use. If not specified, the coordinate space set by `input_cursor_coord_space_set()` is used|

Please see `input_cursor_coord_space_set()` for information on the `INPUT_COORD_SPACE` enum.

#### **Example**

```gml
//Grab the mouse delta values
var _dx = input_cursor_dx();
var _dy = input_cursor_dy();

//If the cursor has been moved far enough...
if (point_distance(0, 0, _dx, _dy) > 1)
{
	//...then draw a trail
	var _x = input_cursor_x();
	var _y = input_cursor_y();
	var _direction = point_direction(0, 0, _dx, _dy);

	draw_trail(_x, _y, _x + lengthdir_x(4, _direction), _y + lengthdir_y(4, _direction));
}
```

<!-- tabs:end -->

&nbsp;

## …cursor_dy

`input_cursor_dy([playerIndex], [coordSpace])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, how far the cursor has moved in the y-axis between frames

|Name           |Datatype                |Purpose                                                                                                        |
|---------------|------------------------|---------------------------------------------------------------------------------------------------------------|
|`[playerIndex]`|number                  |Player to target. If not specified, player 0 is used                                                           |
|`[coordSpace]` |`INPUT_COORD_SPACE` enum|Coordinate space to use. If not specified, the coordinate space set by `input_cursor_coord_space_set()` is used|

Please see `input_cursor_coord_space_set()` for information on the `INPUT_COORD_SPACE` enum.

#### **Example**

```gml
//Get the cursor position
var _x = input_cursor_x();
var _y = input_cursor_y();

//If we're in contact with the cursor...
if (point_distance(x, y, _x, _y) < 30)
{
	//...the bounce off the cursor depending on the cursor's upwards velocity
	vspeed += min(0, 0.2*input_cursor_dy());
}
```

<!-- tabs:end -->

&nbsp;

## …cursor_speed_set

`input_cursor_speed_set(speed, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                           |
|---------------|--------|------------------------------------------------------------------|
|`speed`        |number  |Movement speed for the cursor when using keyboard or gamepad input|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used              |

?> Cursor speed is only valid for keyboard and gamepad input.

#### **Example**

```gml
//Control cursor speed adjustment by reading the "left" and "right" verbs
var _delta = 0.1*input_check_opposing("left", "right");

//Calculate the new speed
var _speed = clamp(input_cursor_speed_get() + _delta, 0.1, 2);

//Set the cursor speed
input_cursor_speed_set(_speed);
```

<!-- tabs:end -->

&nbsp;

## …cursor_speed_get

`input_cursor_speed_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the cursor speed when using keyboard or gamepad input

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
draw_text(x, y, "Cursor speed: " + string(input_cursor_speed_get()));
```

<!-- tabs:end -->

&nbsp;

## …cursor_inverted_set

`input_cursor_inverted_set(state, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                    |
|---------------|--------|-----------------------------------------------------------|
|`state`        |boolean |When the cursor's movement in the y-axis should be inverted|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used       |

Cursor y-axis inversion only applies when using a keyboard or gamepad to move the cursor, or when the mouse has been captured (see `input_mouse_capture_set()`).

#### **Example**

```gml
//If we select this button, toggle cursor inversion
if (input_pressed("accept")) input_cursor_inverted_set(not input_cursor_inverted_get());
```

<!-- tabs:end -->

&nbsp;

## …cursor_inverted_get

`input_cursor_inverted_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the cursor's y-axis movement is inverted

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
draw_text(x, y, input_cursor_inverted_get()? "Inverted" : "Uninverted");
```

<!-- tabs:end -->

&nbsp;

&nbsp;

## …cursor_coord_space_set

`input_cursor_coord_space_set(coordSpace, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype                |Purpose                                                                                                   |
|---------------|------------------------|----------------------------------------------------------------------------------------------------------|
|`coordSpace`   |`INPUT_COORD_SPACE` enum|The coordinate space the cursor will operate in when using a mouse to control a player's cursor. See below|
|`[playerIndex]`|integer                 |Player to target. If not specified, player 0 is used                                                      |

This function changes what coordinate space is used as a reference for setting the cursor's position with mouse input.

`INPUT_COORD_SPACE` contains the following members:

|Name     |Purpose                                                                                   |
|---------|------------------------------------------------------------------------------------------|
|`.ROOM`  |Room coordinates; should be the same as `mouse_x` and `mouse_y`. This is the default value|
|`.GUI`   |GUI coordinates                                                                           |
|`.DEVICE`|Raw device-space coordinates                                                              |

#### **Example**

```gml
//Default to using GUI-space cursor coordinates
input_cursor_coord_space_set(INPUT_COORD_SPACE.GUI);
```

<!-- tabs:end -->

&nbsp;

## …cursor_coord_space_get

`input_cursor_coord_space_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** A member of `INPUT_COORD_SPACE`, the cursor coordinate space that has been set

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Output a warning message into the console if we're not using the right coordinate space for the cursor
if (input_cursor_coord_space_get() != INPUT_COORD_SPACE.ROOM)
{
	show_debug_message("Warning! Not using INPUT_COORD_SPACE.ROOM for cursor");
	input_cursor_coord_space_set(INPUT_COORD_SPACE.ROOM);
}
```

<!-- tabs:end -->

&nbsp;

## …cursor_mouse_enabled_set

`input_cursor_mouse_enabled_set(state, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                               |
|---------------|--------|------------------------------------------------------|
|`state`        |boolean |Whether the player can use a mouse can move the cursor|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used  |

Input will only allow a mouse to move the cursor if the player in question has been assigned the `INPUT_MOUSE` source. `input_cursor_mouse_enabled_set()` allows you further control on top of this behaviour.

#### **Example**

```gml
//If we're on mobile and the player is using a gamepad...
if (((os_type == os_ios) || (os_type == os_android)) && input_source_using(INPUT_GAMEPAD))
{
	//Then prevent the "mouse" from moving the cursor
	input_cursor_mouse_enabled_set(false);
}
else
{
	//Otherwise let the mouse move the cursor
	input_cursor_mouse_enabled_set(true);
}
```

<!-- tabs:end -->

&nbsp;

## …cursor_mouse_enabled_get

`input_cursor_mouse_enabled_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the player can use a mouse to move the cursor

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//If the pause menu is open and moving the cursor with the mouse is forbidden
if (instance_exists(obj_pause) && !input_cursor_mouse_enabled_get())
{
	//...then draw the "no mouse" sprite
	draw_sprite(spr_no_mouse, 0, x, y);
}
```

<!-- tabs:end -->