# Plug-in: Trigger Effects

&nbsp;

Adaptive trigger effects are available for the DualSense gamepad on the PlayStation 5 console platform, as well as [Windows via Steamworks extension](Steamworks.md).

&nbsp;

## Config

`__InputTriggerEffectConfig()` holds macros that affect the general behavior of trigger effects. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for the plug-in to work.

|Name                                   |Typical Value|Purpose                                   |
|---------------------------------------|-------------|------------------------------------------|
|`INPUT_TRIGGER_EFFECT_DEFAULT_STRENGTH`|`1.0`        |The default haptic trigger effect strength|

&nbsp;

## …TriggerEffectOff

`InputTriggerEffectOff(trigger, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                               |
|---------------|--------|--------------------------------------------------------------------------------------|
|`trigger`      |integer |Trigger to set using GameMaker’s native constants (`gp_shoulderlb` or `gp_shoulderrb`)|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                                  |

#### **Example**

```gml
if (game_over)
{
	//Turn off trigger effects
	InputTriggerEffectOff(gp_shoulderlb);
	InputTriggerEffectOff(gp_shoulderrb);
}
```

<!-- tabs:end -->

&nbsp;

## …TriggerEffectFeedback

`InputTriggerEffectFeedback(trigger, position, strength, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

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
	InputTriggerEffectFeedback(gp_shoulderlb, 0.3, 0.5);

	in_sand = true;
}
```

<!-- tabs:end -->

&nbsp;

## …TriggerEffectVibration

`InputTriggerEffectVibration(trigger, position, amplitude, frequency, [playerIndex])`

<!-- tabs:start -->

**Returns:** N/A (`undefined`)

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
if ((using_gas == false) && InputCheck(INPUT_VERB.ACCELERATOR))
{
	audio_play_sound(snd_gas, 0, true);     //Loop sound effect
	speed = Inputvalue(INPUT_VERB.ACCELERATOR) * 5; //Set speed

	//Set vibration effect on right trigger
	InputTriggerEffectVibration(gp_shoulderrb, 0.2, 0.5, 0.2);

	using_gas = true;
}
```

<!-- tabs:end -->

&nbsp;

## …TriggerEffectWeapon

`InputTriggerEffectWeapon(trigger, start, end, strength, [playerIndex])`

<!-- tabs:start -->

**Returns:** N/A (`undefined`)

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
if ((using_pistol == false) && InputPressed(INPUT_VERB.EQUIP_PISTOL))
{
	//Play sound effect
	audio_play_sound(snd_unholster, 0, false);

	//Set trigger effect on right trigger
	InputTriggerEffectWeapon(gp_shoulderrb, 0.7, 0.85, 1);

	using_pistol = true;
}
```

<!-- tabs:end -->

&nbsp;

## …TriggerEffectGetState

`InputTriggerEffectGetState(trigger, [playerIndex])`

<!-- tabs:start -->

**Returns:** N/A (`undefined`)

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
	if ((InputTriggerEffectGetState(gp_shoulderrb) == INPUT_TRIGGER_STATE.EFFECT_OFF)
	||  (InputPressed(INPUT_VERB.FIRE))
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

## …TriggerEffectSetPause

`InputTriggerEffectSetPause(state, [playerIndex])`

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
if ((game_paused == false) && InputPressed(INPUT_VERB.PAUSE))
{
	audio_pause_all();  //Pause sound
	InputVibrateSetPause(true); //Pause vibration events

	//Pause trigger effects
	InputTriggerEffectSetpause(true);

	game_paused = true;
}
```

<!-- tabs:end -->

&nbsp;

## …TriggerEffectGetPause

`InputTriggerEffectGetPause([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether trigger effects can proceed for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Draw trigger effect state enums
if (InputTriggerEffectGetPause())
{
	draw_text(x, y, "Triggers effects are paused!");
}
else
{
	draw_text(x, y,    "Left trigger state  #"  + string(InputTriggerEffectGetState(gp_shoulderlb));
	draw_text(x, y+10, "Right trigger state #" + string(InputTriggerEffectGetState(gp_shoulderrb));
}
```

<!-- tabs:end -->

&nbsp;

## …TriggerEffectSetStrength

`InputTriggerEffectSetstrength(strength, [playerIndex])`

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
InputTriggerEffectSetstrength(0.5);
```

<!-- tabs:end -->

&nbsp;

## …TriggerEffectGetStrength

`InputTriggerEffectGetstrength([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the overall strength for all trigger effects for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Draw trigger effect strength
draw_text(x, y, "Trigger effect strength: ", string(InputTriggerEffectGetStrength()));
```

<!-- tabs:end -->

&nbsp;

## …TriggerEffectGetSupported

`InputTriggerEffectGetSupported([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether trigger effects are supported for the device assigned to a player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Draw gamepad trigger effect availability
draw_text(x, y, "Trigger effect support: ", string(InputTriggerEffectGetSupported()));
```

<!-- tabs:end -->