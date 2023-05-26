# Functions (Other)

&nbsp;

## …clear_momentary

`input_clear_momentary(state)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name   |Datatype|Purpose                             |
|-------|--------|------------------------------------|
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

|Name |Datatype|Purpose                                                                                                                                       |
|-----|--------|----------------------------------------------------------------------------------------------------------------------------------------------|
|`key`|integer |[Key](https://manual.yoyogames.com/#t=GameMaker_Language%252FGML_Reference%252FGame_Input%252FKeyboard_Input%252FKeyboard_Input.htm) to remove|

Removes a keyboard key from the ignore list.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …debug_player_input

`input_debug_player_input([playerIndex])`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of bindings

|Name         |Datatype|Purpose                                             |
|-------------|--------|----------------------------------------------------|
|`playerIndex`|integer |Player to target. If not specified, player 0 is used|

Returns an array that contains bindings for each keyboard key, mouse button, and gamepad button/axis that the player is pressing. This function uses the same ignore/allow/source filter behaviour as the binding scan feature (see `input_binding_scan_params_set()`).

!> This function is provided for debug use only and does very little error checking. Use `input_binding_scan_start()` for player-facing binding scan.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->

&nbsp;

## …debug_all_input

`input_debug_all_input()`

<!-- tabs:start -->

#### **Description**

**Returns:** Array of bindings

|Name            |Datatype|Purpose                                                                                                                                                    |
|----------------|--------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
|`[ignoreArray]` |array   |Array of keyboard keys (`vk_*`, `"A"`), mouse buttons (`mb_*`), or gamepad constants (`gp_*`) to explicitly disallow being scanned                         |
|`[allowArray]`  |array   |Array of keyboard keys (`vk_*`, `"A"`), mouse buttons (`mb_*`), or gamepad constants (`gp_*`) to explicitly scan for, excluding all other possible bindings|
|`[sourceFilter]`|array   |Array of sources to scan. If not specified, all possible sources will be scanned                                                                           |

Returns an array that contains bindings for each keyboard key, mouse button, and gamepad button/axis that are being pressed on any scanned input device.

!> This function is provided for debug use only and does very little error checking. Use `input_binding_scan_start()` for player-facing binding scan.

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

!> This function is intended for desktop (Windows, MacOS, Linux) platforms.

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->


&nbsp;

## …led_pattern_get

`input_led_pattern_get(gamepadIndex)`

<!-- tabs:start -->

#### **Description**

**Returns:** Struct, the gamepad LED pattern state. See below

|Name|Datatype|Purpose|
|----|--------|-------|
|`gamepadIndex`|integer |Index of the gamepad to target, using GameMaker's native [gamepad indexes](https://manual.yoyogames.com/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FGamePad_Input%2FGamepad_Input.htm)|

The struct returned by the function contains the following member variables:

|Name        |Datatype|Purpose                                |
|------------|--------|---------------------------------------|
|`.value`    |number  |Number represented by the LED pattern  |
|`.pattern`  |array   |An array of variable size with boolean values representing LED state, `<false>` for off, `<true>` for on|
|`.layout`   |string  |The directional layout of the LED array. `"vertical"`, `"horizontal"`, `"radial"`, or `"unknown"`|

!> This function works on Switch and PS5 platforms, as well as on Windows, iOS and tvOS for select gamepads 

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->


&nbsp;

## …_keyboard_virtual_show

`input_keyboard_virtual_show([virtualKeyboardType])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|`[virtualKeyboardType]`|[Virtual Keyboard Type Constant](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Virtual_Keys_And_Keyboards/keyboard_virtual_show.htm)|Virtual keyboard type to display|

Shows the onscreen virtual keyboard on mobile platforms and SteamOS with the [Steamworks extension](Steamworks.md)

?> For further configuration of the onscreen keyboard see [Touch macros](Config-Macros.md#touch)

!> On consoles, [`get_string_async()`](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Asynchronous_Functions/Dialog/get_string_async.htm) should be used, instead

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->


&nbsp;

## …_keyboard_virtual_hide

`input_keyboard_virtual_hide()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

Hides the onscreen virtual keyboard on mobile platforms and SteamOS with the [Steamworks extension](Steamworks.md)

#### **Example**

```gml
//TODO lol
```

<!-- tabs:end -->
