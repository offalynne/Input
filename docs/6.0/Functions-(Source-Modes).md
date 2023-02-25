# Functions (Source Modes)

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

## `input_hotswap_params_set(callback)`

*Returns:* N/A (`undefined`)

|Name      |Datatype        |Purpose|
|----------|----------------|-------|
|`callback`|method or script|       |

&nbsp;

## `input_hotswap_params_get()`

*Returns:* Struct, the parameters currently set for `INPUT_SOURCE_MODE.HOTSWAP`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned by this function has the following member functions:

|Name       |Datatype        |Purpose|
|-----------|----------------|-------|
|`.callback`|method or script|       |

&nbsp;

## `input_multiplayer_params_set(min, max, leaveVerb, abortCallback, [dropDown])`

*Returns:* N/A (`undefined`)

|Name           |Datatype        |Purpose                                                                                            |
|---------------|----------------|---------------------------------------------------------------------------------------------------|
|`min`          |integer         |The minimum number of players that are needed to play in this particular game mode                 |
|`max`          |integer         |The maximum number of players that can play this particular game mode                              |
|`leaveVerb`    |string          |                                                                                                   |
|`abortCallback`|method or script|                                                                                                   |
|`[allowAbort]` |boolean         |Whether players can abort the `JOIN` source mode by activating the "leave" verb. Defaults to `true`|

&nbsp;

## `input_multiplayer_params_get()`

*Returns:* Struct, the parameters currently set for `INPUT_SOURCE_MODE.JOIN`

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

The struct returned by this function has the following member functions:

|Name             |Datatype        |Purpose                                                                           |
|-----------------|----------------|----------------------------------------------------------------------------------|
|`.min_players`   |integer         |The minimum number of players that are needed to play in this particular game mode|
|`.max_players`   |integer         |The maximum number of players that can play this particular game mode             |
|`.leave_verb`    |string          |                                                                                  |
|`.abort_callback`|method or script|                                                                                  |
|`.drop_down`     |boolean         |Whether players should drop down into empty slots when other players disconnect   |

&nbsp;

## `input_multiplayer_is_finished()`

*Returns:* Boolean, whether enough players are connected to begin multiplayer gameplay

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |
