# Mouse (Direct)

&nbsp;

?> The functions on this page are provided for convenience if you want to implement your own features using Input's mouse implementation. In general, [verbs](Verbs-and-Bindings) are the intended way to use Input and are preferred.

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
//Move towards mouse x-coordinate whilst maintain our y-coordinate
direction = point_direction(x, y, input_mouse_x(), y);
speed = 1;
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
//Move towards mouse y-coordinate whilst maintain our x-coordinate
direction = point_direction(x, y, x, input_mouse_y());
speed = 1;
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
//Spawn particles when the cursor is moved beyond a certain amount on the x-axis
if (input_mouse_dx() > 3)
{
	part_particles_create(particle_system,
	                      input_mouse_x(), input_mouse_y(),
		                  particle_type, particle_count);	
}
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
//Spawn particles when the cursor is moved beyond a certain amount on the y-axis
if (input_mouse_dy() > 3)
{
	part_particles_create(particle_system,
	                      input_mouse_x(), input_mouse_y(),
		                  particle_type, particle_count);	
}
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
//If the mouse is moving, make a cursor object visible, otherwise hide it
obj_cursor.visible = input_mouse_moved()
```

<!-- tabs:end -->

&nbsp;

## …mouse_wheel_up

`input_mouse_wheel_up()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the mouse wheel has been moved up

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Change weapon by scrolling the mouse wheel
var _delta = input_mouse_wheel_down() - input_mouse_wheel_up();
weapon = (weapon + _delta) mod total_weapons;

//Change our sprite to match the weapon
sprite_index = weapon_sprite[weapon];
```

<!-- tabs:end -->

&nbsp;

## …mouse_wheel_down

`input_mouse_wheel_down()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the mouse wheel has been moved down

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
if (debug_mode)
{
	//Activate the debug overlay with a flick of the mouse wheel if we're in debug mode
	if (input_mouse_wheel_down()) obj_debug_overlay.visible = true;
	if (input_mouse_wheel_up()) obj_debug_overlay.visible = false;
}
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
///Draw GUI

//Set the mouse coordinate space to GUI 
input_mouse_coord_space_set(INPUT_COORD_SPACE.GUI)

//Check if the mouse is inside the GUI button bounds
if ((input_mouse_x() >=   8)
&&  (input_mouse_x() <= 128)
&&  (input_mouse_y() >=   8)
&&  (input_mouse_y() <=  64))
{
	//Change the color to indicate the mouse hovering
	draw_set_color(c_red);
}

draw_button(8, 8, 128, 64, true);

//Reset color and coordinate space
draw_set_color(c_white);
input_mouse_coord_space_set(INPUT_COORD_SPACE.ROOM);
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
//Print the current coordinate space for debugging purposes
//Create an array to convert the enum members to human-readable output

var _coord_space_as_string = array_create(INPUT_COORD_SPACE.__SIZE, "Unknown/Error");
    _coord_space_as_string[INPUT_COORD_SPACE.DISPLAY] = "Display";
    _coord_space_as_string[INPUT_COORD_SPACE.ROOM   ] = "Room";
    _coord_space_as_string[INPUT_COORD_SPACE.GUI    ] = "GUI";

show_debug_message("Current coordinate space is: " + _coord_space_as_string[input_mouse_coord_space_get()]);
```

<!-- tabs:end -->

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
//Simple cursor based movement

//Check if the left mouse button is active
if (input_mouse_check(mb_left))
{
	//Move towards cursor, since our players coordinates are ROOM coordinates
	//Our cursor coordinates need to be in the ROOM coordinate space too!
	move_towards_point(input_mouse_x(INPUT_COORD_SPACE.ROOM), 
                       input_mouse_y(INPUT_COORD_SPACE.ROOM),
                       1);
}
else
{
	speed = 0
}
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
//Interact with item on right click
if (input_mouse_check_pressed(mb_right))
{
	nearest = instance_nearest(input_mouse_x(), input_mouse_y(), obj_item);

	//Check if a nearest object was found and then check if its reasonably close to the cursor
	if ((nearest != noone) and (point_distance(input_mouse_x(), input_mouse_y(), nearest.x, nearest.y) < 16))
	{
		nearest.interact_with();
	}
}
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
//Cursor with a grab and release animation

//Check if the left mouse button got pressed
if (input_mouse_check_pressed(mb_left))
{
	obj_cursor.sprite_index = spr_cursor_grab;
}

//Check if the left mouse button got released
if (input_mouse_check_released(mb_left))
{
	obj_cursor.sprite_index = spr_cursor_release;
}
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
//If the mouse cursor leaves the window, pause the game
if (not input_mouse_in_bounds())
{
	game_pause();
}
```

<!-- tabs:end -->
