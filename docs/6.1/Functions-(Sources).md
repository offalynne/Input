# Functions (Sources)

&nbsp;

## …source_set

`input_source_set(source, [playerIndex], [autoProfile], [exclusive])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype               |Purpose                                                                                                                                       |
|---------------|-----------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
|`source`       |[Source](Input-Sources)|[Input source](Input-Sources) to check                                                                                                        |
|`[playerIndex]`|integer                |Player to target. If not specified, player 0 is used                                                                                          |
|`[autoProfile]`|boolean                |Whether to automatically change the player's profile based on [`INPUT_AUTO_PROFILE_FOR_KEYBOARD`](Config-Macros?id=profiles-and-bindings) etc.|
|`[exclusive]`  |boolean                |Whether all other players using this source should have that source removed. Defaults to `true`                                               |

#### **Example**

```gml
if (INPUT_ON_MOBILE)
{
	//Force touch input on mobile
	input_source_mode_set(INPUT_SOURCE_MODE.FIXED);
	input_source_set(INPUT_TOUCH);
}
```

<!-- tabs:end -->

&nbsp;

## …source_add

`input_source_add(source, [playerIndex], [exclusive])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype               |Purpose                                                                                        |
|---------------|-----------------------|-----------------------------------------------------------------------------------------------|
|`source`       |[Source](Input-Sources)|[Input source](Input-Sources) to check                                                         |
|`[playerIndex]`|integer                |Player to target. If not specified, player 0 is used                                           |
|`[exclusive]`  |boolean                |Whether all other players using this source should have that source removed. Defaults to `true`|

#### **Example**

```gml
//If we're in multidevice mode...
if (input_source_mode_get() == INPUT_SOURCE_MODE.MULTIDEVICE)
{
	//Check each gamepad...
	var _max = gamepad_get_device_count();
	for(var _gamepad = 0; _gamepad < _max; _gamepad++)
	{
		//To see if the start button has been pressed...
		if (input_gamepad_check_pressed(_gamepad, gp_start))
		{
			if (input_source_is_available(INPUT_GAMEPAD[_i]))
			{
				//And if so, add it as a source to the player
				input_source_add(INPUT_GAMEPAD[_gamepad]);

				//Show a notification to confirm this too
				show_notification("Gamepad \"" + string(input_gamepad_get_description()) + "\" added");
			}
		}
	}
}
```

<!-- tabs:end -->

&nbsp;

## …source_share

`input_source_share(source, arrayOfPlayerIndexes, [autoProfile], [exclusive])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name                  |Datatype               |Purpose                                                                                                                                                          |
|----------------------|-----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`source`              |[Source](Input-Sources)|[Input source](Input-Sources) to check                                                                                                                           |
|`arrayOfPlayerIndexes`|array                  |Array of player indexes to target                                                                                                                                |
|`[autoProfile]`       |boolean                |Whether to automatically change the player's profile based on [`INPUT_AUTO_PROFILE_FOR_KEYBOARD`](Config-Macros?id=profiles-and-bindings) etc. Defaults to `true`|
|`[exclusive]`         |boolean                |Whether all other players using this source should have that source removed. Defaults to `true`                                                                  |

#### **Example**

```gml
//Set up keyboard sharing for two players

//Clear out any sources these two players might have
input_source_clear(0);
input_source_clear(1);

//Share the keyboard between them
input_source_share(INPUT_KEYBOARD, [0, 1]);

