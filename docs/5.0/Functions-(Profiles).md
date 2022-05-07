# Functions (Profiles)

&nbsp;

## `input_profile_create(profileName, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype           |Purpose                                             |
|---------------|-------------------|----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the new [profile](Profiles) to create       |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_profile_destroy(profileName, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype           |Purpose                                             |
|---------------|-------------------|----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the [profile](Profiles) to destroy          |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_profile_exists(profileName, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype           |Purpose                                             |
|---------------|-------------------|----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the [profile](Profiles) to check for        |
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_profile_get_array([playerIndex])`

*Returns:* Array, the profiles that have been created for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

This function will return default profiles (as defined in [`__input_config_profiles_and_bindings()`](Configuration?id=profiles-and-bindings)) as well as custom profiles.

&nbsp;

## `input_profile_set(profileName, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype           |Purpose                                              |
|---------------|-------------------|-----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the [profile](Profiles) to set for the player|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used |

&nbsp;

## `input_profile_get([playerIndex])`

*Returns:* String, the name of the profile

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_profile_auto([playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_profile_reset_bindings(profileName, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype           |Purpose                                              |
|---------------|-------------------|-----------------------------------------------------|
|`profileName`  |[profile](Profiles)|Name of the [profile](Profiles) to set for the player|
|`[playerIndex]`|integer            |Player to target. If not specified, player 0 is used |