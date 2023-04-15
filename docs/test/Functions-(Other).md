# Functions (Other)

&nbsp;

## …tick

`input_tick()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

!> If you're using Input 5 on versions of GameMaker **before** 2022.5 (May 2022) then you'll need to call `input_tick()` in the Begin Step event of a persistent instance. This function handles all things Input behind the scenes, it is important to call `input_tick()` once (and only once) each step of your game. A good way to do this is by making `obj_input_manager` [persistent](https://manual.yoyogames.com/#t=The_Asset_Editors%2FObjects.htm), and placing one instance in your first room.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …axis_threshold_set

`input_axis_threshold_set(axis, min, max, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** A struct with two member variables, `mini` and `maxi`, containing the minimum and maximum thresholds

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`axis`         |real    |[Gamepad axis](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to target|
|`min`          |real    |Minimum threshold value                             |
|`max`          |real    |Maximum threshold value                             |
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …axis_threshold_get

`input_axis_threshold_get(axis, [playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** A struct with two member variables, `.mini` and `.maxi`, containing the minimum and maximum thresholds

|Name           |Datatype|Purpose                                             |
|---------------|--------|----------------------------------------------------|
|`axis`         |real    |[Gamepad axis](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm) to target|
|`[playerIndex]`|integer |Player to target. If not specified, player 0 is used|

If the axis does not have a threshold definition (as set by `input_axis_threshold_set()`) when this function is called then a new definition is created using `INPUT_DEFAULT_MIN_THRESHOLD` and `INPUT_DEFAULT_MAX_THRESHOLD`.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …clear_momentary

`input_clear_momentary(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose       |
|-------|--------|--------------|
|`state`|boolean |Whether to clear all momentary input|

Clears momentary (pressed/released) input and connection checkers. This covers verbs as well as keyboard/mouse/gamepad direct checkers. Useful for [fixed timestep patterns](https://gafferongames.com/post/fix_your_timestep/) where momentary checks should only be handled for one cycle (for example [iota](https://github.com/JujuAdams/iota)).

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;


## …ignore_key_add

`input_ignore_key_add(key)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name |Datatype|Purpose                                                                                                                 |
|-----|--------|------------------------------------------------------------------------------------------------------------------------|
|`key`|integer |[Key](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FKeyboard_Input%252FKeyboard_Input.htm) to add|

Adds a keyboard key to be ignored by Input. This will affect binding detection, but any existing bindings set up to scan for this key will still work to prevent players from getting themselves into a position where the game doesn't work (!).

**Please note** that the list of ignored keys may already be populated depending on what value is set for `INPUT_IGNORE_RESERVED_KEYS_LEVEL`. Please read the [`Configuration`](Configuration) page for more information.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …ignore_key_remove

`input_ignore_key_remove(key)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name |Datatype|Purpose                                                                                                                    |
|-----|--------|---------------------------------------------------------------------------------------------------------------------------|
|`key`|integer |[Key](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FKeyboard_Input%252FKeyboard_Input.htm) to remove|

Removes a keyboard key from the ignore list.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …window_has_focus

`input_window_has_focus()`

<!-- tabs:start -->

#### **Description**

**Returns:** Boolean, whether the game window is in focus

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |

!> This function only works on desktop (Windows, MacOS, Linux) platforms.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->
