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

Resets accessibility data and player data for all players (see [`input_player_reset()`]()). This function will remove all non-default profiles from the player.

#### **Example**

```gml
//TODO lol
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

Outputs a string (or struct) that contains data that encompasses the Input's system. This can then be saved to a file etc. so that custom bindings can be restored in the future. This function serialises all player data (see [`input_player_export()`]()) as well as accessibility data.

It is recommended to only use bindings written on the same device as keyboard scancodes differ across device layouts and platforms.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …system_verify

`input_system_verify(stringOrStruct)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the provided data can be loaded by `input_system_import()` without error

|Name            |Datatype        |Purpose                                                                                                                 |
|----------------|----------------|------------------------------------------------------------------------------------------------------------------------|
|`stringOrStruct`|string or struct|JSON returned by [`input_system_export()`](Functions-(Exporting-and-Importing)#input_system_exportoutputstring-prettify)|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …system_import

`input_system_import(stringOrStruct)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name            |Datatype        |Purpose                                                                                                                 |
|----------------|----------------|------------------------------------------------------------------------------------------------------------------------|
|`stringOrStruct`|string or struct|JSON returned by [`input_system_export()`](Functions-(Exporting-and-Importing)#input_system_exportoutputstring-prettify)|

Reads JSON, either as a string or a struct, that contains Input system data. Such a JSON should be created using [`input_system_export()`](Functions-(Exporting-and-Importing)#input_system_exportoutputstring-prettify).

This function deserialises all player data (see [`input_player_export()`]()) as well as accessibility data. All player data is fully reset before loading in the new data - as such, this function **replaces** Input's system state rather than adding to it.

#### **Example**

```gml
//TODO lol
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

Clears the current profiles and bindings for the given player, resetting them to the defaults set up in [`INPUT_DEFAULT_PROFILES`](Configuration?id=profiles-and-bindings). This function will remove all non-default profiles from the player.

#### **Example**

```gml
//TODO lol
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
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …player_verify

`input_player_verify(stringOrStruct)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the provided data can be loaded by `input_player_import()` without error

|Name            |Datatype        |Purpose                                                                                                                             |
|----------------|----------------|------------------------------------------------------------------------------------------------------------------------------------|
|`stringOrStruct`|string or struct|JSON returned by [`input_player_export()`](Functions-(Exporting-and-Importing)#input_player_exportplayerindex-outputstring-prettify)|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …player_import

`input_player_import(stringOrStruct, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name            |Datatype        |Purpose                                                                                                                             |
|----------------|----------------|------------------------------------------------------------------------------------------------------------------------------------|
|`stringOrStruct`|string or struct|JSON returned by [`input_player_export()`](Functions-(Exporting-and-Importing)#input_player_exportplayerindex-outputstring-prettify)|
|`[playerIndex]` |integer         |Player to target. If not specified, player 0 is used                                                                                |

Reads JSON, either as a string or a struct, that contains player data (profiles, bindings, and axis thresholds). Such a JSON should be created using [`input_player_export()`](Functions-(Exporting-and-Importing)#input_player_exportplayerindex-outputstring-prettify).

All player data is fully reset before loading in the new data - as such, this function **replaces** player data rather than adding to it.

#### **Example**

```gml
//TODO lol
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
//TODO lol
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
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …profile_verify

`input_profile_verify(stringOrStruct)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the provided data can be loaded by `input_profile_import()` without error

|Name            |Datatype        |Purpose                                                                                                                                       |
|----------------|----------------|----------------------------------------------------------------------------------------------------------------------------------------------|
|`stringOrStruct`|string or struct|JSON returned by [`input_profile_export()`](Functions-(Exporting-and-Importing)?id=input_profile_importstringorstruct-profilename-playerindex)|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …profile_import

`input_profile_import(stringOrStruct, profileName, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name            |Datatype        |Purpose                                                                                                                                       |
|----------------|----------------|----------------------------------------------------------------------------------------------------------------------------------------------|
|`stringOrStruct`|string or struct|JSON returned by [`input_profile_export()`](Functions-(Exporting-and-Importing)?id=input_profile_importstringorstruct-profilename-playerindex)|
|`[playerIndex]` |integer         |Player to target. If not specified, player 0 is used                                                                                          |

Reads JSON, either as a string or a struct, that contains profile data (bindings and axis thresholds). Such a JSON should be created using [`input_profile_export()`](Functions-(Exporting-and-Importing)#input_profile_exportprofilename-playerindex-outputstring-prettify).

All player data is fully reset before loading in the new data - as such, this function **replaces** player data rather than adding to it.

#### **Example**

```gml
//TODO lol
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
//TODO lol
```

<!-- tabs:end -->
