# Functions (Trigger Effects)

&nbsp;

Adaptive trigger effects are available for the DualSense gamepad on the PlayStation 5 console platform, as well as [Windows via Steamworks extension](Steamworks.md). One effect can be set per trigger. In `MIXED` and `MULTIDEVICE` [source modes](Source-Modes), only the first controller is used.

&nbsp;

## …trigger_effect_off

`input_trigger_effect_off(trigger, [playerIndex])`

<!-- tabs:start -->

#### **Description**

|Name           |Datatype|Purpose                                                                               |
|---------------|--------|--------------------------------------------------------------------------------------|
|`trigger`      |integer |Trigger to set using GameMaker’s native constants (`gp_shoulderlb` or `gp_shoulderrb`)|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                  |

#### **Example**

```gml
if (game_over)
{
	//Turn off trigger effects
	input_trigger_effect_off(gp_shoulderlb);
	input_trigger_effect_off(gp_shoulderrb);
}
```

<!-- tabs:end -->

&nbsp;

## …trigger_effect_feedback

`input_trigger_effect_feedback(trigger, position, strength, [playerIndex])`

<!-- tabs:start -->

#### **Description**

|Name           |Datatype|Purpose                                                                               |
|---------------|--------|--------------------------------------------------------------------------------------|
|`trigger`      |integer |Trigger to set using GameMaker’s native constants (`gp_shoulderlb` or `gp_shoulderrb`)|
|`position`     |number  |Analogue trigger axis value where feedback effect should activate, between 0 and 1    |
|`strength`     |number  |Strength of trigger effect, between 0 and 1                                           |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                  |

#### **Example**

```gml
//Add resistance when in sand
if ((in_sand == false) && instance_place(x, y, obj_sand))
{
	image_blend = c_yellow; //Tint the instance
	friction = 0.5;         //Set friction

	//Set feedback effect on left trigger
	input_trigger_effect_feedback(gp_shoulderlb, 0.3, 0.5);

	in_sand = true;
}
```

<!-- tabs:end -->

&nbsp;

## …trigger_effect_vibration

`input_trigger_effect_vibration(trigger, position, amplitude, frequency, [playerIndex])`

<!-- tabs:start -->

#### **Description**

|Name           |Datatype|Purpose                                                                               |
|---------------|--------|--------------------------------------------------------------------------------------|
|`trigger`      |integer |Trigger to set using GameMaker’s native constants (`gp_shoulderlb` or `gp_shoulderrb`)|
|`position`     |number  |Analogue trigger axis value where vibration effect should activate, between 0 and 1   |
|`amplitude`    |number  |Amplitude of trigger effect, between 0 and 1                                          |
|`frequency`    |number  |Frequency of trigger effect, between 0 and 1                                          |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                  |

#### **Example**

```gml
//Add trigger vibration when pressing the gas pedal
if ((using_gas == false) && input_check("accelerator"))
{
	audio_play_sound(snd_gas, 0, true);     //Loop sound effect
	speed = input_value("accelerator") * 5; //Set speed

	//Set vibration effect on right trigger
	input_trigger_effect_vibration(gp_shoulderrb, 0.2, 0.5, 0.2);

	using_gas = true;
}
```

<!-- tabs:end -->

&nbsp;

## …trigger_effect_weapon

`input_trigger_effect_weapon(trigger, start, end, strength, [playerIndex])`

<!-- tabs:start -->

#### **Description**

|Name           |Datatype|Purpose                                                                               |
|---------------|--------|--------------------------------------------------------------------------------------|
|`trigger`      |integer |Trigger to set using GameMaker’s native constants (`gp_shoulderlb` or `gp_shoulderrb`)|
|`start`        |number  |Analogue trigger axis value where weapon effect should start, between 0 and 1         |
|`end`          |number  |Analogue trigger axis value where weapon effect should end, between `start` and 1     |
|`strength`     |number  |Strength of trigger effect, between 0 and 1                                           |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                  |

#### **Example**

```gml
//Add trigger effect when weapon is equipped
if ((using_pistol == false) && input_check_pressed("equip pistol"))
{
	//Play sound effect
	audio_play_sound(snd_unholster, 0, false);

	//Set trigger effect on right trigger
	input_trigger_effect_weapon(gp_shoulderrb, 0.7, 0.85, 1);

	using_pistol = true;
}
```

<!-- tabs:end -->

&nbsp;

## …trigger_effect_get_state

`input_trigger_effect_get_state(trigger, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** [Trigger effect state constant](Library-Constants?id=trigger-effect-states)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`trigger`      |integer |Trigger to set using GameMaker’s native constants (`gp_shoulderlb` or `gp_shoulderrb`)|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Check for hip fire
if (hip_firing == false)
{
	//Check trigger effect or "fire" verb
	if ((input_trigger_effect_get_state(gp_shoulderrb) == INPUT_TRIGGER_STATE.EFFECT_WEAPON_FIRED)
	||  (input_check_pressed("fire"))
	{
		//Play sound effect
		audio_play_sound(snd_gunshot, 0, false);

		//Create bullet instance
		with (instance_create_depth(x, y, depth - 1, obj_bullet))
		{
			direction = other.direction;
			speed = other.speed + 8;
		}

		hip_firing = true;
	}
}
```

<!-- tabs:end -->

&nbsp;

## …trigger_effect_set_pause

`input_trigger_effect_set_pause(state, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                |
|---------------|--------|-------------------------------------------------------|
|`state`        |integer |Whether trigger effects should be paused for the player|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used   |

Pauses all trigger effects when `state` is `<false>`.  While paused, no new trigger effects are set.

#### **Example**

```gml
//Pause game
if ((game_paused == false) && input_check_pressed("pause"))
{
	audio_pause_all();  //Pause sound
	input_vibrate_set_pause(true); //Pause vibration events

	//Pause trigger effects
	input_trigger_effect_set_pause(true);

	game_paused = true;
}
```

<!-- tabs:end -->

&nbsp;

## …trigger_effect_get_pause

`input_trigger_effect_get_pause([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether trigger effects can proceed for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Draw trigger effect state enums
if (input_trigger_effect_get_pause())
{
	draw_text(x, y, "Triggers effects are paused!");
}
else
{
	draw_text(x, y,    "Left trigger state  #"  + string(input_trigger_effect_get_state(gp_shoulderlb));
	draw_text(x, y+10, "Right trigger state #" + string(input_trigger_effect_get_state(gp_shoulderrb));
}
```

<!-- tabs:end -->

&nbsp;

## …trigger_effect_set_strength

`input_trigger_effect_set_strength(strength, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                 |
|---------------|--------|--------------------------------------------------------|
|`strength`     |number  |Overall strength for all trigger effects for the player |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used    |

#### **Example**

```gml
//Set trigger effect strength to half
input_trigger_effect_set_strength(0.5);
```

<!-- tabs:end -->

&nbsp;

## …trigger_effect_get_strength

`input_trigger_effect_get_strength([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the overall strength for all trigger effects for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Draw trigger effect strength
draw_text(x, y, "Trigger effect strength: ", string(input_trigger_effect_get_strength()));
```

<!-- tabs:end -->
