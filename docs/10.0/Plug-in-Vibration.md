# Plug-in: Vibration

&nbsp;

Vibration is available for the gamepads on console platforms. On Windows, Xbox gamepads are supported, as well as other gamepad types [via Steamworks extension](Steamworks.md).

&nbsp;

## Config

`__InputVibrateConfig()` holds macros that affect the general behavior of gamepad vibration. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for the plug-in to work.

|Name                                   |Typical&nbsp;Value|Purpose                                   |
|---------------------------------------|-------------|------------------------------------------|
|`INPUT_VIBRATION_DEFAULT_STRENGTH`     |`1.0`        |The default vibration strength            |
|`INPUT_VIBRATION_JOYCON_STRENGTH`      |`0.4`        |The default strength of Joy-Con vibration relative to other devices|
|`INPUT_FIX_PS_NATIVE_VIBRATION_SIDE`   |`true`       |Corrects a runtime 2024.8 bug affecting gamepad vibration on PlayStation platforms|

&nbsp;

## …VibrateConstant

`InputVibrateConstant(strength, pan, duration, [playerIndex], [force])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                                                                                          |
|---------------|-------------------|-----------------------------------------------------------------------------------------------------------------|
|`strength`     |number             |Strength of the vibration event, from `0.0` to `1.0`                                                             |
|`pan`          |number             |Left-to-right bias for the vibration event. `-1.0` indicates fully left and `1.0` indicates fully right          |
|`duration`     |milliseconds       |Duration of the vibration event in milliseconds                                                                  |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used                                                             |
|`[force]`      |boolean            |Whether this event should ignore the "vibration paused" state for the player. If not specified, `false` is used  |

Sets up a constant-strength vibration event for the given duration.

#### **Example**

```gml
//Play a vibration effect when we fire a shot
//We pan slightly left to bias slightly for high-frequency vibration on PS/XB gamepads
InputVibrateConstant(0.7, -0.3, 50);
```

<!-- tabs:end -->

&nbsp;

## …VibrateADSR

`InputVibrateADSR(peakStrength, sustainLevel, pan, attack, decay, sustain, release, [playerIndex], [force])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                                                                                                                                 |
|---------------|-------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
|`peakStrength` |number             |Peak strength of the vibration event at the top of the attack portion of the curve, from `0.0` to `1.0`                                                 |
|`sustainLevel` |number             |Relative strength of the sustain portion of the curve. `0.0` indicates no sustain, `1.0` indicates sustain strength should be equal to the peak strength|
|`pan`          |number             |Left-to-right bias for the vibration event. `-1.0` indicates fully left and `1.0` indicates fully right                                                 |
|`attack`       |milliseconds       |Duration of the attack portion of the curve in milliseconds                           |
|`decay`        |milliseconds       |Duration of the decay portion of the curve in milliseconds                            |
|`sustain`      |milliseconds       |Duration of the sustain portion of the curve in milliseconds                          |
|`release`      |milliseconds       |Duration of the release portion of the curve in milliseconds                          |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used                                                                                                    |
|`[force]`      |boolean            |Whether this event should ignore the "vibration paused" state for the player. If not specified, `false` is used                                         |

Sets up a vibration event that follows an attack-decay-sustain-release curve. This is likely familiar to you if you've fiddled with audio synthesis before, and the same principles apply to vibration events too.

#### **Example**

```gml
//Vibrate, slowly swelling and decaying vibration
InputVibrateADSR(1, 0.2, 0, 300, 300, 600, 600);
```

<!-- tabs:end -->

&nbsp;

## …VibratePulse

