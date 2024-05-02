# Functions (Exporting and Importing)

&nbsp;

## …system_reset

`input_system_reset()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose |
|----|--------|--------|
|None|        |        |

Resets accessibility data and player data for all players (see `input_player_reset()`). This function will remove all non-default profiles from the player.

#### **Example**

```gml
if (input_check_long("accept"))
{
	//The player long-held "accept" to confirm savedata wipe
	savedata_reset();
	input_system_reset();
	room_goto(rm_main);
}
```

<!-- tabs:end -->

&nbsp;

## …system_export

`input_system_export([outputString], [prettify])`

<!-- tabs:start -->

#### **Description**

**Returns:** JSON, either as a string or struct

|Name            |Datatype|Purpose                                                                                                                                                                            |
|----------------|--------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`[outputString]`|boolean |Whether to return a string from this function. If set to `false`, JSON is returned instead as a struct. If not specified, a string is returned                                     |
|`[prettify]`    |boolean |Whether to format the output string so that it's easier for a human to read. If not specified, the string is not prettified. This argument is only relevant when returning a string|

Outputs a string (or struct) that contains data that encompasses the Input's system. This can then be saved to a file etc. so that custom bindings can be restored in the future. This function serialises all player data (see `input_player_export()`) as well as accessibility data.

It is recommended to only use bindings written on the same device as keyboard scancodes differ across device layouts and platforms.

#### **Example**

```gml
//Return to the settings menu, saving the controls as we go
if (input_check("back"))
{
	//Export a nice readable string
	var _string = input_system_export(true, true);

	//Save the string into a buffer
	var _buffer = buffer_create(1024, buffer_grow, 1);
	buffer_write(_buffer, buffer_text, _string);

	//Save the buffer to disk
	buffer_save_ext(_buffer, "controls.json", 0, buffer_tell(_buffer));

	//Clean up the buffer!
	buffer_delete(_buffer);

	//Then return to the settings page
	room_goto(rm_settings);
}
```

<!-- tabs:end -->

&nbsp;

## …system_verify

`input_system_verify(stringOrStruct, [returnError])`

<!-- tabs:start -->

#### **Description**

**Returns:** Varies, see below

|Name            |Datatype        |Purpose                                                                                                       |
|----------------|----------------|--------------------------------------------------------------------------------------------------------------|
|`stringOrStruct`|string or struct|JSON returned by `input_system_export()`                                                                      |
|`returnError`   |boolean         |Whether to return the relevant error struct (if it exists). This argument defaults to `false` if not specified|

If `returnError` is set to `false`, this function will return a boolean, whether the provided data can be loaded by `input_system_import()` without error.

If `returnError` is set to `true`, this function will return `undefined` if the system passed verification. If the system _fails_ verification then this function will return a struct containing error data.

#### **Example**

```gml
if (not input_system_verify(_incoming_data))
{
	//The ice we skate is getting pretty thin
	//(We failed to validate the controls so force a reset of the control scheme)
	show_notification("Couldn't load control settings!");
	input_system_reset();
}
else
{
	//The water's getting warm so you might as well swim
	input_system_import(_incoming_data);
}
```

<!-- tabs:end -->

&nbsp;

## …system_import

`input_system_import(stringOrStruct)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name            |Datatype        |Purpose                                 |
|----------------|----------------|----------------------------------------|
|`stringOrStruct`|string or struct|JSON returned by `input_system_export()`|

Reads JSON, either as a string or a struct, that contains Input system data. Such a JSON should be created using `input_system_export()`.

