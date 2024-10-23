# Plug-in: Gyro and Motion

&nbsp;

Gamepad motion features provide normalized data from sensors available on PlayStation and Switch console platforms, as well as on [Windows and Linux via Steamworks extension](Steamworks.md) allowing Switch gamepad, PlayStation 4 and 5 gamepad, Steam Controller, and Steam Deck motion support.

&nbsp;

<figcaption style="display: block; margin: auto; text-align:center;">Motion Axis Orientation</figcaption>
<figure><img src="assets/input_motion.png" style="width:80%; display: block; margin: auto; max-width: 400px; height: auto;" /></figure>

&nbsp;

## …MotionCalibrate

`InputMotionCalibrate([playerIndex])`

<!-- tabs:start -->

#### **Description**

Calbirates gamepad motion for the player.

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
if (InputPressed(INPUT_VERB.AIM))
{
	InputMotionCalibrate();
}
```
<!-- tabs:end -->

&nbsp;

## …MotionIsCalibrated

`InputMotionIsCalibrated()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether gamepad motion is calibrated for the given player


|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
if (not InputMotionIsCalibrated())
{
    draw_text(10, 10, "Press [AIM] to calibrate motion");
}
```
<!-- tabs:end -->

&nbsp;

## …MotionGet

`InputMotionGet([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct detailing the state of player gamepad motion data, or `undefined`

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

This function returns a struct that describes the motion of a player's gamepad, following the formatting below. Values will inherently be noisy and some smoothing will be required to make them usable.

```
{
	accelerationX: <number indicating acceleration on the X axis in Gs>,
	accelerationY: <number indicating acceleration on the Y axis in Gs>,
	accelerationZ: <number indicating acceleration on the Z axis in Gs>,

	angularVelocityX: <number indicating angular change on the X axis in radians>,
	angularVelocityY: <number indicating angular change on the Y axis in radians>,
	angularVelocityZ: <number indicating angular change on the Z axis in radians>,

	quatDeviceX: <number indicating quaternion position on the X axis in radians>,
	quatDeviceY: <number indicating quaternion position on the Y axis in radians>,
	quatDeviceZ: <number indicating quaternion position on the Z axis in radians>,
	quatDeviceW: <number indicating quaternion position on the W axis in radians>,

	quatRoll:  <number in radians indicating gamepad roll>,
	quatPitch: <number in radians indicating gamepad pitch>,
	quatYaw:   <number in radians indicating gamepad yaw>
}
```

#### **Example**

```gml
if (InputPressed(INPUT_VERB.ACCEPT))
{
	InputMotionCalibrate();
}

var _motion = InputMotionGet();
if (_motion != undefined)
{
	pointerX = room_width  * (0.5 + _motion.quatYaw/30);
	pointerY = room_height * (0.5 + _motion.quatPitch/30);

	//pointerX = room_width  * (0.5 + 0.5*_motion.angularVelocityX)/30;
	//pointerY = room_height * (0.5 + 0.5*_motion.angularVelocityY)/30;
}
```
<!-- tabs:end -->

&nbsp;

## …MotionGet

`InputMotionGetDirect(device)`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct detailing the state of gamepad device motion data, or `undefined`

|Name      |Datatype|Purpose                                           |
|----------|--------|--------------------------------------------------|
|`device`|integer |Device to target                                    |

This function returns a struct that describes the motion of a gamepad, following the formatting below. Values will inherently be noisy and some smoothing will be required to make them usable.

```
{
	accelerationX: <number indicating acceleration on the X axis in Gs>,
	accelerationY: <number indicating acceleration on the Y axis in Gs>,
	accelerationZ: <number indicating acceleration on the Z axis in Gs>,

	angularVelocityX: <number indicating angular velocity on the X axis in radians per second>,
	angularVelocityY: <number indicating angular velocity on the Y axis in radians per second>,
	angularVelocityZ: <number indicating angular velocity on the Z axis in radians per second>,
	
	quatDeviceX: <number indicating quaternion position on the X axis in radians>,
	quatDeviceY: <number indicating quaternion position on the Y axis in radians>,
	quatDeviceZ: <number indicating quaternion position on the Z axis in radians>,
	quatDeviceW: <number indicating quaternion position on the W axis in radians>,

	quatRoll:  <number in radians indicating gamepad roll>,
	quatPitch: <number in radians indicating gamepad pitch>,
	quatYaw:   <number in radians indicating gamepad yaw>
}
```

#### **Example**

```gml
for(var _i = 0; _i < 4; _i++)
{
	draw_text(10, 10 + 20*_i, string_replace_all(json_stringify(InputMotionGetDirect(_i), ",", "\n"));
}
```
<!-- tabs:end -->

&nbsp;

## …MotionSupported

`InputMotionSupported([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether motion is supported for the device assigned to a player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
if (not InputMotionSupported())
{
	draw_text_ext(10, 10, "Motion not supported by this gamepad (or Steam Input not enabled for this gamepad)", -1, room_width-20);
}
```
<!-- tabs:end -->
