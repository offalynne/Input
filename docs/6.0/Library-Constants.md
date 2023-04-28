# Library Constants

&nbsp;

Input has a number of macros available for your use. Unlike macros used for configuration that are intended to be editted, the macros on this page are constants and their value shouldn't be changed.
 
## Sources

The following constants allow you to reference specific [input sources](Input-Sources). These constants are used by and returned from the various [source functions](Functions-(Sources)).

|Name                |Purpose                                                                                                                                                                                                                                                           |
|--------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_KEYBOARD`    |The keyboard, if any is attached. If `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is `true` then this source will also include input from the mouse too                                                                                                             |
|`INPUT_MOUSE`       |The mouse, if any is attached. If `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is `true` then this source will also include input from the keyboard too                                                                                                             |
|`INPUT_GAMEPAD[n]`  |`INPUT_GAMEPAD` is an array of sources that represent different gamepads that a player can use. `INPUT_GAMEPAD[0]` is the 0th gamepad, `INPUT_GAMEPAD[1]` is the 1st gamepad and so on. The index for this array corresponds to the native GameMaker gamepad index|
|`INPUT_MAX_GAMEPADS`|The total number of gamepads that Input will track. This is the length of the `INPUT_GAMEPAD` array                                                                                                                                                               |

&nbsp;

## Source Modes

The `INPUT_SOURCE_MODE` enum contains the following members. You can read more about source modes [here](Input-Sources?id=source-modes).

|Name          |Single Player Only|Purpose                                                                                                                                        |
|--------------|------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
|`.FIXED`      |no                |Input will not change sources automatically and you are responsible for managing sources yourself                                              |
|`.JOIN`       |no                |Allows players to “join” the game by pressing any button on a supported device, and they can leave by activating a certain verb                |
|`.HOTSWAP`    |yes               |Automatically swaps sources for player 0 based on what source the player is currently interacting with                                         |
|`.MIXED`      |yes               |Accepts input for player 0 from the keyboard, the mouse, and **all** gamepads. Gamepad bindings will listen to all connected gamepads for input|
|`.MULTIDEVICE`|yes               |Accepts input for player 0 from the keyboard, the mouse, and **all** gamepads. Gamepad bindings are tied to specific gamepad slots             |

&nbsp;

## Coordinate Spaces

The `INPUT_COORD_SPACE` enum is used to control the coordinate space for mouse and cursor functions, specifically using [`input_mouse_coord_space_set()`](Functions-(Mouse)?id=input_mouse_coord_space_setcoordspace) and [`input_cursor_coord_space_set()`](Functions-(Cursor)?id=input_cursor_coord_space_setcoordspace-playerindex)

|Name     |Purpose                                                                                   |
|---------|------------------------------------------------------------------------------------------|
|`.ROOM`  |Room coordinates; should be the same as `mouse_x` and `mouse_y`. This is the default value|
|`.GUI`   |GUI coordinates                                                                           |
|`.DEVICE`|Raw device-space coordinates                                                              |

&nbsp;

## Player and Gamepad Status

Members of the `INPUT_STATUS` enum are returned by [`input_players_get_status()`](Functions-(Players)?id=input_players_get_status) and [`input_gamepad_get_status()`](Functions-(Gamepad)?id=input_gamepads_get_status).

|Name                 |Purpose                                                 |
|---------------------|--------------------------------------------------------|
|`.NEWLY_DISCONNECTED`|Player/gamepad has been disconnected this frame         |
|`.DISCONNECTED`      |Player/gamepad is disconnected (for at least two frames)|
|`.NEWLY_CONNECTED`   |Player/gamepad has been connected this frame            |
|`.CONNECTED`         |Player/gamepad is connected (for at least two frames)   |

&nbsp;

## Binding Scan Events

The `INPUT_BINDING_SCAN_EVENT` enum is used by the failure callback for [`input_binding_scan_start()`](Functions-(Binding-Creators)?id=input_binding_scan_startsuccesscallback-failurecallback-sourcefilter-playerindex).

|Name                 |Meaning                                                                                                                                                                      |
|---------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`.SOURCE_INVALID`    |Player's source is invalid, usually because they have no sources assigned or their gamepad has been disconnected                                                             |
|`.SOURCE_CHANGED`    |The player's source (or sources) have been modified                                                                                                                          |
|`.PLAYER_IS_GHOST`   |Player is a ghost and cannot receive hardware input                                                                                                                          |
|`.SCAN_TIMEOUT`      |Either the player didn't enter a new binding or a stuck key prevented the system from working. The timeout period is defined by [`INPUT_BINDING_SCAN_TIMEOUT`](Configuration)|
|`.LOST_FOCUS`        |The application lost focus                                                                                                                                                   |
|`.PLAYER_DISCONNECTED`        |The player disconnected                                                                                                                                                   |
|`.ABORTED`           |Binding scan was aborted early due to `input_binding_scan_abort()` being called                                                                                              |

&nbsp;

## Gamepad Types

The following constants allow you to reference specific gamepad types. These constants are used to define [`input_icon()`](Functions-(Other)?id=input_iconscategoryname) categories, to specify type override with [`input_player_gamepad_type_override_set()`](Functions-(Players)#input_player_gamepad_type_override_setgamepadtype-playerindex), and are returned by [`input_player_get_gamepad_type()`](Functions-(Players)?id=input_player_get_gamepad_typeplayerindex-binding), [`input_gamepad_get_type()`](Functions-(Gamepad)?id=input_gamepad_get_typegamepadindex), and [`input_player_gamepad_type_override_get()`](Functions-(Players)#input_player_gamepad_type_override_getgamepadtype-playerindex).

|Name                              | Gamepads             |
|----------------------------------|----------------------|
|`INPUT_GAMEPAD_TYPE_XBOX_ONE`     | Xbox Series, Xbox One, Steam Deck, Luna, Stadia, MFi |
|`INPUT_GAMEPAD_TYPE_XBOX_360`     | Xbox 360, Dreamcast, Steam Controller, Steam Link Touch Controller |
|`INPUT_GAMEPAD_TYPE_PS5`          | PS5                  |
|`INPUT_GAMEPAD_TYPE_PS4`          | PS4                  |
|`INPUT_GAMEPAD_TYPE_PSX`          | PS1, PS2, PS3        |
|`INPUT_GAMEPAD_TYPE_SWITCH`       | Switch Handheld Mode, Switch Lite, Switch Joy-Con Pair, Switch Pro, Switch 3rd party, WiiU, Wii |
|`INPUT_GAMEPAD_TYPE_JOYCON_LEFT`  | Switch Joy-Con Left  |
|`INPUT_GAMEPAD_TYPE_JOYCON_RIGHT` | Switch Joy-Con Right |
|`INPUT_GAMEPAD_TYPE_GAMECUBE`     | GameCube             |

!> Additional extended gamepad types for variations and legacy devices can be found and configured in the `__input_define_gamepad_types` script resource.

&nbsp;

## Extended Gamepad Constants

If [`INPUT_SDL2_ALLOW_EXTENDED`](Configuration?id=gamepad-data) has been set to `true` then the following constants will be available for use. Not many gamepads actually have these buttons so it's not recommend to use these constants for default bindings.

|Name         |            |
|-------------|------------|
|`gp_guide`   |`gp_misc1`  |
|`gp_touchpad`|`gp_paddle1`|
|`gp_paddle2` |`gp_paddle3`|
|`gp_paddle4` |            |

&nbsp;

## Extended Keyboard Constants

GameMaker is missing a few keyboard characters from its set of native constants. Input adds support via the following constants.

|Name           |              |
|---------------|--------------|
|`vk_lmeta`     |`vk_rmeta`    |
|`vk_menu`      |`vk_clear`    |
|`vk_capslock`  |`vk_scrollock`|
|`vk_numlock`   |`vk_semicolon`|
|`vk_comma`     |`vk_backtick` |
|`vk_lbracket`  |`vk_rbracket` |
|`vk_fslash`    |`vk_bslash`   |
|`vk_equals`    |`vk_hyphen`   |
|`vk_apostrophe`|`vk_period`   |

!> As extended keyboard constant values are relative to platform and OS, they can not be used as case statements within switch statements.

&nbsp;

## `INPUT_KEYBOARD_LOCALE`

This macro provides a hint for default Latin keyboard layout based on available information. It can return `QWERTY` `AZERTY` or `QWERTZ` as a string, indicating which keyboard layout Input predicts the player is using. This is useful for building safe default bindings based on [keyboard layout differences](https://www.typingpal.com/en/news/what-is-the-difference-between-QWERTY-QWERTZ-and-AZERTY-keyboards). Note that while system software can determine the active keyboard layout, we cannot detect this at runtime; this function provides a suggestion as to the system-default setting using OS locale info (specifically [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) and [ISO 3166-1](https://en.wikipedia.org/wiki/ISO_3166-1)).

_Example usage_
```gml
if (INPUT_KEYBOARD_LOCALE == "AZERTY")
{
    INPUT_DEFAULT_PROFILES = {
        keyboard: {
            up:    input_binding_key("E"),
            down:  input_binding_key("D"),
            left:  input_binding_key("S"),
            right: input_binding_key("F"),
        }
    }
}
else
{
    INPUT_DEFAULT_PROFILES = {
        keyboard: {
            up:    input_binding_key("W"),
            down:  input_binding_key("S"),
            left:  input_binding_key("A"),
            right: input_binding_key("D"),
        }
    }
}
```

&nbsp;

## `INPUT_KEYBOARD_TYPE`

This macro is set to a string indicating the current platform's preferred text source as a string. Possible values are `async` `virtual` or `keyboard`. This is useful for games where the player is expected to enter some text (for example, a name for a highscore) and you need to pick the most suitable option.

&nbsp;

## `INPUT_POINTER_TYPE`

This macro is set to a string indicating the current platform's pointer type as a string. Possible values are `mouse`, `touch`, `touchpad` or `none`. This is useful for selectively configuring pointer features including [virtual touch buttons](Functions-(Virtual-Buttons)), [mouse control](Functions-(Mouse)), and other [cursor behaviour](Functions-(Cursor)).

&nbsp;

## Gyro Axis

The `INPUT_GYRO` enum contains the following members used by the [gamepad motion functions](Functions-(Motion)) to configure the axis used to control the player cursor. Meaning descriptions assume a neutral position of device resting on a flat surface. See [gamepad motion functions](Functions-(Motion)) for illustrative figure.

|Name         |Meaning                                              |
|-------------|-----------------------------------------------------|
|`.AXIS_PITCH`|Gamepad tilted upward from floor to ceiling          |
|`.AXIS_YAW`  |Gamepad tilted rightward from left shoulder to right |
|`.AXIS_ROLL` |Gamepad tilted clockwise from 6 to 12 o'clock        |

&nbsp;

## Trigger Effect States

The `INPUT_TRIGGER_STATE` enum contains the following members returned by [`input_trigger_effect_get_state()`](Functions-(Trigger-Effects)?id=input_trigger_effect_get_state).

|Name                       |Meaning                                                 |
|---------------------------|--------------------------------------------------------|
|`.EFFECT_OFF`              |No trigger effect                                       |
|`.EFFECT_FEEDBACK_STANDBY` |Trigger position below range for feedback effect        |
|`.EFFECT_FEEDBACK_ACTIVE`  |Trigger position within range of feedback effect        |
|`.EFFECT_WEAPON_STANDBY`   |Trigger position below range for weapon effect          |
|`.EFFECT_WEAPON_PULLING`   |Trigger position in range for weapon feedback effect    |
|`.EFFECT_WEAPON_FIRED`     |Trigger position beyond range for weapon feedback effect|
|`.EFFECT_VIBRATION_STANDBY`|Trigger position out of range for vibration effect      |
|`.EFFECT_VIBRATION_ACTIVE` |Trigger position within range for vibration effect      |
|`.EFFECT_INTERCEPTED`      |Effect paused or not applied; no trigger effect         |
