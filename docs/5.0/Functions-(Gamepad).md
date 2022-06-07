# Functions (Gamepad)

&nbsp;

?> These functions are provided for convenience if you want to implement your own features using Input's implementation of the SDL gamepad mapping system. In general, [verbs](Verbs-and-Bindings) are the intended way to use Input and are preferred.

&nbsp;

## `input_gamepad_check(gamepadIndex, GMconstant)`

*Returns:* Boolean, if the button/axis is currently activated

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html). What physical input this actually checks is determined by Input's own SDL remapping system|

&nbsp;

## `input_gamepad_check_pressed(gamepadIndex, GMconstant)`

*Returns:* Boolean, if the button/axis is newly activated this frame

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html). What physical input this actually checks is determined by Input's own SDL remapping system|

&nbsp;

## `input_gamepad_check_released(gamepadIndex, GMconstant)`

*Returns:* Boolean, if the button/axis is newly deactivated this frame

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html). What physical input this actually checks is determined by Input's own SDL remapping system|

&nbsp;

## `input_gamepad_value(gamepadIndex, GMconstant)`

*Returns:* Real, the analogue value of the input (after applying SDL axis remapping)

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|
|`GMconstant`  |integer |Button or axis to check, using GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html). What physical input this actually checks is determined by Input's own SDL remapping system|

&nbsp;

## `input_gamepad_is_connected(gamepadIndex)`

*Returns:* Boolean, whether the given gamepad is connected (omitting [blocked devices](Controller-Mapping?id=controller-blacklist))

|Name          |Datatype|Purpose                                               |
|--------------|--------|-------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|

&nbsp;

## `input_gamepad_get_description(gamepadIndex)`

*Returns:* String, the name of the gamepad (after SDL remapping)

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|

&nbsp;

## `input_gamepad_get_type(gamepadIndex)`

*Returns:* String, the gamepad type (after SDL remapping)

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|

Returns the same values as [`input_player_gamepad_get_type()`](Functions-(Players)?id=input_player_get_gamepad_typeplayerindex-binding).

&nbsp;

## `input_gamepad_get_dpad_style(gamepadIndex)`

*Returns:* String, the style of the gamepad's dpad (after SDL remapping)

|Name          |Datatype                  |Purpose                                               |
|--------------|--------------------------|------------------------------------------------------|
|`gamepadIndex`|integer                   |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|

The following are valid strings this function may return besides `unknown`:

|Results    |Gamepad type                                    |Presentation example |
|-----------|------------------------------------------------|:-------------------:|
|`none`     |Switch (single Joy-Con)                         |*N/A*                |
|`arrows`   |Switch (handheld, Pro Controller, dual Joy-Cons)|<img alt="Arrows art example" width="150" src="https://i.imgur.com/V9qOstK.png">  |
|`segments` |PlayStation                                     |<img alt="Segments art example" width="150" src="https://i.imgur.com/Lmaya8O.png">|
|`disc`     |Xbox 360, Saturn                                |<img alt="Disc art example" width="150" src="https://i.imgur.com/IO0DjVQ.png">    |
|`cross`    |Default                                         |<img alt="Cross art example" width="150" src="https://i.imgur.com/b7f8Gnj.png">   |

*Example art courtesy https://thoseawesomeguys.com/prompts ([CC0](https://creativecommons.org/share-your-work/public-domain/cc0))*

&nbsp;

## `input_gamepad_get_map(gamepadIndex)`

*Returns:* Array of integers, the buttons and axes that are mapped for the given gamepad

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|

The returned array contains integers that correspond the GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html). These values indicate what buttons/axes have been mapped for the target gamepad.

If there is no gamepad connected for the given index, an empty array will be returned. If no mapping was applied to the gamepad (typically due to the gamepad not being covered by the SDL2 database) then all GameMaker constants are returned in the array.

&nbsp;

## `input_gamepad_constant_get_name(GMconstant)`

*Returns:* String, the human-readable name of the [virtual button/axis constant](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)

|Name          |Datatype|Purpose                                               |
|--------------|--------|------------------------------------------------------|
|`GMconstant`  |integer |Button or axis to stringify, using GameMaker's native [virtual button/axis constants](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/gamepad%20input/index.html)|

&nbsp;

## `input_gamepads_get_status()`

*Returns:* Struct, detailing the state of gamepad connection and disconnection

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
