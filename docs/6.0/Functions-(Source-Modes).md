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

You can read more about source modes [here](Input-Sources?id=source-modes)..|

#### **Example**

```gml
//TODO lol
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
|None|        |       |.|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …hotswap_params_set

`input_hotswap_params_set(callback)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name      |Datatype        |Purpose|
|----------|----------------|-------|
|`callback`|method or script|       |.|

#### **Example**

```gml
//TODO lol
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

The struct returned by this function has the following member functions:

|Name       |Datatype        |Purpose                                                                                                       |
|-----------|----------------|--------------------------------------------------------------------------------------------------------------|
|`.callback`|method or script|Method or script to execute when player 0 is given a new source in the `INPUT_SOURCE_MODE.HOTSWAP` source mode|.|

#### **Example**

```gml
//TODO lol
```

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
|`[allowAbort]` |boolean         |Whether players can abort the `JOIN` source mode by activating the "leave" verb. Defaults to `true`                                                               |.|

#### **Example**

```gml
//TODO lol
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
|`.leave_verb`    |string          |                                                                                  |
|`.abort_callback`|method or script|                                                                                  |
|`.drop_down`     |boolean         |Whether players should drop down into empty slots when other players disconnect   |.|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …join_is_finished

`input_join_is_finished()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether enough players are connected to begin multiplayer gameplay

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |.|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->
