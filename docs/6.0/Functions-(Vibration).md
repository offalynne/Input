# Functions (Vibration)

&nbsp;

## …vibrate_constant

`input_vibrate_constant(strength, pan, duration, [playerIndex], [force])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                                                                                          |
|---------------|-------------------|-----------------------------------------------------------------------------------------------------------------|
|`strength`     |number             |Strength of the vibration event, from `0.0` to `1.0`                                                             |
|`pan`          |number             |Left-to-right bias for the vibration event. `-1.0` indicates fully left and `1.0` indicates fully right          |
|`duration`     |frames/milliseconds|Duration of the vibration event, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used                                                             |
|`[force]`      |boolean            |Whether this event should ignore the "vibration paused" state for the player. If not specified, `false` is used  |

Sets up a constant-strength vibration event for the given duration.

#### **Example**

```gml
//Play a vibration effect when we fire a shot
//We pan slightly left to bias slightly for high-frequency vibration on PS/XB gamepads
input_vibrate_constant(0.7, -0.3, 50);
```

<!-- tabs:end -->

&nbsp;

## …vibrate_adsr

`input_vibrate_adsr(peakStrength, sustainLevel, pan, attack, decay, sustain, release, [playerIndex], [force])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                                                                                                                                 |
|---------------|-------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
|`peakStrength` |number             |Peak strength of the vibration event at the top of the attack portion of the curve, from `0.0` to `1.0`                                                 |
|`sustainLevel` |number             |Relative strength of the sustain portion of the curve. `0.0` indicates no sustain, `1.0` indicates sustain strength should be equal to the peak strength|
|`pan`          |number             |Left-to-right bias for the vibration event. `-1.0` indicates fully left and `1.0` indicates fully right                                                 |
|`attack`       |frames/milliseconds|Duration of the attack portion of the curve, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)                           |
|`decay`        |frames/milliseconds|Duration of the decay portion of the curve, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)                            |
|`sustain`      |frames/milliseconds|Duration of the sustain portion of the curve, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)                          |
|`release`      |frames/milliseconds|Duration of the release portion of the curve, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)                          |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used                                                                                                    |
|`[force]`      |boolean            |Whether this event should ignore the "vibration paused" state for the player. If not specified, `false` is used                                         |

Sets up a vibration event that follows an attack-decay-sustain-release curve. This is likely familiar to you if you've fiddled with audio synthesis before, and the same principles apply to vibration events too.

#### **Example**

```gml
//Vibrate, slowly swelling and decaying vibration
input_vibrate_adsr(1, 0.2, 0, 300, 300, 600, 600);
```

<!-- tabs:end -->

&nbsp;

## …vibrate_pulse

`input_vibrate_pulse(strength, pan, repeats, duration, [playerIndex], [force])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                                                                                          |
|---------------|-------------------|-----------------------------------------------------------------------------------------------------------------|
|`strength`     |number             |Strength of the vibration event, from `0.0` to `1.0`                                                             |
|`pan`          |number             |Left-to-right bias for the vibration event. `-1.0` indicates fully left and `1.0` indicates fully right          |
|`repeats`      |integer            |Numbers of pulses to execute over the course of the vibration event                                              |
|`duration`     |frames/milliseconds|Duration of the vibration event, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used                                                             |
|`[force]`      |boolean            |Whether this event should ignore the "vibration paused" state for the player. If not specified, `false` is used  |

Sets up a vibration event that emits a fixed number of pulses over the given duration.

#### **Example**

```gml
//Vibrate with a throbbing pulse
input_vibrate_pulse(1, 0, 5, 600);
```

<!-- tabs:end -->

&nbsp;

## …vibrate_curve

`input_vibrate_curve(strength, curve, pan, duration, [playerIndex], [force])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                                                                                          |
|---------------|-------------------|-----------------------------------------------------------------------------------------------------------------|
|`strength`     |number             |Strength of the vibration event, from `0.0` to `1.0`                                                             |
|`curve`        |animation curve    |Animation curve to follow                                                                                        |
|`pan`          |number             |Left-to-right bias for the vibration event. `-1.0` indicates fully left and `1.0` indicates fully right          |
|`duration`     |frames/milliseconds|Duration of the vibration event, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used                                                             |
|`[force]`      |boolean            |Whether this event should ignore the "vibration paused" state for the player. If not specified, `false` is used  |

Sets up a vibration event that follows an animation curve defined in the GameMaker IDE.

#### **Example**

```gml
//Vibrate for a whole second according to the <curve_test_vibration> curve
input_vibrate_curve(1, curve_test_vibration, 0, 1000);
```

<!-- tabs:end -->

&nbsp;

## …vibrate_stop

`input_vibrate_stop([playerIndex])`

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
if (global.demo_mode && input_long_pressed("pause"))
{
	//Stop all vibration
	input_vibrate_stop();

	//And return to the main menu
	room_goto(rm_main_menu);
}
```

<!-- tabs:end -->

&nbsp;

## …vibrate_set_pause

`input_vibrate_set_pause(state, [playerIndex])`

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
if (input_pressed("pause"))
{
	//Pause all vibration
	input_vibrate_set_pause(true);

	//And return to the main menu
	instance_create_layer(0, 0, "UI", obj_pause_menu);

	//N.B.  input_vibrate_set_pause(false) should be called when unpausing
```

<!-- tabs:end -->

&nbsp;

## …vibrate_get_pause

`input_vibrate_get_pause([playerIndex])`

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
	draw_text(10, 10, "Vibr Pause = " + string(input_vibrate_get_pause()));
}
```

<!-- tabs:end -->

&nbsp;

## …vibrate_set_strength

`input_vibrate_set_strength(strength, [playerIndex])`

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
var _delta = 0.05*input_check_opposing_repeat("left", "right");
if (_delta != 0)
{
	//Clamp the new strength between 0 and 1
	var _strength = clamp(input_vibrate_get_strength() + _delta, 0, 1);

	//Actually set the new strength
	input_vibrate_set_strength(_strength);

	//Play a little buzz to indicate to the player how strong the new setting is
	input_vibrate_constant(0.9, 0, 60, 0, true);
}
```

<!-- tabs:end -->

&nbsp;

## …vibrate_get_strength

`input_vibrate_get_strength([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the overall strength for all vibration events for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Draw the vibration strength to the screen
draw_text(x, y, "Vibration = " + string(input_vibrate_get_strength()));
```

<!-- tabs:end -->