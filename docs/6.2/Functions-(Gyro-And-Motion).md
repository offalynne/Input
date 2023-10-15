# Gyro and Motion

&nbsp;

Gamepad motion features provide normalized data from sensors available on PlayStation and Switch console platforms, as well as on [Windows and Linux via Steamworks extension](Steamworks.md) allowing Switch gamepad, PlayStation 4 and 5 and gamepad, Steam Controller and Steam Deck motion support. Also, configuration is provided for controlling the [player cursor](Functions-(Cursor).md) using gamepad gyro sensor data, for mouse-like pointing.

&nbsp;

<figcaption style="display: block; margin: auto; text-align:center;">Motion Axis Orientation</figcaption>
<figure><img src="assets/input_motion.png" style="width:80%; display: block; margin: auto; max-width: 400px; height: auto;" /></figure>

&nbsp;

## …motion_data_get

`input_motion_data_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct detailing the state of player gamepad motion data


|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

This function returns a struct that describes the motion of a player's gamepad, following the formatting below.

```
{
	acceleration_x: <number indicating acceleration on the X axis in Gs>,
	acceleration_y: <number indicating acceleration on the Y axis in Gs>,
	acceleration_z: <number indicating acceleration on the Z axis in Gs>,

	angular_velocity_x: <number indicating angular velocity on the X axis in radians per second>,
	angular_velocity_y: <number indicating angular velocity on the Y axis in radians per second>,
	angular_velocity_z: <number indicating angular velocity on the Z axis in radians per second>,
}
```

For details on handling motion data well for game input, see [GyroWiki](http://gyrowiki.jibbsmart.com/).

#### **Example**

```gml
//Apply real world vertical acceleration felt by gamepad motion sensor in Gs to an instance's vertical position in game
y += (input_motion_data_get().acceleration_y + 1) * (delta_time/1000000) * 10;
```

```gml
///Apply gamepad motion to a 3d controller
///Create Event
z = -64;
look_h = 0; //Horizontal look
look_v = 0; //Vertical look

///Step Event
//Get gamepad motion data
var _motion = input_motion_data_get(); 

//Change look value
look_h -= _motion.angular_velocity_y; //Apply Yaw
look_v += _motion.angular_velocity_x; //Apply Pitch

look_v = clamp(look_v, -80, 80); //Limit vertical look

///Draw event
//Setup camera projection
var _look_x = x - dcos(look_h);
var _look_y = y - dsin(look_h);
var _look_z = z - dsin(look_v);

var _camera = camera_get_active();
camera_set_view_mat(_camera, matrix_build_lookat(x, y, z, _look_x, _look_y, _look_z, 0, 0, -1));
camera_set_proj_mat(_camera, matrix_build_projection_perspective_fov(60, window_get_width() / window_get_height(), 1, 32000));

//Submit to graphics pipeline
camera_apply(_camera);
vertex_submit(vbuffer, pr_trianglelist, sprite_get_texture(spr_floor, 0));
```

<!-- tabs:end -->

&nbsp;

## …cursor_gyro_enabled_set

`input_cursor_gyro_enabled_set(state, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`state`        |boolean |Whether to enable gamepad gyro control of the cursor|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Sets whether gamepad gyro controls the cursor for the player.

#### **Example**

```gml
//Control cursor with gamepad motion when the Aim verb is active
if (input_source_using(INPUT_GAMEPAD))
{
	input_cursor_gyro_enabled_set(input_check("aim"));
}
```

<!-- tabs:end -->

&nbsp;

## …cursor_gyro_enabled_get

`input_cursor_gyro_enabled_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether gamepad gyro controls are enabled for the given player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Draw an aim indicator for each player with gyro enabled
var _i = 0;
repeat(INPUT_MAX_PLAYERS)
{
	if (input_cursor_gyro_enabled_get(_i))
	{
		draw_circle(input_cursor_x(_i), input_cursor_y(_i), 16, true);
	}
	++_i;
}
```

<!-- tabs:end -->

&nbsp;

## …cursor_gyro_params_set

`input_cursor_gyro_params_set(gyroAxisX, [gyroAxisY], [gyroSensitivityX], [gyroSensitivityY], [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name                |Datatype                                              |Purpose                                                              |
|--------------------|------------------------------------------------------|---------------------------------------------------------------------|
|`gyroAxisX`         |[`INPUT_GYRO` axis member](Library-Constants.md?id=Gyro-Axis)|World axis which controls cursor movement on the screen X axis|
|`[gyroAxisY]`       |[`INPUT_GYRO` axis member](Library-Constants.md?id=Gyro-Axis)|World axis which controls cursor movement on the screen Y axis. Not set unless specified|
|`[gyroSensitivityX]`|number                                                |Gyro sensitivity on the X axis. At `1.0`, 180 degrees in world space covers screen width. Negative value indicates inverted axis. Not set unless specified|
|`[gyroSensitivityY]`|number                                                |Gyro sensitivity on the Y axis. At `1.0`, 180 degrees in world space covers screen height. Negative value indicates inverted axis. Not set unless specified|
|`[playerIndex]`     |integer                                               |Player to target. If not specified, player 0 is used                 |

This function configures gyro control of the cursor.

#### **Example**

```gml
//Set gamepad gyro parameters applied to cursor
input_cursor_gyro_params_set(INPUT_GYRO.AXIS_ROLL, INPUT_GYRO.AXIS_PITCH, 3, -3);
```

<!-- tabs:end -->

&nbsp;

## …cursor_gyro_params_get

`input_cursor_gyro_params_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the parameters currently set for player gyro control of the cursor

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

This function returns a struct of parameters currently set for gyro control of the cursor, following the formatting below.

```
{
    axis_x: <INPUT_GYRO axis member indicating world axis which controls cursor movement on the screen X axis>,
    axis_y: <INPUT_GYRO axis member indicating world axis which controls cursor movement on the screen Y axis>,

    sensitivity_x: <number indicating sensitivity on the X axis>,
    sensitivity_y: <number indicating sensitivity on the Y axis>,
}
```

#### **Example**

```gml
//Draw gyro parameters
var _gyro_params = input_cursor_gyro_params_get();
draw_text(10, 10, "X Axis: " + string(_gyro_params.axis_x));
draw_text(10, 30, "Y Axis: " + string(_gyro_params.axis_y));
draw_text(10, 50, "Sens X: " + string(_gyro_params.sensitivity_x));
draw_text(10, 70, "Sens Y: " + string(_gyro_params.sensitivity_y));
```

<!-- tabs:end -->
