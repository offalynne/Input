# Library Constants

&nbsp;

Input has a number of macros available for your use. Unlike macros used for configuration that are intended to be editted, the macros on this page are constants and their value shouldn't be changed.
 
## Sources

The following constants allow you to reference specific [input sources](Input-Sources). These constants are used by and returned from the various [source functions]().

|Name                |Purpose                                                                                                                                                                                                                                                           |
|--------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_KEYBOARD`    |The keyboard, if any is attached. If `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is `true` then this source will also include input from the mouse too                                                                                                             |
|`INPUT_MOUSE`       |The mouse, if any is attached. If `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is `true` then this source will also include input from the keyboard too                                                                                                             |
|`INPUT_GAMEPAD[n]`  |`INPUT_GAMEPAD` is an array of sources that represent different gamepads that a player can use. `INPUT_GAMEPAD[0]` is the 0th gamepad, `INPUT_GAMEPAD[1]` is the 1st gamepad and so on. The index for this array corresponds to the native GameMaker gamepad index|
|`INPUT_MAX_GAMEPADS`|The total number of gamepads that Input will track. This is the length of the `INPUT_GAMEPAD` array                                                                                                                                                               |

&nbsp;

## Source Modes

The `INPUT_SOURCE_MODE` enum contains the following members. You can read more about source modes [here](Input-Sources?id=source-modes).

|Name          |Single Player Only|Purpose                                                                                                                                                             |
|--------------|------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`.FIXED`      |no                |Input will not change sources automatically and you are responsible for managing sources yourself                                                                   |
|`.JOIN`       |no                |Allows players to “join” the game by pressing any button on a supported device, and they can leave by activating a certain verb                                     |
|`.HOTSWAP`    |yes               |Automatically swaps sources for player 0 based on what source the player is currently interacting with.                                                             |
|`.MIXED`      |yes               |Accepts input for player 0 from the keyboard, the mouse, and **one** gamepad. The gamepad that is active will be hotswapped and only one gamepad is active at a time|
|`.MULTIDEVICE`|yes               |Accepts input for player 0 from the keyboard, the mouse, and **all** gamepads. Gamepad bindings are tied to specific gamepad slots.                                 |

&nbsp;

## Extended Gamepad Constants

If [`INPUT_SDL2_ALLOW_EXTENDED`]() has been set to `true` then the following constants will be available for use. Not many gamepads actually have these buttons so it's not recommend to use these constants for default bindings.

|Name         |            |
|-------------|------------|
|`gp_guide`   |`gp_misc1`  |
|`gp_touchpad`|`gp_paddle1`|
|`gp_paddle2` |`gp_paddle3`|
|`gp_paddle4` |            |

&nbsp;

## Extended Keyboard Constants

GameMaker is curiously missing a few keyboard characters from its set of native constants. Input adds support for them via the following constants.

|Name           |              |
|---------------|--------------|
|`vk_meta1`     |`vk_meta2`    |
|`vk_capslock`  |`vk_scrollock`|
|`vk_numlock`   |`vk_semicolon`|
|`vk_comma`     |`vk_fslash`   |
|`vk_lbracket`  |`vk_rbracket` |
|`vk_apostrophe`|`vk_bslash`   |
|`vk_equals`    |`vk_hyphen`   |
|`vk_backtick`  |`vk_period`   |

&nbsp;

## `INPUT_KEYBOARD_LOCALE`

This macro provides a hint for default Latin keyboard layout based on available information. It can return `QWERTY` `AZERTY` or `QWERTZ` as a string, indicating which keyboard layout Input predicts the player is using. This is useful for building safe default bindings based on [keyboard layout differences](https://www.typingpal.com/en/news/what-is-the-difference-between-QWERTY-QWERTZ-and-AZERTY-keyboards). Note that while system software can determine the active keyboard layout, we cannot detect this at runtime, and this function merely provides a suggestion as to the system-default using OS locale info ([ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) and [ISO 3166-1](https://en.wikipedia.org/wiki/ISO_3166-1)).

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
