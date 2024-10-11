# Checkers

&nbsp;

## …Check

`InputCheck(verbIndex, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the verb is active

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`verbIndex`    |integer |Verb to target                                      |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns whether the verb is "active" i.e. a button is being held down, an analogue stick has been moved etc.  This is a boolean `true` or `false` state; to return an analogue value please use `InputValue()`.

#### **Example**

```gml
if (recoverTimer > 0)
{
	//If we're still recovering after shooting, tick down the timer
	recoverTimer--;
}
else
{
	//We're not recovering after a shot, allow shooting

	if (InputCheck(INPUT_VERB.SHOOT)) //If the "shoot" verb is active
	{
		//Create a bullet that matches our aiming direction
		with(instance_create_depth(x, y, depth-1, oBullet))
		{
			direction = other.direction;
		}

		//Set up a timer to delay the next shot
		recoverTimer = 8;
	}
}
```

<!-- tabs:end -->

&nbsp;

## …Pressed

`InputPressed(verbIndex, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the analogue value of the input (after applying the threshold)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`verbIndex`    |integer |Verb to target                                      |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns whether a verb has been newly actived in the most recent update loop.

#### **Example**

```gml
//If we've pressed the action verb and we're within reach of a sign
if (InputPressed(INPUT_VERB.ACTION) and (distance_to_object(oSign) < 20))
{
	//Create a pop-up message with the contents of the sign's text
	instance_create_layer(x, y, "UI", oPopUp,
	{
		text: instance_nearest(oSign).text
	});
}
```

<!-- tabs:end -->

&nbsp;

## …Released

`InputReleased(verbIndex, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the analogue value of the input (after applying the threshold)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`verbIndex`    |integer |Verb to target                                      |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns whether a verb has been newly deactivated in the most recent update loop.

#### **Example**

```gml
//Open the pause menu when the pause button is released
if (InputReleased(INPUT_VERB.PAUSE))
{
	instance_create_layer(x, y, "UI", oMenu);
}
```

<!-- tabs:end -->

&nbsp;

## …Value

`InputValue(verbIndex, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the analogue value of the input (after applying the threshold)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`verbIndex`    |integer |Verb to target                                      |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns the analogue value of a verb i.e. how far a trigger has been depressed, how far a thumbstick has been moved. A button will return either `0` or `1`.

#### **Example**

```gml
//Set our speed to a multiple of the value of the accelerate verb
//This allows for smooth acceleration based on e.g. a trigger position
speed = 7*InputValue(INPUT_VERB.ACCELERATE);
```

<!-- tabs:end -->

&nbsp;

## …X

`InputX(clusterIndex, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the x-coordinate of the vector represented by the sum of the verb values

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`clusterIndex` |integer |Cluster to target                                   |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns the x-coordinate of the vector represented by the sum of the verb values.

#### **Example**

```gml
//Move instance according to horizontal input 
x += InputX(INPUTER_CLUSTER.MOVE);
```

<!-- tabs:end -->

&nbsp;

## …Y

`InputY(clusterIndex, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the y-coordinate of the vector represented by the sum of the verb values

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`clusterIndex` |integer |Cluster to target                                   |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns the y-coordinate of the vector represented by the sum of the verb values.

#### **Example**

```gml
//Move instance according to horizontal input 
x += InputY(INPUTER_CLUSTER.MOVE);
```

<!-- tabs:end -->

&nbsp;

## …Direction

`InputDirection(default, clusterIndex, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the direction (in degrees) represented by the sum of the verb values

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`default`      |number  |Number to return if all verbs are inactive          |
|`clusterIndex` |integer |Cluster to target                                   |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns the direction of the vector represented by the sum of the verb values.

#### **Example**

```gml
//Set instance rotation to input direction, defaulting to the current value
image_angle = InputDirection(image_angle, INPUTER_CLUSTER.AIM);
```

<!-- tabs:end -->

&nbsp;

## …Distance

`InputDistance(clusterIndex, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Number, the length of the vector represented by the sum of the verb values

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`clusterIndex` |integer |Cluster to target                                   |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used|

Returns the length of the vector represented by the sum of the verb values.

#### **Example**

```gml
//Add motion in an instance's current direction with input distance for speed 
motion_add(direction, InputDistance(INPUTER_CLUSTER.MOVE));
```

<!-- tabs:end -->

&nbsp;

## …Repeat

`InputRepeat(clusterIndex, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the verb has been re-triggered by a repeater behaviour

|Name           |Datatype|Purpose                                                                    |
|---------------|--------|---------------------------------------------------------------------------|
|`verbIndex`    |integer |Verb to target                                                             |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used                       |
|`[delay]`      |intger  |Time between re-triggers. If not specified, `INPUT_REPEAT_DEFAULT_DELAY` is used   |
|`[predelay]`   |intger  |Time before the first re-trigger. If not specified, `INPUT_REPEAT_DEFAULT_PREDELAY` is used|

Returns a repeating boolean pulse whilst a verb is active. This is useful for rapidly scrolling through longs menu when using digital input. The `delay` and `predelay` parameters are measured in frames.

#### **Example**

```gml
//Delete a single file on a press, and delete multiple files if the verb is held
if (InputPressed(INPUT_VERB.DELETE) || InputRepeat(INPUT_VERB.DELETE))
{
    DeleteFile();
}
```

<!-- tabs:end -->

&nbsp;

## …OpposingPressed

`InputOpposingPressed(verbNegative, verbPositive, [playerIndex], [mostRecent])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the sign of the result of the negative and positive newly active verbs

|Name           |Datatype|Purpose                                                                    |
|---------------|--------|---------------------------------------------------------------------------|
|`verbNegative` |integer |Verb to check as the negative component                                    |
|`verbPositive` |integer |Verb to check as the positive component                                    |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used                       |
|`[mostRecent]` |boolean |Whether to use the most recent input instead of returning `false` when two verbs conflict. If not specified, `INPUT_OPPOSING_DEFAULT_MOST_RECENT` is used|

Returns the sign of the result of the negative and positive verbs when pressed. This means this function will only return `-1` or `+1` when a verb has been pressed during the previous update loop. If `mostRecent` is set to `true` then the most recently pressed verb is preferenced, otherwise `0` is returned if both verbs were pressed at the same time.

#### **Example**

```gml
//Vertically flip our sprite based on whether the "up" or "down" verbs have been pressed
var _sign = InputOpposingPressed("up", "down");
if (_sign != 0)
{
    image_yscale = _sign;
    instance_create_depth(x, y, depth-1, oSparks);
}
```

<!-- tabs:end -->

&nbsp;

## …OpposingRepeat

`InputOpposingRepeat(verbNegative, verbPositive, [playerIndex], [mostRecent])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the sign of the result of the negative and positive newly active verbs

|Name           |Datatype|Purpose                                                                                    |
|---------------|--------|-------------------------------------------------------------------------------------------|
|`verbNegative` |integer |Verb to check as the negative component                                                    |
|`verbPositive` |integer |Verb to check as the positive component                                                    |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used                                       |
|`[delay]`      |intger  |Time between re-triggers. If not specified, `INPUT_REPEAT_DEFAULT_DELAY` is used           |
|`[predelay]`   |intger  |Time before the first re-trigger. If not specified, `INPUT_REPEAT_DEFAULT_PREDELAY` is used|

Returns the sign of the result of the negative and positive active verbs on a repeating pulse. This function will return `0` between pulses and `-1` or `+1` on the pulse. If both verbs are active, this function will return `0`. The `delay` and `predelay` parameters are measured in frames.

#### **Example**

```gml
//Change option we've selected based on the "menu up" and "menu down" verbs
//If the player holds either down, the menu option will quickly scroll
option += InputOpposingPressed(INPUT_VERB.MENU_UP, INPUT_VERB.MENU_DOWN);
option += InputOpposingRepeat(INPUT_VERB.MENU_UP, INPUT_VERB.MENU_DOWN);

if (loop_menu)
{
    option = option mod option_count;
}
else
{
    option = clamp(option, 0, optionCount - 1);
}
```

<!-- tabs:end -->

&nbsp;

## …Opposing

`InputOpposing(verbNegative, verbPositive, [playerIndex], [mostRecent])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the sign of the result of the negative and positive newly active verbs

|Name           |Datatype|Purpose                                                                    |
|---------------|--------|---------------------------------------------------------------------------|
|`verbNegative` |integer |Verb to check as the negative component                                    |
|`verbPositive` |integer |Verb to check as the positive component                                    |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used                       |
|`[mostRecent]` |boolean |Whether to use the most recent input instead of returning `false` when two verbs conflict. If not specified, `INPUT_OPPOSING_DEFAULT_MOST_RECENT` is used|

Returns the sign of the result of the negative and positive active verbs. If `mostRecent` is set to `true` then the most recently pressed verb is preferenced, otherwise `0` is returned if both verbs are active.

#### **Example**

```gml
//Rotate the turret based on whether the left or right verb is active
//If the player holds both at the same time, the most recent verb takes priority
var _speed = 6;
direction += _speed*InputOpposing(INPUT_VERB.LEFT, INPUT_VERB.RIGHT, 0, true);
```

<!-- tabs:end -->

&nbsp;

## …LongPressed

`InputLongPressed(verbIndex, [playerIndex], [duration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the sign of the result of the negative and positive newly active verbs

|Name           |Datatype|Purpose                                                                     |
|---------------|--------|----------------------------------------------------------------------------|
|`verbIndex`    |integer |Verb to target                                                              |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used                        |
|`[duration]`   |number  |Hold time required for a long press. If not specified, player `INPUT_LONG_DEFALT_DELAY` is used|

Returns if a verb is newly considered a "long hold" based on the hold duration, measured in frames.

#### **Example**

```gml
//Crouch when we press the duck verb
if (InputPressed(INPUT_VERB.DUCK))
{
    sprite_index = sPlayerCrouch;
    max_speed = 4;
}
else if (InputLongPressed(INPUT_VERB.DUCK))
{
    //But if we hold the duck verb for longer then crawl
    sprite_index = sPlayerCrawl;
    max_speed = 2;
}
```

<!-- tabs:end -->

&nbsp;

## …Long

`InputLong(verbIndex, [playerIndex], [duration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the sign of the result of the negative and positive newly active verbs

|Name           |Datatype|Purpose                                                                     |
|---------------|--------|----------------------------------------------------------------------------|
|`verbIndex`    |integer |Verb to target                                                              |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used                        |
|`[duration]`   |number  |Hold time required for a long press. If not specified, player `INPUT_LONG_DEFALT_DELAY` is used|

Returns if a verb has been held for longer than the specified duration, measured in frames.

#### **Example**

```gml
if (InputLong(VERB_INPUT.PAUSE))
{
    //If we're showing the game off in DEMO_MODE then restart
    if (DEMO_MODE) game_restart();
}
```

<!-- tabs:end -->

&nbsp;

## …LongReleased

`InputLongReleased(verbIndex, [playerIndex], [duration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the sign of the result of the negative and positive newly active verbs

|Name           |Datatype|Purpose                                                                     |
|---------------|--------|----------------------------------------------------------------------------|
|`verbIndex`    |integer |Verb to target                                                              |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used                        |
|`[duration]`   |number  |Hold time required for a long press. If not specified, player `INPUT_LONG_DEFALT_DELAY` is used|

Returns if a verb has been released but previously was held for longer than the specified duration, measured in frames.

#### **Example**

```gml
if (InputLongReleased("attack"))
{
    //Perform a big flashy attack move if we charged up the attack
    sprite_index = sSpinAttack;
    damage = 23;
}
else if (InputReleased("attack"))
{
    //Otherwise swing weakly
    sprite_index = sStandardAttack;
    damage = 15;
}
```

<!-- tabs:end -->

&nbsp;

## …Duration

`InputDuration(verbIndex, [playerIndex], [duration])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the sign of the result of the negative and positive newly active verbs

|Name           |Datatype|Purpose                                                                     |
|---------------|--------|----------------------------------------------------------------------------|
|`verbIndex`    |integer |Verb to target                                                              |
|`[playerIndex]`|intger  |Player to target. If not specified, player 0 is used                        |

Returns how many frames have elapsed since the verb was last pressed. This function will return `0` on the first frame that the verb was pressed. This function will continue to return values even when the verb is not active.

#### **Example**

```gml
var _targetTime = 20;
var _width      = 40;
var _fill       =  0;

if (InputCheck(INPUT_VERB.BOW_ATTACK))
{
	//Determine how much of the bar to fill
	var _time = max(0, InputDuration(INPUT_VERB.BOW_ATTACK));
	var _fill = clamp(_time/_targetTime, 0, 1);
}

//Draw the bow charge bar's fill
draw_rectangle(x, y, x + _width*_fill, y + 10, false);

//Draw the outline of the charge bar
draw_rectangle(x, y, x + _width, y + 10, true);
```

<!-- tabs:end -->