# Configuration

&nbsp;

## General

`__input_config_general()` holds macros that affect the general behaviour of Input. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                              |Typical Value|Purpose                                                                                           |
|----------------------------------|-------------|--------------------------------------------------------------------------------------------------|
|`INPUT_MAX_PLAYERS`               |`4`          |Maximum number of players that the game supports                                                  |
|`INPUT_MAX_ALTERNATE_BINDINGS`    |`2`          |Maximum number of binding to allow per verb per profile                                           |
|`INPUT_ALLOW_OUT_OF_FOCUS`        |`false`      |Whether to allow input while game window is out of focus on desktop platforms                     |
|`INPUT_TIMER_MILLISECONDS`        |`false`      |Set to `true` to use milliseconds instead of frames for many functions and behaviours inside Input|
|`INPUT_ANDROID_KEYBOARD_ALLOWED`  |`false`      |Whether to allow keyboard input on Android platform                                               |
|`INPUT_SWITCH_KEYBOARD_ALLOWED`   |`false`      |Whether to allow keyboard input on Switch platform                                                |
|`INPUT_BINDING_SCAN_TIMEOUT`      |`10000`      |Time (in milliseconds) to wait for a new binding before automatically cancelling the binding scan |
|`INPUT_IGNORE_RESERVED_KEYS_LEVEL`|`2`          |Controls default key filtering behaviour. See below                                               |

`INPUT_IGNORE_RESERVED_KEYS_LEVEL` can take the following values:

- `0`: Don't ignore any keys. This is not recommended!
- `1`: Ignore a minimal selection of problematic keys:
    - Alt keys
    - Meta or "Windows" key (Command on Mac)
    - Fullscreen on HTML5 (F11, or F10 on Apple platforms)
    - Caps Lock on HTML5 for Apple platforms
- `2`: Ignore all reserved and/or system keys (in addition to the above):
    - Num lock & Scroll lock
    - IME keys
    - Browser keys
    - Media keys


