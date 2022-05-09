# Functions (Sources)

&nbsp;

## `input_source_mode_set(mode)`

*Returns:* N/A (`undefined`)

|Name  |Datatype                          |Purpose                   |
|------|----------------------------------|--------------------------|
|`mode`|member of `INPUT_SOURCE_MODE` enum|The new source mode to set|

You can read more about source modes [here](Input-Sources?id=source-modes).

&nbsp;

## `input_source_mode_get()`

*Returns:* Member of `INPUT_SOURCE_MODE` enum

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

&nbsp;

## `input_source_detect_input(source)`

*Returns:* Boolean, whether new input is detected from this [source](Input-Sources) (and the source is unassigned)

|Name       |Datatype               |Purpose                               |
|-----------|-----------------------|--------------------------------------|
|`source`   |[Source](Input-Sources)|[Input source](Input-Sources) to check|

This function will return `false` if the source has been assigned to any player.

&nbsp;

## `input_source_detect_new()`

*Returns:* [Source](Input-Sources) that has presented **new** input and is unassigned, see below

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

If no source has presented new input this function will return `undefined`.

&nbsp;

## `input_source_set(source, [playerIndex], [autoProfile])`

*Returns:* N/A (`undefined`)

|Name           |Datatype               |Purpose                                                                                                                                       |
|---------------|-----------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
|`source`       |[Source](Input-Sources)|[Input source](Input-Sources) to check                                                                                                        |
|`[playerIndex]`|integer                |Player to target. If not specified, player 0 is used                                                                                          |
|`[autoProfile]`|boolean                |Whether to automatically change the player's profile based on [`INPUT_AUTO_PROFILE_FOR_KEYBOARD`](Configuration?id=profiles-and-bindings) etc.|

&nbsp;

## `input_source_add(source, [playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype               |Purpose                                             |
|---------------|-----------------------|----------------------------------------------------|
|`source`       |[Source](Input-Sources)|[Input source](Input-Sources) to check              |
|`[playerIndex]`|integer                |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_source_share(source, [playerIndex], [autoProfile])`

*Returns:* N/A (`undefined`)

|Name           |Datatype               |Purpose                                                                                                                                       |
|---------------|-----------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
|`source`       |[Source](Input-Sources)|[Input source](Input-Sources) to check                                                                                                        |
|`[playerIndex]`|integer                |Player to target. If not specified, player 0 is used                                                                                          |
|`[autoProfile]`|boolean                |Whether to automatically change the player's profile based on [`INPUT_AUTO_PROFILE_FOR_KEYBOARD`](Configuration?id=profiles-and-bindings) etc.|

&nbsp;

## `input_source_clear([playerIndex])`

*Returns:* N/A (`undefined`)

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_source_using(source, [playerIndex])`

*Returns:* Boolean, whether the given [source](Input-Sources) is unassigned

|Name           |Datatype               |Purpose                                             |
|---------------|-----------------------|----------------------------------------------------|
|`source`       |[Source](Input-Sources)|[Input source](Input-Sources) to check              |
|`[playerIndex]`|integer                |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_source_get_array([playerIndex])`

*Returns:* Array of [sources](Input-Sources) for the player

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

&nbsp;

## `input_source_is_available(source)`

*Returns:* Boolean, whether the given [source](Input-Sources) is unassigned

|Name    |Datatype               |Purpose                               |
|--------|-----------------------|--------------------------------------|
|`source`|[Source](Input-Sources)|[Input source](Input-Sources) to check|