This function deserialises all player data (see `input_player_export()` as well as accessibility data. All player data is fully reset before loading in the new data - as such, this function **replaces** Input's system state rather than adding to it.

#### **Example**

```gml
//Load up the Input data if it exists
if (file_exists("controls.json"))
{
	//Load up a buffer and try to read Input data from it as a string
	var _buffer = buffer_load("controls.json");
	var _incoming_data = buffer_read(_buffer, buffer_text);
	buffer_delete(_buffer); //Always clean up your memory!

	if (not input_system_verify(_incoming_data))
	{
		//We failed to validate the controls so force a reset of the control scheme
		show_notification("Couldn't load control settings!");
	}
	else
	{
		//Otherwise load as planned
		input_system_import(_incoming_data);
	}
}

//Then proceed to the main menu
room_goto(rm_main_menu);
```

<!-- tabs:end -->

&nbsp;

## …player_reset

`input_player_reset([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Clears the current profiles and bindings for the given player, resetting them to the defaults set up in `__input_config_verbs()`. This function will remove all non-default profiles from the player.

#### **Example**

```gml
if (input_check_long("accept", player_index))
{
	//Player long-held "accept" to confirm, wipe their custom bindings
	input_player_reset(player_index);
}
```

<!-- tabs:end -->

&nbsp;

## …player_export

`input_player_export([playerIndex], [outputString], [prettify])`

<!-- tabs:start -->

#### **Description**

**Returns:** JSON, either as a string or struct

|Name            |Datatype|Purpose                                                                                                                                                                            |
|----------------|--------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`[playerIndex]` |integer |Player to target. If not specified, player 0 is used                                                                                                                               |
|`[outputString]`|boolean |Whether to return a string from this function. If set to `false`, JSON is returned instead as a struct. If not specified, a string is returned                                     |
|`[prettify]`    |boolean |Whether to format the output string so that it's easier for a human to read. If not specified, the string is not prettified. This argument is only relevant when returning a string|

Outputs a string (or struct) that contains data that contains profile, binding, and axis threshold data for the given player. This can then be saved to a file etc. so that custom bindings can be restored in the future.

It is recommended to only use bindings written on the same device as keyboard scancodes differ across device layouts and platforms.

#### **Example**

```gml
//Fetch the player-specific settings from Input
var _player_data = input_player_export(player_index, false);

//Get the account name for this player
var _account_name = global.account_name[player_index];

//Get the struct associated with this account
var _account_struct = global.account_data[$ _account_name];

//Store the Input data in that account struct
_current_account.player_controls = _player_data;

//And then save out the updated account data to disk
account_savedata_save(player_index);
```

<!-- tabs:end -->

&nbsp;

## …player_verify

`input_player_verify(stringOrStruct)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the provided data can be loaded by `input_player_import()` without error

|Name            |Datatype        |Purpose                                 |
|----------------|----------------|----------------------------------------|
|`stringOrStruct`|string or struct|JSON returned by `input_player_export()`|

#### **Example**

```gml
if (not input_player_verify(_incoming_data))
{
	//We've gotten invalid data for some reason, force a reset
	input_player_reset();
	show_notification("Couldn't load control settings!");
}
else
{
	//Otherwise load as planned
	input_player_import(_incoming_data);
}
```

<!-- tabs:end -->

&nbsp;

## …player_import

`input_player_import(stringOrStruct, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name            |Datatype        |Purpose                                 |
|----------------|----------------|----------------------------------------|
|`stringOrStruct`|string or struct|JSON returned by `input_player_export()`|
|`[playerIndex]` |integer         |Player to target. If not specified, player 0 is used|

Reads JSON, either as a string or a struct, that contains player data (profiles, bindings, and axis thresholds). Such a JSON should be created using `input_player_export()`.

All player data is fully reset before loading in the new data - as such, this function **replaces** player data rather than adding to it.

#### **Example**

```gml
if (input_check_pressed("accept"))
{
	//Set the account name for this player
	global.account_name[player_index] = selected_account;

	//Load the data for this account from disk
	account_savedata_load(player_index);

	//Get the struct associated with this account
	var _account_struct = global.account_data[$ _account_name];

	//Fetch the Input-related data from the account struct
	var _incoming_data = _account_struct.player_controls;

	if (not input_player_verify(_incoming_data))
	{
		//We've gotten invalid data for some reason, force a reset
		input_player_reset(player_index);
		show_notification("Couldn't load control settings!");
	}
	else
	{
		//Otherwise load as planned
		input_player_import(_incoming_data, player_index);
	}
}
```

<!-- tabs:end -->

&nbsp;

## …player_copy

`input_player_copy(playerIndexSrc, playerIndexDst)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name            |Datatype|Purpose                     |
|----------------|--------|----------------------------|
|`playerIndexSrc`|integer |Player to copy bindings from|
|`playerIndexDst`|integer |Player to copy bindings to  |

Duplicates one player's profiles, bindings, and axis thresholds and copies them over to another player.

#### **Example**

```gml
if (input_check_long("special"))
{
	//Player long-held "special" to indicate they want to play as a guest

	//Set the account name for this player
	global.account_name[player_index] = "Doppel-" + global.account_name[0];

	//Duplicate the settings for Input from player 0 to the new player
	input_player_copy(0, player_index);
}
```

<!-- tabs:end -->

&nbsp;

## …profile_export

`input_profile_export(profileName, [playerIndex], [outputString], [prettify])`

<!-- tabs:start -->

#### **Description**

**Returns:** JSON, either as a string or struct

|Name            |Datatype|Purpose                                                                                                                                                                            |
|----------------|--------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`[playerIndex]` |integer |Player to target. If not specified, player 0 is used                                                                                                                               |
|`[outputString]`|boolean |Whether to return a string from this function. If set to `false`, JSON is returned instead as a struct. If not specified, a string is returned                                     |
|`[prettify]`    |boolean |Whether to format the output string so that it's easier for a human to read. If not specified, the string is not prettified. This argument is only relevant when returning a string|

Outputs a string (or struct) that contains data that contains binding and axis threshold data for the given profile. This can then be saved to a file etc. so that custom bindings for a specific profile can be restored in the future.

It is recommended to only use bindings written on the same device as keyboard scancodes differ across device layouts and platforms.

#### **Example**

```gml
//Export this profile's bindings to a string
var _string = input_profile_export(input_profile_get(), true, false);

//Convert the string into something a bit easier to copy-paste around
_string = "#" + base64_encode(_string) + "#";

//Drop the new string onto the clipboard
clipboard_set_text(_string);

//Tell the player what we did!
show_notification("Copied control scheme to the clipboard!");
```

<!-- tabs:end -->

&nbsp;

## …profile_verify

`input_profile_verify(stringOrStruct, profileName, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the provided data can be loaded by `input_profile_import()` without error

|Name            |Datatype        |Purpose                                  |
|----------------|----------------|-----------------------------------------|
|`stringOrStruct`|string or struct|JSON returned by `input_profile_export()`|
|`profileNameDst`|integer         |Profile to verify loading bindings to    |
|`[playerIndex]` |integer         |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
if (not input_profile_verify(_incoming_data, "keyboard_and_mouse"))
{
	//Failed to verify the incoming profile
	//Don't reset the player's settings though, that would be irritating
	show_notification("Couldn't read new control scheme");
}
else
{
	//Good data! Load as planned
	input_profile_import(_incoming_data, "keyboard_and_mouse");
	show_notification("Loaded new control scheme");
}
```

<!-- tabs:end -->

&nbsp;

## …profile_import

`input_profile_import(stringOrStruct, profileName, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name            |Datatype        |Purpose                                  |
|----------------|----------------|-----------------------------------------|
|`stringOrStruct`|string or struct|JSON returned by `input_profile_export()`|
|`profileNameDst`|integer         |Profile to load bindings to              |
|`[playerIndex]` |integer         |Player to target. If not specified, player 0 is used|

Reads JSON, either as a string or a struct, that contains profile data (bindings and axis thresholds). Such a JSON should be created using `input_profile_export()`.

All player data is fully reset before loading in the new data - as such, this function **replaces** player data rather than adding to it.

#### **Example**

```gml
var _incoming_data = clipboard_get_text();

//Check to see if we have both hashes, one at each end
if ((string_char_at(_incoming_data, 1) != "#")
or  (string_char_at(_incoming_data, string_length(_incoming_data)) != "#"))
{
	show_notification("Couldn't read new control scheme");
}
else
{
	//Trim off the hashes then try to load using Input
	_incoming_data = string_copy(_incoming_data, 2, string_length(_incoming_data) - 2);

	if (not input_profile_verify(_incoming_data, "gamepad"))
	{
		//Failed to verify the incoming profile
		//Don't reset the player's settings though, that would be irritating
		show_notification("Couldn't read new control scheme");
	}
	else
	{
		//Good data! Load as planned
		input_profile_import(_incoming_data, "gamepad");
		show_notification("Loaded new control scheme");
	}
}
```

<!-- tabs:end -->

&nbsp;

## …profile_copy

`input_profile_copy(playerIndexSrc, profileNameSrc, playerIndexDst, profileNameDst)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name            |Datatype|Purpose                      |
|----------------|--------|-----------------------------|
|`playerIndexSrc`|integer |Player to copy bindings from |
|`profileNameSrc`|integer |Profile to copy bindings from|
|`playerIndexDst`|integer |Player to copy bindings to   |
|`profileNameDst`|integer |Profile to copy bindings to  |

Duplicates one player's profile and copies them over to another player.

#### **Example**

```gml
//Create a new custom profile and copy over the default gamepad bindings
if (input_check_pressed("accept"))
{
	input_profile_create(new_custom_profile);
	input_profile_copy(0, INPUT_AUTO_PROFILE_GAMEPAD, 0, new_custom_profile);
}
```

<!-- tabs:end -->
