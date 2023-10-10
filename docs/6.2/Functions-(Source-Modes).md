# Functions (Source Modes)

&nbsp;

## …source_mode_set

`input_source_mode_set(mode)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name  |Datatype                          |Purpose                   |
|------|----------------------------------|--------------------------|
|`mode`|member of `INPUT_SOURCE_MODE` enum|The new source mode to set|

You can read more about source modes [here](Input-Sources?id=source-modes).

#### **Example**

```gml
//Configures Input to share keyboard controls between two players

//Set the source mode to FIXED so we can control sources ourselves
input_source_mode_set(INPUT_SOURCE_MODE.FIXED);

//Share the keyboard across both players
input_source_share(INPUT_KEYBOARD, [0, 1]);

//Force the profiles to correctly distribute keys between both players
input_profile_set("share_keyboard_P1", 0);
input_profile_set("share_keyboard_P2", 1);
```

<!-- tabs:end -->

&nbsp;

## …source_mode_get

`input_source_mode_get()`

<!-- tabs:start -->

#### **Description**

**Returns:** Member of `INPUT_SOURCE_MODE` enum

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//Draw the current source mode to the screen when in debug mode
if (debug_mode)
{
	//Convert the source mode enum to a string
	var _string = "Unknown";
	switch(input_source_mode_get())
	{
		case INPUT_SOURCE_MODE.FIXED:       _string = "Fixed"; break;
		case INPUT_SOURCE_MODE.JOIN:        _string = "Join"; break;
		case INPUT_SOURCE_MODE.HOTSWAP:     _string = "Hotswap"; break;
		case INPUT_SOURCE_MODE.MIXED:       _string = "Mixed"; break;
		case INPUT_SOURCE_MODE.MULTIDEVICE: _string = "Multidevice"; break;
	}

	//Draw that string to the screen
	draw_text(x, y, _string);
}
```

<!-- tabs:end -->

&nbsp;

## …hotswap_params_set

`input_hotswap_params_set(callback)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name      |Datatype        |Purpose                                                                                                       |
|----------|----------------|--------------------------------------------------------------------------------------------------------------|
|`callback`|method or script|Method or script to execute when player 0 is given a new source in the `INPUT_SOURCE_MODE.HOTSWAP` source mode|

#### **Example**

```gml
input_hotswap_params_set(function()
{
	//Fetch the gamepad type when a hotswap event happens
	var _gamepad_type = input_player_get_gamepad_type();

	//If we have a matching custom profile...
	if (input_profile_exists(_gamepad_type))
	{
		//Then set it!
		input_profile_set(_gamepad_type);
	}
	else
	{
		//Otherwise, default to the automatically-set profile
		input_profile_auto();
	}
});
```

<!-- tabs:end -->

&nbsp;

## …hotswap_params_get

`input_hotswap_params_get()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the parameters currently set for `INPUT_SOURCE_MODE.HOTSWAP`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned by this function has the following member variables:

|Name       |Datatype        |Purpose                                                                                                       |
|-----------|----------------|--------------------------------------------------------------------------------------------------------------|
|`.callback`|method or script|Method or script to execute when player 0 is given a new source in the `INPUT_SOURCE_MODE.HOTSWAP` source mode|

<!-- tabs:end -->

&nbsp;

## …join_params_set

`input_join_params_set(min, max, leaveVerb, abortCallback, [dropDown])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype        |Purpose                                                                                                                                                           |
|---------------|----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`min`          |integer         |The minimum number of players that are needed to play in this particular game mode                                                                                |
|`max`          |integer         |The maximum number of players that can play this particular game mode                                                                                             |
|`leaveVerb`    |string          |The name of the verb that, when activated by a player, causes the player to have their sources cleared, "disconnecting" them from the game                        |
|`abortCallback`|method or script|Method or script to execute when the `INPUT_SOURCE_MODE.JOIN` source mode is aborted. Set to `undefined` to prevent players from aborting `INPUT_SOURCE_MODE.JOIN`|
|`[dropDown]`   |boolean         |Whether players should drop down into empty slots when other players disconnect                                                                                   |

#### **Example**

```gml
//If P1 selects the multiplayer option...
if (input_check_pressed("accept"))
{
	//Set up the .JOIN parameters
	input_join_params_set(2, 2, "cancel", function()
	{
		//Reset hotswap mode and return to the main menu
		input_source_mode_set(INPUT_SOURCE_MODE.HOTSWAP);
		room_goto(rm_main_menu);
	});

	//Start the .JOIN source mode so players can join the game
	input_source_mode_set(INPUT_SOURCE_MODE.JOIN);

	//Move to the next room
	room_goto(rm_multiplayer_join);
}
```

<!-- tabs:end -->

&nbsp;

## …join_params_get

`input_join_params_get()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the parameters currently set for `INPUT_SOURCE_MODE.JOIN`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned by this function has the following member functions:

|Name             |Datatype        |Purpose                                                                           |
|-----------------|----------------|----------------------------------------------------------------------------------|
|`.min_players`   |integer         |The minimum number of players that are needed to play in this particular game mode|
|`.max_players`   |integer         |The maximum number of players that can play this particular game mode             |
|`.leave_verb`    |string          |The name of the verb that, when activated by a player, causes the player to have their sources cleared, "disconnecting" them from the game|
|`.abort_callback`|method or script|Method or script to execute when the `INPUT_SOURCE_MODE.JOIN` source mode is aborted. Set to `undefined` to prevent players from aborting `INPUT_SOURCE_MODE.JOIN`|
|`.drop_down`     |boolean         |Whether players should drop down into empty slots when other players disconnect   |

<!-- tabs:end -->

&nbsp;

## …join_is_finished

`input_join_is_finished()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether enough players are connected to begin multiplayer gameplay

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

#### **Example**

```gml
//If all players have joined and P1 has pressed accepted...
if (input_join_is_finished() && input_pressed("accept"))
{
	//Stop .JOIN source mode and "lock" sources in place
	input_source_mode_set(INPUT_SOURCE_MODE.FIXED);

	//Go to the next screen
	room_goto(rm_choose_map);
}
```

<!-- tabs:end -->