//Set their profiles to the special sharing profiles
input_profile_set("keyboard_share_p1", 0);
input_profile_set("keyboard_share_p2", 1);
```

<!-- tabs:end -->

&nbsp;

## …source_clear

`input_source_clear([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Allow players to easily leave the game by holding the "pause" verb
if (input_check_long("pause", player_index))
{
	input_source_clear(player_index);
	show_modal("Player " + string(player_index) + "left the game")
}
```

<!-- tabs:end -->

&nbsp;

## …source_using

`input_source_using(source, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the given [source](Input-Sources) is being used by the player

|Name           |Datatype               |Purpose                                             |
|---------------|-----------------------|----------------------------------------------------|
|`source`       |[Source](Input-Sources)|[Input source](Input-Sources) to check              |
|`[playerIndex]`|integer                |Player to target. If not specified, player 0 is used|

This function allows `INPUT_KEYBOARD`, `INPUT_MOUSE` and `INPUT_GAMEPAD[n]`, `INPUT_TOUCH` passed to check for specific devices. You may also pass `INPUT_GAMEPAD` (no square brackets) to check if the player has been assigned any gamepad at all.

#### **Example**

```gml
if (input_source_using(INPUT_GAMEPAD))
{
	//If we're using a gamepad, derive our direction from the thumbstick (via verbs)
	image_angle = input_direction(image_angle, "aim left", "aim right", "aim up", "aim down");
}
else
{
	//Otherwise, aim at the mouse
	image_angle = point_direction(x, y, input_mouse_x(), input_mouse_y());
}
```

<!-- tabs:end -->

&nbsp;

## …source_get_array

`input_source_get_array([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of [sources](Input-Sources) for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Draw an icon for each one of the player's source
//This is helpful for players to visualise what devices they have assigned
var _y = y;

var _array = input_source_get_array();
for(var _i = 0; _i < array_length(_array); _i++)
{
	var _source = _array[_i];

	if (_source == INPUT_KEYBOARD)
	{
		draw_sprite(spr_keyboard_icon, 0, x, _y);
	}
	else if (_source == INPUT_MOUSE)
	{
		draw_sprite(spr_mouse_icon, 0, x, _y);
	}
	else if (_source == INPUT_TOUCH)
	{
		draw_sprite(spr_touch_icon, 0, x, _y);
	}
	else //Must be a gamepad
	{
		draw_sprite(spr_gamepad_icon, 0, x, _y);
	}

	_y += 34;
}
```

<!-- tabs:end -->

&nbsp;

## …source_is_available

`input_source_is_available(source)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the given [source](Input-Sources) is unassigned

|Name    |Datatype               |Purpose                               |
|--------|-----------------------|--------------------------------------|
|`source`|[Source](Input-Sources)|[Input source](Input-Sources) to check|

#### **Example**

```gml
var _y = y;

//If the keyboard source is available, draw an icon for it
if (input_source_is_available(INPUT_KEYBOARD))
{
	draw_sprite(spr_keyboard_icon, 0, x, _y);
	draw_text(x + 30, "Open!");
	_y += 42;
}

//Draw an icon for every available gamepad
var _max = gamepad_get_device_count();
for(var _gamepad = 0; _gamepad < _max; _gamepad++)
{
	if (input_source_is_available(INPUT_GAMEPAD[_gamepad]))
	{
		draw_sprite(spr_generic_gamepad_icon, 0, x, _y);
		draw_text(x + 30, "Open!");
		_y += 42;
	}
}
```

<!-- tabs:end -->

&nbsp;

## …source_detect_input

`input_source_detect_input(source, [availableOnly])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether new input is detected from this [source](Input-Sources)

|Name              |Datatype               |Purpose                                                                                            |
|------------------|-----------------------|---------------------------------------------------------------------------------------------------|
|`source`          |[Source](Input-Sources)|[Input source](Input-Sources) to check                                                             |
|`availableOnly`   |boolean                |Whether to only include input from sources assigned to a least one player. `false` if not specified|

#### **Example**

```gml
//Presume the player's source isn't active
var _active = false;

//Grab the sources that the player is using
var _array = input_source_get_array(player_index);
if (array_length(_array) > 0)
{
	//Detect input from the first source
	if (input_source_detect_input(_array[0]))
	{
		_active = true;
	}
}

//If the player's source is active, vibrate their icon
//Otherwise, draw their icon statically
var _x = x + (_active? irandom_range(-2, 2) : 0);
var _y = y + (_active? irandom_range(-2, 2) : 0);

draw_sprite(spr_icon, player_index, _x, _y);
```

<!-- tabs:end -->

&nbsp;

## …source_detect_new

`input_source_detect_new()`

<!-- tabs:start -->

#### **Description**

**Returns:** [Source](Input-Sources) that has presented **new** input and is unassigned, see below

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

If no source has presented new input this function will return `undefined`.

#### **Example**

```gml
//If we get some new input from a source...
var _new = input_source_detect_new();
if (_new != undefined)
{
	//And we don't already have a source assigned...
	if (array_length(input_source_get_array()) <= 0)
	{
		//Then set this new source as our current
		input_source_set(_new);
	}
}
```

<!-- tabs:end -->