You can modify this list at any time by calling [`input_ignore_key_add()`](Functions-(Other)#input_ignore_key_addkey) or [`input_ignore_key_remove()`](Functions-(Other)#input_ignore_key_removekey). This setting only affects Input and will not filter keys from native GameMaker functions.

&nbsp;

## Verbs

`__input_config_verbs()` holds macros that affect verbs, and the way verbs are checked, in Input. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                             |Typical Value|Purpose                                                                                                                                              |
|---------------------------------|-------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_VERB_GROUPS`              |             |This macro contains the struct that defines verb collision groups. Please see the [Verbs and Bindings](Verbs-and-Bindings) page for more information |
|`INPUT_REPEAT_DEFAULT_DELAY`     |`10`         |Default time between re-triggers for [`input_check_repeat()`](Functions-(Checkers)#input_check_repeatverb-playerindex-delay-predelay)                |
|`INPUT_REPEAT_DEFAULT_PREDELAY`  |`30`         |Default time before the first re-trigger for [`input_check_repeat()`](Functions-(Checkers)#input_check_repeatverb-playerindex-delay-predelay)        |
|`INPUT_LONG_DELAY`               |`10`         |Time before long-press functions are activated. Whether this is in frames or milliseconds is controlled by `INPUT_TIMER_MILLISECONDS`                |
|`INPUT_DOUBLE_DELAY`             |`12`         |Delay between key presses for it to register as a double press. Whether this is in frames or milliseconds is controlled by `INPUT_TIMER_MILLISECONDS`|
|`INPUT_QUICK_BUFFER`             |`4`          |Maximum number of frames to trigger a quick tap. Lower values require the thumbstick to move faster. This value is always measured in frames         |
|`INPUT_CHORD_DEFAULT_TIME`       |`4`          |Delay between key presses for it to register as a double press. Whether this is in frames or milliseconds is controlled by `INPUT_TIMER_MILLISECONDS`|
|`INPUT_2D_CLAMP`                 |`true`       |Whether to clamp 2D input to a maximum distance of 1 unit                                                                                            |
|`INPUT_2D_XY_AXIS_BIAS`          |`0.0`        |The amount of bias for 2D checkers to prefer straight lines along the x- and y-axes. This makes it easier for the player to input exactly horizontal and exactly vertical movement. Value should be from 0 to 1. Higher values make the biasing behaviour stronger|
|`INPUT_2D_XY_AXIS_BIAS_DIAGONALS`|`true`       |Whether the axis bias (see above) should be 8-directional. If set to `false`, 2D checkers will only lock to north/east/south/west directions         |

&nbsp;

## Profiles and Bindings

`__input_config_profiles_and_bindings()` holds macros that affect profiles and bindings in Input. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                                      |Typical Value            |Purpose                                                                                                                                                      |
|------------------------------------------|-------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_AUTO_PROFILE_FOR_KEYBOARD`         |`"keyboard"`             |Profile to use to automatically set up bindings when the player is using the `INPUT_KEYBOARD` source                                                         |
|`INPUT_AUTO_PROFILE_FOR_MOUSE`            |`"mouse"`                |Profile to use to automatically set up bindings when the player is using the `INPUT_MOUSE` source                                                            |
|`INPUT_AUTO_PROFILE_FOR_GAMEPAD`          |`"gamepad"`              |Profile to use to automatically set up bindings when the player is using the `INPUT_GAMEPAD[n]` source                                                       |
|`INPUT_AUTO_PROFILE_FOR_MIXED`            |`"mixed"`                |Profile to use to automatically set up bindings when the `INPUT_SOURCE_MODE.MIXED` source mode is in use                                                     |
|`INPUT_AUTO_PROFILE_FOR_MULTIDEVICE`      |`"multidevice"`          |Profile to use to automatically set up bindings when the `INPUT_SOURCE_MODE.MULTIDEVICE` source mode is in use                                               |
|`INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER`|`true`                   |Whether to treat `INPUT_KEYBOARD` and `INPUT_MOUSE` sources are interchangeable. This "pairs" the two sources together and is the default behaviour for Input|
|`INPUT_ALLOW_ASSYMMETRIC_DEFAULT_PROFILES`|`false`                  |Whether to allow [default profiles](Profiles) to include different verbs. This is convenient for larger games but is potentially unsafe                      |
|`INPUT_DEFAULT_PROFILES`                  |                         |This macro contains the struct that defines default profiles. Please see the [Profiles](Profiles) page for more information                                  |

&nbsp;

## Source Modes

`__input_config_source_modes()` holds macros that affect the behaviour of different source modes. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                              |Typical Value              |Purpose                                                                                                                                                                                                  |
|----------------------------------|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_STARTING_SOURCE_MODE`      |`INPUT_SOURCE_MODE.HOTSWAP`|Initial starting [source mode](Input-Sources?id=source-modes) for Input when the game boots                                                                                                              |
|`INPUT_MULTIPLAYER_LEAVE_VERB`    |`"leave"`                  |Only valid in the `INPUT_SOURCE_MODE.JOIN` source mode. The name of the verb that, when activated by a player, causes the player to have their sources cleared, "disconnecting" them from the game       |
|`INPUT_MULTIPLAYER_ABORT_CALLBACK`|Method or script           |Method or script to execute when the `INPUT_SOURCE_MODE.JOIN` source mode is aborted                                                                                                                     |
|`INPUT_HOTSWAP_DELAY`             |`33`                       |Number of milliseconds between source swaps when using [`input_hotswap_tick()`](Functions-(Source-Assignment)#input_hotswap_tickplayerindex). This should be longer than a single frame (>17 ms at 60FPS)|
|`INPUT_HOTSWAP_ON_GAMEPAD_AXIS`   |`true`                     |Whether to trigger a hotswap when a gamepad axis is moved                                                                                                                                                |
|`INPUT_HOTSWAP_ON_MOUSE_BUTTON`   |`true`                     |Whether to trigger a hotswap when a mouse button is pressed                                                                                                                                              |
|`INPUT_HOTSWAP_ON_MOUSE_MOVEMENT` |`true`                     |Whether to trigger a hotswap when the mouse is moved                                                                                                                                                     |
|`INPUT_HOTSWAP_CALLBACK`          |Method or script           |Method or script to execute when player 0 is given a new source in the `INPUT_SOURCE_MODE.HOTSWAP` source mode                                                                                           |
|`INPUT_HOTSWAP_AUTO_PROFILE`      |`true`                     |Whether to automatically set the profile for player 0 when they hotswap to a new source                                                                                                                  |

&nbsp;

## Gamepad Data

`__input_config_external_data()` holds macros that affect how Input loads and uses external gamepad data. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                                      |Typical Value              |Purpose                                                                                                                                                                                                                                                                    |
|------------------------------------------|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_SDL2_REMAPPING`                    |`true`                     |Whether to use Input's own SDL2 database to remap gamepads, overriding the old and crusty database that GameMaker uses internally. Setting this to `false` will cause Input to use GameMaker's native database and, as a result, gamepad mapping data will be less accurate|
|`INPUT_SDL2_ALLOW_EXTERNAL`               |`true`                     |Whether to allow external SDL2 database loading from environment variable `%SDL_GAMECONTROLLERCONFIG%`. This is useful for compatibility with external gamepad mapping software                                                                                            |
|`INPUT_SDL2_ALLOW_EXTENDED`               |`false`                    |Whether to allow use of SDL2's extended bindings, accessed using the [extended `gp_*` constants](Library-Constants?id=extended-gamepad-constants)                                                                                                                          |
|`INPUT_SDL2_DATABASE_PATH`                |`"sdl2.txt"`               |Path to the SDL2 database to read gamepad remapping definitions from                                                                                                                                                                                                       |
|`INPUT_CONTROLLER_TYPE_PATH`              |`"controllertypes.csv"`    |Path to the controller type database to read gamepad types from                                                                                                                                                                                                            |
|`INPUT_BLACKLIST_PATH`                    |`"controllerblacklist.csv"`|Path to the controller blacklist database to read from                                                                                                                                                                                                                     |

&nbsp;

## Mouse, Touch, and Cursor

`__input_config_mouse_touch_cursor()` holds macros that affect how Input handles mouse and touch input, and how Input's native cursor feature behaves. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                                      |Typical Value              |Purpose                                                                                                                                                                                                   |
|------------------------------------------|---------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_MOUSE_ALLOW_SCANNING`              |`true`                     |Whether to allow mouse input to be returned by [`input_binding_scan_start()`]()                                                                                                                           |
|`INPUT_MOUSE_MOVE_DEADZONE`               |`2`                        |Size of the deadzone for detecting mouse movement, measured in pixels. Higher values increase how far the mouse must travel before reporting the mouse as being used                                      |
|`INPUT_MAX_TOUCHPOINTS`                   |`11`                       |Maximum number of touch screen points to query. This applies to touch screen devices only (excludes PlayStation)                                                                                          |
|`INPUT_TOUCH_EDGE_DEADZONE`               |`35`                       |Margin in pixels around the screen edge where gaining or losing a touch point will not register "pressed" or "released". Prevents false positives when dragging on to or off of the edge of a touchscreen.|
|`INPUT_TOUCH_POINTER_ALLOWED`             |`false`                    |Whether to allow touch input (real, or simulated by physical mouse) to set mouse bindings on touch-enabled platforms                                                                                      |
|`INPUT_CURSOR_VERB_UP`                    |`"up"`                     |Verb that controls upwards motion for a player's cursor                                                                                                                                                   |
|`INPUT_CURSOR_VERB_DOWN`                  |`"down"`                   |Verb that controls downwards motion for a player's cursor                                                                                                                                                 |
|`INPUT_CURSOR_VERB_LEFT`                  |`"left"`                   |Verb that controls leftwards motion for a player's cursor                                                                                                                                                 |
|`INPUT_CURSOR_VERB_RIGHT`                 |`"right"`                  |Verb that controls rightwards motion for a player's cursor                                                                                                                                                |
|`INPUT_CURSOR_START_SPEED`                |`5`                        |The default speed for cursors when the game boots up. This can be changed per player with `input_cursor_speed_set()`                                                                                      |
|`INPUT_CURSOR_EXPONENT`                   |`1`                        |Cursor movement exponent. This is applied when using keyboard and gamepad controls                                                                                                                        |

&nbsp;

## Gamepads

`__input_config_gamepads()` holds macros that affect how Input's gamepads behave. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                                      |Typical Value              |Purpose                                                                                                                                                                                                                                                                     |
|------------------------------------------|---------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_DEFAULT_AXIS_MIN_THRESHOLD`        |`0.3`                      |Default minimum threshold for directional (thumbstick) axes. This value is used for detecting gamepad input when hotswapping so make sure you set it above 0.0                                                                                                              |
|`INPUT_DEFAULT_AXIS_MAX_THRESHOLD`        |`1.0`                      |Default maximum threshold for directional (thumbstick) axes                                                                                                                                                                                                                 |
|`INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD`     |`0.02`                     |Default minimum threshold for non-directional (trigger) axes. This value is used for detecting gamepad input when hotswapping so make sure you set it above 0.0                                                                                                             |
|`INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD`     |`1.0`                      |Default maximum threshold for non-directional (trigger) axes                                                                                                                                                                                                                |
|`INPUT_SWITCH_HORIZONTAL_HOLDTYPE`        |`true`                     |Whether the game uses the horizontal holdtype for single Joy-Cons. Set this to `false` for vertical holdtype. Input treats these two modes as mutually exclusive (come talk to us if you need to be able to swap at runtime). This macro only applies to the Switch platform|
|`INPUT_VIBRATION_ALLOWED`                 |`true`                     |Whether vibration should be allowed at all, often useful when debugging                                                                                                                                                                                                     |
|`INPUT_VIBRATION_DEFAULT_STRENGTH`        |`1.0`                      |The default vibration strength. This value can be changed later by using [`input_vibrate_set_strength()`]()                                                                                                                                                                 |
|`INPUT_VIBRATION_SWITCH_OS_STRENGTH`      |`0.4`                      |Switch's vibration motors can be a bit, uh, intense. This value allows you to reduce the strength of vibration relative to other platforms                                                                                                                                  |

&nbsp;

## Icons

`__input_config_icons()` holds code that defines what values [`input_binding_get_icon()`](Functions-(Binding-Access)?id=input_binding_get_iconbinding-playerindex) should return for specific bindings for specific [types of gamepad](Functions-(Players)?id=input_player_get_gamepad_typeplayerindex-binding). This script never needs to be directly called in your code, but the script and the struct it contains must be present in a project for Input to work.

For more information on how to customise `__input_config_icons()`, please see information relating to [`input_icons()`](Functions-(Other)?id=input_iconscategoryname), the function used throughout this script.

?> You should edit this script to customise Input for your own purposes.
