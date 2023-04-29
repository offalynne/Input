# Functions (Checkers)

&nbsp;

The functions on this page allow you to check the state of verbs for each player. These are the most common, bare minimum functions. You may also want to check verbs in the context of 2D movement or aiming, and those functions can be found on the [2D Checkers](https://www.jujuadams.com/Input/#/6.0/Functions-(2D-Checkers)) page. Input has a lot of ways of checking verbs that should cover many other use cases. You can find those functions on the [Advanced Checkers](Functions-(Advanced-Checkers)) and [Further Verb Functions](Functions-(Further-Verbs)) pages.

&nbsp;

## …check

`input_check(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is currently active

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are currently active for the player.

#### **Example**

```gml
if (recover_timer > 0)
{
	//If we're still recovering after shooting, tick down the timer
	recover_timer--;
}
else
{
	//We're not recovering after a shot, allow shooting

	if (input_check("shoot")) //If the "shoot" verb is active
	{
		//Create a bullet that matches our aiming direction
		with(instance_create_depth(x, y, depth-1, obj_bullet))
		{
			direction = other.direction;
		}

		//Set up a timer to delay the next shot
		recover_timer = 8;
	}
}
```

```gml
//We've been hit by an enemy attack
if (place_meeting(x, y, obj_enemy_attack))
{
	if (input_check("defend", 0, 4)) //If the "defend" verb was active within the last 4 frames
	{
		audio_sound_play(snd_player_parry, 0, false);
	}
	else
	{
		audio_sound_play(snd_player_hit 0, false);
		hp -= 10;
	}
}
```

<!-- tabs:end -->

&nbsp;

## …check_pressed

`input_check_pressed(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is newly activated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly activated this frame for the player.

#### **Example**

```gml
//If we've pressed the "action" verb and we're within reach of a sign
if (input_check_pressed("action") and (distance_to_object(obj_sign) < 20))
{
	//Create a pop-up message with the contents of the sign's text
	instance_create_layer(x, y, "UI", obj_popup,
	{
		text: instance_nearest(obj_sign).text
	});
}
```

```gml
//If we pressed jump within the last 2 frames and we're on the floor
//This makes it easier for the player to repeatedly hop
if (input_check_pressed("jump", 0, 2) and (place_meeting(x, y+1, obj_floor))
{
	vspeed = -6;
}
```

<!-- tabs:end -->

&nbsp;

## …check_released

`input_check_released(verb, [playerIndex], [bufferDuration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb is newly deactivated this frame

|Name              |Datatype                        |Purpose                                                                                                   |
|------------------|--------------------------------|----------------------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)               |
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                                      |
|`[bufferDuration]`|frames/milliseconds             |Input buffering duration, the units of which are determined by [`INPUT_TIMER_MILLISECONDS`](Configuration)|

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs are newly deactivated this frame for the player.

#### **Example**

```gml
//Open the pause menu when the pause button is released
if (input_check_released("pause"))
{
	instance_create_layer(x, y, "UI", obj_menu);
}
```

```gml
//If we relased the "accelerate" verb recently before braking then create some tyre smoke
if (input_check_released("accelerate", 0, 6) and input_check_pressed("brake"))
{
	instance_create_layer(x, y, "Particle_Effects", obj_tyre_smoke);
}
```

<!-- tabs:end -->

&nbsp;

## …value

`input_value(verb, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the analogue value of the input (after calculating the threshold)

|Name              |Datatype                        |Purpose                                                                                    |
|------------------|--------------------------------|-------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)|
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                       |

For on/off inputs, this function will return `0.0` or `1.0`.

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return the **sum** of the verb values for the player.

#### **Example**

```gml
//Set our speed to a multiple of the value of the "accelerate" verb
//This allows for smooth acceleration based on e.g. a trigger position
speed = 7*input_value("accelerate");
```

<!-- tabs:end -->

&nbsp;

## …is_analogue

`input_is_analogue(verb, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb was last triggered by an analogue input (a gamepad axis)

|Name              |Datatype                        |Purpose                                                                                    |
|------------------|--------------------------------|-------------------------------------------------------------------------------------------|
|`verb`            |[verb](Verbs-and-Bindings)/array|[Verb](Verbs-and-Bindings) to check, or an array of [verbs](Verbs-and-Bindings) (see below)|
|`[playerIndex]`   |integer                         |Player to target. If not specified, player 0 is used                                       |

If an array of [verbs](Verbs-and-Bindings) is provided for the `verb` parameter, this function will return `true` if **any** of the verbs was last triggered by an analogue input.

#### **Example**

```gml
if (input_is_analogue("power"))
{
	//If the player is using a trigger then derive the shot power directly
	shot_power = input_value("power");
}
else
{
	//Otherwise tween towards maximum shot power slowly
	//This gives the player a chance to get the right power
	var _speed  = 0.06;
	var _target = input_value("power");
	shot_power += clamp(_target - shot_power, -_speed, _speed);
}
```

<!-- tabs:end -->