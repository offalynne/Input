# Configuration

&nbsp;

## General

`__input_config_general()` holds macros that affect the general behaviour of Input. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                                      |Typical Value            |Purpose                                                                                                                                               |
|------------------------------------------|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_MAX_PLAYERS`                       |`4`                      |Maximum number of players that the game supports                                                                                                      |
|`INPUT_TIMER_MILLISECONDS`                |`false`                  |Set to `true` to use milliseconds instead of frames for [`input_check_*()`](Functions-(Checkers)) functions                                           |
|`INPUT_REPEAT_DEFAULT_DELAY`              |`10`                     |Default time between re-triggers for [`input_check_repeat()`](Functions-(Checkers)#input_check_repeatverb-playerindex-delay-predelay)                 |
|`INPUT_REPEAT_DEFAULT_PREDELAY`           |`30`                     |Default time before the first re-trigger for [`input_check_repeat()`](Functions-(Checkers)#input_check_repeatverb-playerindex-delay-predelay)         |
|`INPUT_LONG_DELAY`                        |`10`                     |Time before long-press functions are activated. Whether this is in frames or milliseconds is controlled by `INPUT_TIMER_MILLISECONDS`                 |
|`INPUT_DOUBLE_DELAY`                      |`12`                     |Delay between key presses for it to register as a double press. Whether this is in frames or milliseconds is controlled by `INPUT_TIMER_MILLISECONDS` |
|`INPUT_CHORD_DEFAULT_TIME`                |`4`                      |Delay between key presses for it to register as a double press. Whether this is in frames or milliseconds is controlled by `INPUT_TIMER_MILLISECONDS` |
|`INPUT_2D_CLAMP`                          |`true`                   |Number of milliseconds between source swaps when using [`input_hotswap_tick()`](Functions-(Source-Assignment)#input_hotswap_tickplayerindex). This should be longer than a single frame (>17 ms at 60FPS)|
|`INPUT_ANDROID_KEYBOARD_ALLOWED`          |`false`                  |Whether to allow keyboard input on Android platform                                                                                                   |
|`INPUT_SWITCH_KEYBOARD_ALLOWED`           |`false`                  |Whether to allow keyboard input on Switch platform                                                                                                    |
|`INPUT_BINDING_SCAN_TIMEOUT`              |`10000`                  |Time (in milliseconds) to wait for a new binding before automatically cancelling the binding scan                                                     |
|`INPUT_IGNORE_RESERVED_KEYS_LEVEL`        |`2`                      |Controls default key filtering behaviour. See below                                                                                                   |

`INPUT_IGNORE_RESERVED_KEYS_LEVEL` can take the following values:

- `0`: Don't ignore any keys. This is not recommended!
- `1`: Ignore a minimal selection of problematic keys:
    - Alt keys
    - Meta or "Windows" key (Command on Mac)
    - Fullscreen on HTML5 (F11, or F10 on Apple platforms)
    - Caps Lock on HTML5 for Apple platforms
    - Various keys triggered by gamepads on UWP platforms
- `2`: Ignore all reserved and/or system keys (in addition to the above):
    - Num lock & Scroll lock
    - IME keys
    - Browser keys
    - Media keys


You can modify this list at any time by calling [`input_ignore_key_add()`](Functions-(Other)#input_ignore_key_addkey) or [`input_ignore_key_remove()`](Functions-(Other)#input_ignore_key_removekey). This setting only affects Input and will not filter keys from native GameMaker functions.

&nbsp;

## Profiles and Bindings

`__input_config_profiles_and_bindings()` holds macros that affect profiles and bindings in Input. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                                      |Typical Value            |Purpose                                                                                                                                               |
|------------------------------------------|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_MAX_ALTERNATE_BINDINGS`            |`2`                      |                                                                                                                                                      |
|`INPUT_AUTO_PROFILE_FOR_KEYBOARD`         |`"keyboard"`             |                                                                                                                                                      |
|`INPUT_AUTO_PROFILE_FOR_MOUSE`            |`"mouse"`                |                                                                                                                                                      |
|`INPUT_AUTO_PROFILE_FOR_GAMEPAD`          |`"gamepad"`              |                                                                                                                                                      |
|`INPUT_AUTO_PROFILE_FOR_MIXED`            |`"mixed"`                |                                                                                                                                                      |
|`INPUT_AUTO_PROFILE_FOR_MULTIDEVICE`      |`"multidevice"`          |                                                                                                                                                      |
|`INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER`|`true`                   |                                                                                                                                                      |
|`INPUT_ALLOW_ASSYMMETRIC_DEFAULT_PROFILES`|`false`                  |                                                                                                                                                      |
|`INPUT_DEFAULT_PROFILES`                  |See below                |                                                                                                                                                      |

&nbsp;

## Source Modes

