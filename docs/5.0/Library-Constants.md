# Library Constants

&nbsp;

Input has a number of macros available for your use. Unlike macros used for configuration that are intended to be editted, the macros on this page are constants and their value shouldn't be changed.
 
## Sources

The following constants allow you to reference specific [input sources](Input-Sources). These constants are used by and returned from the various [source functions]().

|Name                        |Purpose                                                                                                                                                                                                                                                           |
|----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_KEYBOARD`            |The keyboard, if any is attached. If `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is `true` then this source will also include input from the mouse too                                                                                                             |
|`INPUT_MOUSE`               |The mouse, if any is attached. If `INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER` is `true` then this source will also include input from the keyboard too                                                                                                             |
|`INPUT_GAMEPAD[n]`          |`INPUT_GAMEPAD` is an array of sources that represent different gamepads that a player can use. `INPUT_GAMEPAD[0]` is the 0th gamepad, `INPUT_GAMEPAD[1]` is the 1st gamepad and so on. The index for this array corresponds to the native GameMaker gamepad index|
|`INPUT_MAX_TRACKED_GAMEPADS`|The total number of gamepads that Input will track. This is the length of the `INPUT_GAMEPAD` array                                                                                                                                                               |

&nbsp;

## Source Modes

The `INPUT_SOURCE_MODE` enum contains the following members.

|Name           |Purpose                                                                                 |
|---------------|----------------------------------------------------------------------------------------|
|`.FROZEN`      |                                                                                        |
|`.MULTIPLAYER` |                                                                                        |
|`.HOTSWAP`     |                                                                                        |
|`.MIXED`       |                                                                                        |
|`.MULTI_DEVICE`|                                                                                        |

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