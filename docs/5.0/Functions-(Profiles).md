# Functions (Profiles)

&nbsp;

The functions on this page relate to managing player [binding profiles](Profiles). The majority of functions on this page are of use only if you're keen on allowing players to create custom profiles in addition to the [default profiles](Profiles) that you've already defined.

If you'd like to know more about manipulating specific bindings, please see the [binding creator](Functions-(Binding-Creators)) and [binding access](Functions-(Binding-Access)) pages.

&nbsp;

## `input_profile_reset_bindings(profileName, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype           |Purpose                                             |
|---------------|-------------------|----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the [profile](Profiles) to reset            |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used|

This function replaces all bindings for the player's profile to the bindings found in the default profile (the profile defined in [`__input_config_profiles_and_bindings()`](Configuration?id=profiles-and-bindings)).

!> It is only possible to reset a default profile. Profiles added at runtime by `input_profile_create()` cannot be reset.

&nbsp;

## `input_profile_auto([playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

Sets the player's profile to the ["auto" profile"](Configuration?id=profiles-and-bindings) for the player's current [source](Input-Sources). For example, if the player is using a keyboard source then the player's profile will be set to `INPUT_AUTO_PROFILE_FOR_KEYBOARD`.

If the ["auto" profile"](Configuration?id=profiles-and-bindings) is set to `undefined` then no profile will be set.

&nbsp;

## `input_profile_set(profileName, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype           |Purpose                                              |
|---------------|-------------------|-----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the [profile](Profiles) to set for the player|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used |

Sets the player's profile either to a default or custom profile. If no profile with the same name is found then this function will throw an error.

&nbsp;

## `input_profile_get([playerIndex])`

*Returns:* String, the name of the profile being used by the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_profile_create(profileName, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype           |Purpose                                             |
|---------------|-------------------|----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the new [profile](Profiles) to create       |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used|

This function creates a custom profile for this specific player only. This might be useful for allowing players to define particular control schemes for different characters in a fighting game, or you could offer the ability to create different binding profiles for different kinds of gamepads.

If the profile already exists then this function will throw an error.

&nbsp;

## `input_profile_destroy(profileName, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype           |Purpose                                             |
|---------------|-------------------|----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the [profile](Profiles) to destroy          |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used|

Destroys the given player's profile with the same name, if one exists. If the player is using the profile that is being destroyed, their profile will be [automatically set]() based on the player's currently used source.

!> You cannot destroy [default profiles](Profiles) and trying to do so will throw an error.

&nbsp;

## `input_profile_exists(profileName, [playerIndex])`

*Returns:* Boolean, whether a profile with the given name exists for the given player

|Name           |Datatype           |Purpose                                             |
|---------------|-------------------|----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the [profile](Profiles) to check for        |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used|

This function will also return `true` for [default profile names](Profiles).

&nbsp;

## `input_profile_get_array([playerIndex])`

*Returns:* Array, the profiles that have been created for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

This function will return default profiles (as defined in [`__input_config_profiles_and_bindings()`](Configuration?id=profiles-and-bindings)) as well as custom profiles.