`InputVibratePulse(strength, pan, repeats, duration, [playerIndex], [force])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                                                                                          |
|---------------|-------------------|-----------------------------------------------------------------------------------------------------------------|
|`strength`     |number             |Strength of the vibration event, from `0.0` to `1.0`                                                             |
|`pan`          |number             |Left-to-right bias for the vibration event. `-1.0` indicates fully left and `1.0` indicates fully right          |
|`repeats`      |integer            |Numbers of pulses to execute over the course of the vibration event                                              |
|`duration`     |milliseconds       |Duration of the vibration event in milliseconds|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used                                                             |
|`[force]`      |boolean            |Whether this event should ignore the "vibration paused" state for the player. If not specified, `false` is used  |

Sets up a vibration event that emits a fixed number of pulses over the given duration.

#### **Example**

```gml
//Vibrate with a throbbing pulse
InputVibratePulse(1, 0, 5, 600);
```

<!-- tabs:end -->

&nbsp;

## …VibrateCurve

`InputVibrateCurve(strength, curve, pan, duration, [playerIndex], [force])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                                                                                          |
|---------------|-------------------|-----------------------------------------------------------------------------------------------------------------|
|`strength`     |number             |Strength of the vibration event, from `0.0` to `1.0`                                                             |
|`curve`        |animation curve    |Animation curve to follow                                                                                        |
|`pan`          |number             |Left-to-right bias for the vibration event. `-1.0` indicates fully left and `1.0` indicates fully right          |
|`duration`     |milliseconds       |Duration of the vibration event in milliseconds|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used                                                             |
|`[force]`      |boolean            |Whether this event should ignore the "vibration paused" state for the player. If not specified, `false` is used  |

Sets up a vibration event that follows an animation curve defined in the GameMaker IDE.

#### **Example**

```gml
//Vibrate for a whole second according to the <curve_test_vibration> curve
InputVibrateCurve(1, curve_test_vibration, 0, 1000);
```

<!-- tabs:end -->

&nbsp;

## …VibrateStop

`InputVibrateStop([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Immediately stops all vibration for the target player.

#### **Example**

```gml
//If we're in demo mode and the player long-presses the pause verb...
if (global.demo_mode && InputPressed(INPUT_VERB.PAUSE))
{
	//Stop all vibration
	InputVibrateStop();

	//And return to the main menu
	room_goto(rm_main_menu);
}
```

<!-- tabs:end -->

&nbsp;

## …VibrateSetPause

`InputVibrateSetPause(state, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`state`        |number  |Whether vibration events should be paused for the player|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used    |

Whilst player vibration is paused, typically no new vibration events can be created for the player in question. If you'd still like to create vibration events for the player even when vibration is paused (e.g. for previewing vibration strength on a settings menu), set the optional `force` argument for vibration events to `true`.

#### **Example**

```gml
//If the player pauses the game...
if (InputPressed(INPUT_VERB.PAUSE))
{
	//Pause all vibration
	InputVibrateSetPause(true);

	//And return to the main menu
	instance_create_layer(0, 0, "UI", obj_pause_menu);

	//N.B.  InputVibrateSetPause(false) should be called when unpausing
```

<!-- tabs:end -->

&nbsp;

## …VibrateGetPause

`InputVibrateGetPause([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether vibration events can proceed for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Draw the current vibration pause state to the screen if we're debugging
if (debug_mode)
{
	draw_text(10, 10, "Vibr Pause = " + string(InputVibrateGetPause()));
}
```

<!-- tabs:end -->

&nbsp;

## …VibrateSetStrength

`InputVibrateSetStrength(strength, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`strength`     |number  |Overall strength for all vibration events for the player|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used    |

#### **Example**

```gml
//Adjust the strength of the vibration based on tapping left/right
var _delta = 0.05*InputOpposingRepeat(INPUT_VERB.LEFT, INPUT_VERB.RIGHT);
if (_delta != 0)
{
	//Clamp the new strength between 0 and 1
	var _strength = clamp(InputVibrateGetStrength() + _delta, 0, 1);

	//Actually set the new strength
	InputVibrateSetStrength(_strength);

	//Play a little buzz to indicate to the player how strong the new setting is
	InputVibrateConstant(0.9, 0, 60, 0, true);
}
```

<!-- tabs:end -->

&nbsp;

## …VibrateGetStrength

`InputVibrateGetStrength([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the overall strength for all vibration events for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Draw the vibration strength to the screen
draw_text(x, y, "Vibration = " + string(InputVibrateGetStrength()));
```

<!-- tabs:end -->

&nbsp;

## …VibrationGetSupported

`InputVibrationGetSupported([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether vibration is supported for the device assigned to a player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Draw gamepad vibration availability
draw_text(x, y, "Vibration support: ", string(InputVibrationGetSupported()));
```

<!-- tabs:end -->