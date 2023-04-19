# Functions (Sources)

&nbsp;

## …source_detect_input

`input_source_detect_input(source, [availableOnly])`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether new input is detected from this [source](Input-Sources)

|Name              |Datatype               |Purpose                                                                              |
|------------------|-----------------------|-------------------------------------------------------------------------------------|
|`source`          |[Source](Input-Sources)|[Input source](Input-Sources) to check                                               |
|`availableOnly`   |boolean                |Whether to include input from sources assinged to any player. False if not specified.|

#### **Example**

```gml
//TODO lol
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
//TODO lol
```

<!-- tabs:end -->

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
|`[autoProfile]`|boolean                |Whether to automatically change the player's profile based on [`INPUT_AUTO_PROFILE_FOR_KEYBOARD`](Configuration?id=profiles-and-bindings) etc.|
|`[exclusive]`  |boolean                |Whether all other players using this source should have that source removed. Defaults to `true`                                               |

#### **Example**

```gml
//TODO lol
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
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …source_share

`input_source_share(source, [playerIndex], [autoProfile], [exclusive])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name           |Datatype               |Purpose                                                                                                                                       |
|---------------|-----------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
|`source`       |[Source](Input-Sources)|[Input source](Input-Sources) to check                                                                                                        |
|`[playerIndex]`|integer                |Player to target. If not specified, player 0 is used                                                                                          |
|`[autoProfile]`|boolean                |Whether to automatically change the player's profile based on [`INPUT_AUTO_PROFILE_FOR_KEYBOARD`](Configuration?id=profiles-and-bindings) etc.|
|`[exclusive]`  |boolean                |Whether all other players using this source should have that source removed. Defaults to `true`                                               |

#### **Example**

```gml
//TODO lol
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
//TODO lol
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

This function allows `INPUT_KEYBOARD`, `INPUT_MOUSE` and `INPUT_GAMEPAD[n]` to passed into it to check for specific devices. You may also pass `INPUT_GAMEPAD` (no square brackets) to check if the player has been assigned any gamepad at all.

#### **Example**

```gml
//TODO lol
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
//TODO lol
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
//TODO lol
```

<!-- tabs:end -->
