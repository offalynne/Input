# Functions (Profiles)

&nbsp;

The functions on this page relate to managing player [binding profiles](Profiles). The majority of functions on this page are of use only if you're keen on allowing players to create custom profiles in addition to the [default profiles](Profiles) that you've already defined.

If you'd like to know more about manipulating specific bindings, please see the [binding creator](Functions-(Binding-Creators)) and [binding access](Functions-(Binding-Access)) pages.

&nbsp;

## …profile_create

`input_profile_create(profileName, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                             |
|---------------|-------------------|----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the new [profile](Profiles) to create       |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used|

This function creates a custom profile for this specific player only. This might be useful for allowing players to define particular control schemes for different characters in a fighting game, or you could offer the ability to create different binding profiles for different kinds of gamepads.

If the profile already exists then this function will throw an error.

#### **Example**

```gml
//If we've selected this option and we're using a gamepad...
if (input_check("accept") && input_source_using(INPUT_GAMEPAD))
{
	//Try to create a new profile based on the gamepad's type
	var _gamepad_type = input_player_get_gamepad_type();
	if (not input_profile_exists(_gamepad_type))
	{
		//Create a new profile
		input_profile_create(_gamepad_type);
        
		//Copy the default gamepad settings to the new profile
		input_profile_copy(0, INPUT_AUTO_PROFILE_FOR_GAMEPAD, 0, _gamepad_type);
	}
}
```

<!-- tabs:end -->

&nbsp;

## …profile_destroy

`input_profile_destroy(profileName, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                             |
|---------------|-------------------|----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the [profile](Profiles) to destroy          |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used|

Destroys the given player's profile with the same name, if one exists. If the player is using the profile that is being destroyed, their profile will be [automatically set](Config-Macros?id=profiles) based on the player's currently used source.

!> You cannot destroy [default profiles](Profiles) and trying to do so will throw an error.

#### **Example**

```gml
//If the player has long-pressed the cancel button...
if (input_check_long_pressed("cancel"))
{
	//Then destroy the currently selected custom profile
	input_profile_destroy(custom_profile_array[current_profile_index]);
}
```

<!-- tabs:end -->

&nbsp;

## …profile_exists

`input_profile_exists(profileName, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether a profile with the given name exists for the given player

|Name           |Datatype           |Purpose                                             |
|---------------|-------------------|----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the [profile](Profiles) to check for        |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used|

This function will also return `true` for [default profile names](Profiles).

#### **Example**

```gml
var _profile = custom_profile_array[current_profile_index];
if (input_profile_exists(_profile))
{
	//The profile exists, prompt the player to edit
	draw_text(x, y, "Edit profile");
}
else
{
	//No profile exists, prompt the player to set up a new one
	draw_text_color(x, y, "Set up new profile", c_red, c_red, c_red, c_red, 0.9);
}
```

<!-- tabs:end -->

&nbsp;

## …profile_get_array

`input_profile_get_array([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Array, the profiles that have been created for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

This function will return default profiles (as defined in [`__input_config_profiles_and_bindings()`](Config-Macros?id=profiles-and-bindings)) as well as custom profiles.

#### **Example**

```gml
//Grab all the profile names for the player
var _array = input_profile_get_array();

//Iterate over every profile name...
var _i = 0;
repeat(array_length(_array))
{
    //And draw a tab in the UI for it
	draw_ui_tab_for_profile(_array[_i]);
	++_i;
}
```

<!-- tabs:end -->

&nbsp;

## …profile_set

`input_profile_set(profileName, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                              |
|---------------|-------------------|-----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the [profile](Profiles) to set for the player|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used |

Sets the player's profile either to a default or custom profile. If no profile with the same name is found then this function will throw an error.

#### **Example**

```gml
//Use the "left" and "right" verb to scroll through custom profiles
var _delta = input_check_opposing_pressed("left", "right");

//Count the number of profiles
var _profile_count = array_length(custom_profile_array);

//Scroll through the custom profiles
//(We add _profile_count here to deal with a negative delta)
current_index = (current_profile_index + _delta + _profile_count) mod _profile_count;
```

<!-- tabs:end -->

&nbsp;

## …profile_get

`input_profile_get([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** String, the name of the profile being used by the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//Draw the current profile's name on the menu
draw_text(x, y, "Current Profile:");
draw_text(x, y + 24, input_profile_get());
```

<!-- tabs:end -->

&nbsp;

## …profile_auto

`input_profile_auto([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Sets the player's profile to the ["auto" profile"](Config-Macros?id=profiles-and-bindings) for the player's current [source](Input-Sources). For example, if the player is using a keyboard source then the player's profile will be set to `INPUT_AUTO_PROFILE_FOR_KEYBOARD`.

If the ["auto" profile"](Config-Macros?id=profiles-and-bindings) is set to `undefined` then no profile will be set.

#### **Example**

```gml
//If the player is using the TOUCH source...
if (input_source_using(INPUT_TOUCH))
{
	//Then we don't want a custom profile, so reset to using the auto profile
	input_profile_auto();
}
```

<!-- tabs:end -->

&nbsp;

## …profile_reset_bindings

`input_profile_reset_bindings(profileName, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype           |Purpose                                             |
|---------------|-------------------|----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the [profile](Profiles) to reset            |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used|

This function replaces all bindings for the player's profile to the bindings found in the default profile (the profile defined in [`__input_config_profiles_and_bindings()`](Config-Macros?id=profiles-and-bindings)).

!> It is only possible to reset a default profile. Profiles added at runtime by `input_profile_create()` cannot be reset.

#### **Example**

```gml
if (input_check_pressed("back"))
{
	//Reset the source mode to hotswapping
	input_source_mode_set(INPUT_SOURCE_MODE.HOTSWAP);

	//Foricbly disconnect P2
	input_source_clear(1);

	//Reset all the keyboard bindings for P2
	input_profile_reset_bindings("keyboard", 1);

	//Return to the main menu
	room_goto(rm_main_menu);
}
```

<!-- tabs:end -->