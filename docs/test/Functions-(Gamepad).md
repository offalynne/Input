# Functions (Gamepad)

&nbsp;

?> These functions are provided for convenience if you want to implement your own features using Input's implementation of the SDL gamepad mapping system. In general, [verbs](Verbs-and-Bindings) are the intended way to use Input and are preferred.

&nbsp;

## …gamepad_check

`input_gamepad_check(gamepadIndex, GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the button/axis is currently activated

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm). What physical input this actually checks is determined by Input's own SDL remapping system|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …gamepad_check_pressed

`input_gamepad_check_pressed(gamepadIndex, GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the button/axis is newly activated this frame

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm). What physical input this actually checks is determined by Input's own SDL remapping system|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …gamepad_check_released

`input_gamepad_check_released(gamepadIndex, GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the button/axis is newly deactivated this frame

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm). What physical input this actually checks is determined by Input's own SDL remapping system|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …gamepad_value

`input_gamepad_value(gamepadIndex, GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, the analogue value of the input (after applying SDL axis remapping)

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm). What physical input this actually checks is determined by Input's own SDL remapping system|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …gamepad_delta

`input_gamepad_delta(gamepadIndex, GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** Real, difference in value between this frame and the previous frame for the given button/axis

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm). What physical input this actually checks is determined by Input's own SDL remapping system|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …gamepad_is_axis

`input_gamepad_is_axis(gamepadIndex, GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, if the given `gp_*` constant is mapped as an analogue input

|Name          |Datatype|Purpose                                               |
|--------------|--------|-------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …gamepad_is_connected

`input_gamepad_is_connected(gamepadIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the given gamepad is connected (omitting [blocked devices](Controller-Mapping?id=controller-blacklist))

|Name          |Datatype|Purpose                                               |
|--------------|--------|-------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …gamepad_get_description

`input_gamepad_get_description(gamepadIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** String, the name of the gamepad (after SDL remapping)

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …gamepad_get_type

`input_gamepad_get_type(gamepadIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** String, the gamepad type (after SDL remapping)

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

Returns the same values as [`input_player_gamepad_get_type()`](Functions-(Players)?id=input_player_get_gamepad_typeplayerindex-binding).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …gamepad_get_map

`input_gamepad_get_map(gamepadIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of integers, the buttons and axes that are mapped for the given gamepad

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

The returned array contains integers that correspond the GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm). These values indicate what buttons/axes have been mapped for the target gamepad.

If there is no gamepad connected for the given index, an empty array will be returned. If no mapping was applied to the gamepad (typically due to the gamepad not being covered by the SDL2 database) then all GameMaker constants are returned in the array.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …gamepad_constant_get_name

`input_gamepad_constant_get_name(GMconstant)`

<!-- tabs:start -->

#### **Description**

**Returns:** String, the human-readable name of the [virtual button/axis constant](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`GMconstant`  |integer |Button or axis to stringify, using GameMaker's native [virtual button/axis constants](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …gamepads_get_status

`input_gamepads_get_status()`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, detailing the state of gamepad connection and disconnection

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

This function returns a struct that describes the state of each gamepad, following the formatting below.

!> Do not edit the struct that this function returns! You may encounter undefined behaviour if you do.

```
{
    any_changes: <boolean that indicates whether anything has changed at all>
    new_connections: [
        <array of gamepad indexes that are newly connected this step>
    ],
    new_disconnections: [
        <array of gamepad indexes that are newly disconnected this step>
    ],
    gamepads: [
        <array of values from the INPUT_STATUS enum, one for each gamepad available on this platform>
    ],
}
```

The `INPUT_STATUS` enum contains the following members:

|Name                 |Purpose                                          |
|---------------------|-------------------------------------------------|
|`.NEWLY_DISCONNECTED`|Gamepad has been disconnected this frame         |
|`.DISCONNECTED`      |Gamepad is disconnected (for at least two frames)|
|`.NEWLY_CONNECTED`   |Gamepad has been connected this frame            |
|`.CONNECTED`         |Gamepad is connected (for at least two frames)   |

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->