`__input_config_source_modes()` holds macros that affect the behaviour of different source modes. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                              |Typical Value              |Purpose                                                                                                                                                                                                  |
|----------------------------------|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_STARTING_SOURCE_MODE`      |`INPUT_SOURCE_MODE.HOTSWAP`|                                                                                                                                                                                                         |
|`INPUT_MULTIPLAYER_LEAVE_VERB`    |Method                     |                                                                                                                                                                                                         |
|`INPUT_MULTIPLAYER_ABORT_CALLBACK`|Method                     |                                                                                                                                                                                                         |
|`INPUT_HOTSWAP_DELAY`             |`33`                       |Number of milliseconds between source swaps when using [`input_hotswap_tick()`](Functions-(Source-Assignment)#input_hotswap_tickplayerindex). This should be longer than a single frame (>17 ms at 60FPS)|
|`INPUT_HOTSWAP_ON_GAMEPAD_AXIS`   |`true`                     |Whether to trigger a hotswap when a gamepad axis is moved                                                                                                                                                |
|`INPUT_HOTSWAP_ON_MOUSE_MOVEMENT` |`true`                     |Whether to trigger a hotswap when the mouse is moved                                                                                                                                                     |
|`INPUT_HOTSWAP_CALLBACK`          |Method                     |                                                                                                                                                                                                         |
|`INPUT_HOTSWAP_AUTO_PROFILE`      |`true`                     |                                                                                                                                                                                                         |

&nbsp;

## Gamepad Data

`__input_config_gamepad_data()` holds macros that affect how Input loads and uses gamepad data. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                                      |Typical Value              |Purpose                                                                                                                                               |
|------------------------------------------|---------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_SDL2_REMAPPING`                    |`true`                     |                                                                                                                                                      |
|`INPUT_SDL2_ALLOW_EXTERNAL`               |`true`                     |                                                                                                                                                      |
|`INPUT_SDL2_ALLOW_EXTENDED`               |`false`                    |                                                                                                                                                      |
|`INPUT_SDL2_DATABASE_PATH`                |`"sdl2.txt"`               |                                                                                                                                                      |
|`INPUT_CONTROLLER_TYPE_PATH`              |`"controllertypes.csv"`    |                                                                                                                                                      |
|`INPUT_BLACKLIST_PATH`                    |`"controllerblacklist.csv"`|                                                                                                                                                      |
|`INPUT_BUTTON_LABEL_PATH`                 |`"buttonlabels.csv"`       |                                                                                                                                                      |
|`INPUT_BUTTON_COLOR_PATH`                 |`"buttoncolors.csv"`       |                                                                                                                                                      |
|`INPUT_LOAD_BUTTON_LABELS_AND_COLORS`     |`true`                     |                                                                                                                                                      |

&nbsp;

## Mouse, Touch, and Cursor

`__input_config_mouse_touch_cursor()` holds macros that affect how Input handles mouse and touch input, and how Input's native cursor feature behaves. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                                      |Typical Value              |Purpose                                                                                                                                               |
|------------------------------------------|---------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_MOUSE_MODE`                        |`0`                        |                                                                                                                                                      |
|`INPUT_MOUSE_MOVE_DEADZONE`               |`2`                        |                                                                                                                                                      |
|`INPUT_MAX_TOUCHPOINTS`                   |`11`                       |                                                                                                                                                      |
|`INPUT_TOUCH_EDGE_DEADZONE`               |`35`                       |                                                                                                                                                      |
|`INPUT_TOUCH_POINTER_ALLOWED`             |`false`                    |                                                                                                                                                      |
|`INPUT_CURSOR_VERB_UP`                    |`"up"``                    |                                                                                                                                                      |
|`INPUT_CURSOR_VERB_DOWN`                  |`"down"`                   |                                                                                                                                                      |
|`INPUT_CURSOR_VERB_LEFT`                  |`"left"`                   |                                                                                                                                                      |
|`INPUT_CURSOR_VERB_RIGHT`                 |`"right"`                  |                                                                                                                                                      |
|`INPUT_CURSOR_EXPONENT`                   |`1`                        |                                                                                                                                                      |

&nbsp;

## Gamepads

`__input_config_gamepads()` holds macros that affect how Input's gamepads behave. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                                      |Typical Value              |Purpose                                                                                                                                               |
|------------------------------------------|---------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_DEFAULT_AXIS_MIN_THRESHOLD`        |`0.3`                      |                                                                                                                                                      |
|`INPUT_DEFAULT_AXIS_MAX_THRESHOLD`        |`1.0`                      |                                                                                                                                                      |
|`INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD`     |`0.02`                     |                                                                                                                                                      |
|`INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD`     |`1.0`                      |                                                                                                                                                      |
|`INPUT_SWITCH_HORIZONTAL_HOLDTYPE`        |`true`                     |                                                                                                                                                      |