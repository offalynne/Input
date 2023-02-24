# Functions (Motion)

&nbsp;

Gamepad motion features provide normalized data from sensors available on PlayStation and Switch console platforms, as well as [Windows and Linux via Steamworks extension](Steamworks.md) adding Steam Controller and Steam Deck support. Also, configuration is provided for controlling the [player cursor](Functions-(Cursor).md) using gamepad gyro sensor data, for mouse-like pointing.

&nbsp;

<figcaption style="display: block; margin: auto; text-align:center;" >Motion Axis Orientation</figcaption>
<figure><img src="https://i.imgur.com/hD8njcV.png" style="width:80%; display: block; margin: auto; max-width: 400px; height: auto;" /></figure>

&nbsp;

## `input_motion_data_get([playerIndex])`

*Returns:* Struct detailing the state of player gamepad motion data


|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

This function returns a struct that describes the motion of  a player's gamepad, following the formatting below.

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

&nbsp;

## `input_gyro_enabled_set(state, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`state`        |boolean |Whether to enable gamepad gyro control of the cursor|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Sets whether gamepad gyro controls the cursor for the player.

&nbsp;

## `input_gyro_enabled_get([playerIndex])`

*Returns:* Boolean, whether gamepad gyro controls are enabled for the given player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_gyro_params_set(gyroAxisX, [gyroAxisY], [gyroSensitivityX], [gyroSensitivityY], [playerIndex])`

*Returns:* N/A (`undefined`)

|Name                |Datatype                                              |Purpose                                                              |
|--------------------|------------------------------------------------------|---------------------------------------------------------------------|
|`gyroAxisX`         |[`INPUT_GYRO` axis member](Library-Constants.md?id=Gyro-Axis)|World axis which controls cursor movement on the screen X axis|
|`[gyroAxisY]`       |[`INPUT_GYRO` axis member](Library-Constants.md?id=Gyro-Axis)|World axis which controls cursor movement on the screen Y axis. Not set unless specified|
|`[gyroSensitivityX]`|number                                                |Gyro sensitivity on the X axis. At `1.0`, 180 degrees in world space covers screen width. Negative value indicates inverted axis. Not set unless specified|
|`[gyroSensitivityY]`|number                                                |Gyro sensitivity on the Y axis. At `1.0`, 180 degrees in world space covers screen height. Negative value indicates inverted axis. Not set unless specified|
|`[playerIndex]`     |integer                                               |Player to target. If not specified, player 0 is used                 |

This function configures gyro control of the cursor.

&nbsp;

## `input_gyro_params_get([playerIndex])`

*Returns:* Struct, the parameters currently set for player gyro control of the cursor

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

&nbsp;
