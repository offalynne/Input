# Config Macros

&nbsp;

## General

`__input_config_general()` holds macros that affect the general behavior of Input. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

|Name                        |Typical Value              |Purpose                                                                                           |
|----------------------------|---------------------------|--------------------------------------------------------------------------------------------------|
|`INPUT_PC_KEYBOARD`         |`true`                     |Whether to enable keyboard support on Windows, MacOS, Linux, Steam Deck, desktop browser          |
|`INPUT_PC_MOUSE`            |`true`                     |Whether to enable mouse support on Windows, MacOS, Linux, Steam Deck, desktop browser             |
|`INPUT_PC_GAMEPAD`          |`true`                     |Whether to enable gamepad support on Windows, MacOS, Linux, Steam Deck, desktop browser           |
|`INPUT_WINDOWS_TOUCH`       |`false`                    |Whether to enable touch support on Windows (including Steam Deck via Proton)                      |
|`INPUT_WINDOWS_VIBRATION`   |`true`                     |Whether to enable gamepad vibration support on Windows (XInput and Steam)                         |
|`INPUT_MOBILE_GAMEPAD`      |`true`                     |Whether to enable gamepad support on Android, iOS, iPadOS, tvOS, mobile browser                   |
|`INPUT_MOBILE_MOUSE`        |`false`                    |Whether to map touch to mouse on Android, iOS, iPadOS, tvOS, mobile browser                       |
|`INPUT_MOBILE_WEB_KEYBOARD` |`false`                    |Whether to enable (partial) keyboard support on mobile browser                                    |
|`INPUT_ANDROID_KEYBOARD`    |`false`                    |Whether to enable (partial) keyboard support on Android                                           |
|`INPUT_SWITCH_KEYBOARD`     |`false`                    |Whether to enable (partial) keyboard support on Switch                                            |
|`INPUT_SWITCH_MOUSE`        |`false`                    |Whether to map handheld touchscreen to mouse on Switch                                            |
|`INPUT_SWITCH_TOUCH`        |`false`                    |Whether to enable touch support on Switch handheld                                                |
|`INPUT_SWITCH_VIBRATION`    |`true`                     |Whether to enable legacy vibration support on Switch (simulated with HD Rumble)                   |
|`INPUT_PS_MOUSE`            |`false`                    |Whether to enable (partial) mouse support on PS4 and PS5 (first player touchpad)                  |
|`INPUT_PS4_VIBRATION`       |`true`                     |Whether to enable gamepad vibration support on PS4                                                |
|`INPUT_PS5_VIBRATION`       |`true`                     |Whether to enable legacy vibration support on PS5 (simulated with DualSense haptics)              |
|`INPUT_ALLOW_OUT_OF_FOCUS`  |`false`                    |Whether to allow input while game window is out of focus on desktop platforms                     |
|`INPUT_TIMER_MILLISECONDS`  |`false`                    |Set to `true` to use milliseconds instead of frames for many functions and behaviors inside Input |
|`INPUT_ALLOW_STEAMWORKS `   |`true`                     |Whether to allow using Steamworks extension when available. See [Steamworks](Steamworks)          |
|`INPUT_BINDING_SCAN_TIMEOUT`|`10000`                    |Time (in milliseconds) to wait for a new binding before automatically cancelling the binding scan |
|`INPUT_STARTING_SOURCE_MODE`|`INPUT_SOURCE_MODE.HOTSWAP`|Initial starting [source mode](Input-Sources?id=source-modes) for Input when the game boots       |

&nbsp;

## Verb Behavior

`__input_config_verb_behavior()` holds macros that affect verbs, and the way verbs are checked, in Input. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

|Name                                     |Typical Value|Purpose                                                                                                                                              |
|-----------------------------------------|-------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_MAX_ALTERNATE_BINDINGS`           |`2`          |Maximum number of binding to allow per verb per profile                                                                                              |
|`INPUT_FLEXIBLE_ALTERNATE_BINDING_IMPORT`|`false`      |Whether to tolerate incorrect number of alternate bindings when importing. This should typically be left as `false` to detect errors and such        |
|`INPUT_REPEAT_DEFAULT_DELAY`             |`10`         |Default time between re-triggers for [`input_check_repeat()`](Functions-(Advanced-Checkers)?id=check_repeat)                                         |
|`INPUT_REPEAT_DEFAULT_PREDELAY`          |`30`         |Default time before the first re-trigger for [`input_check_repeat()`](Functions-(Advanced-Checkers)?id=check_repeat)                                 |
|`INPUT_LONG_DELAY`                       |`10`         |Time before long-press functions are activated. Whether this is in frames or milliseconds is controlled by `INPUT_TIMER_MILLISECONDS`                |
|`INPUT_DOUBLE_DELAY`                     |`12`         |Delay between key presses for it to register as a double press. Whether this is in frames or milliseconds is controlled by `INPUT_TIMER_MILLISECONDS`|
|`INPUT_QUICK_BUFFER`                     |`3`          |Maximum number of frames to trigger a quick tap. Lower values require the thumbstick to move faster. This value is always measured in frames         |
|`INPUT_CHORD_DEFAULT_TIME`               |`4`          |Delay between key presses for it to register as a double press. Whether this is in frames or milliseconds is controlled by `INPUT_TIMER_MILLISECONDS`|
|`INPUT_DEFAULT_OPPOSING_MOST_RECENT`     |`false`      |Default value for "mostRecent" parameters for 2D checkers, sometimes referred to as "Simultaneous Opposing Cardinal Direction" priority              |
|`INPUT_DEFAULT_2D_MOST_RECENT`           |`false`      |Default value for "mostRecent" parameters for opposing checkers, sometimes referred to as "Simultaneous Opposing Cardinal Direction" priority        |
|`INPUT_2D_CLAMP`                         |`true`       |Whether to clamp 2D input to a maximum distance of 1 unit                                                                                            |
|`INPUT_2D_XY_AXIS_BIAS`                  |`0.0`        |The amount of bias for 2D checkers to prefer straight lines along the x- and y-axes. This makes it easier for the player to input exactly horizontal and exactly vertical movement. Value should be from 0 to 1. Higher values make the biasing behavior stronger|
|`INPUT_2D_XY_AXIS_BIAS_DIAGONALS`        |`true`       |Whether the axis bias (see above) should be 8-directional. If set to `false`, 2D checkers will only lock to north/east/south/west directions         |

&nbsp;

## Profiles

`__input_config_profiles()` holds macros that affect profiles. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

|Name                                      |Typical Value  |Purpose                                                                                                                                                      |
|------------------------------------------|---------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_FALLBACK_PROFILE_BEHAVIOR `        |`1`            |Sets the preferred behavior for `input_binding_get()` when a player has no profile. See below for more information                                           |
|`INPUT_AUTO_PROFILE_FOR_KEYBOARD`         |`"keyboard"`   |Profile to use to automatically set up bindings when the player is using the `INPUT_KEYBOARD` source                                                         |
|`INPUT_AUTO_PROFILE_FOR_MOUSE`            |`"mouse"`      |Profile to use to automatically set up bindings when the player is using the `INPUT_MOUSE` source                                                            |
|`INPUT_AUTO_PROFILE_FOR_TOUCH`            |`"touch"`      |Profile to use to automatically set up bindings when the player is using the `INPUT_TOUCH` source                                                            |
|`INPUT_AUTO_PROFILE_FOR_GAMEPAD`          |`"gamepad"`    |Profile to use to automatically set up bindings when the player is using the `INPUT_GAMEPAD[n]` source                                                       |
|`INPUT_AUTO_PROFILE_FOR_MIXED`            |`"mixed"`      |Profile to use to automatically set up bindings when the `INPUT_SOURCE_MODE.MIXED` source mode is in use                                                     |
|`INPUT_AUTO_PROFILE_FOR_MULTIDEVICE`      |`"multidevice"`|Profile to use to automatically set up bindings when the `INPUT_SOURCE_MODE.MULTIDEVICE` source mode is in use                                               |
|`INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER`|`true`         |Whether to treat `INPUT_KEYBOARD` and `INPUT_MOUSE` sources are interchangeable. This "pairs" the two sources together and is the default behavior for Input |
|`INPUT_ALLOW_ASSYMMETRIC_DEFAULT_PROFILES`|`false`        |Whether to allow [default profiles](Profiles) to include different verbs. This is convenient for larger games but is potentially unsafe                      |

When a player has no profile set, `input_binding_get()` has undefined behavior. This typically happens when hotswapping and the player hasn't pressed any buttons/keys/etc. yet. The macro `INPUT_FALLBACK_PROFILE_BEHAVIOR` controls what should happen and can take one of three values:

|Value|Behavior                                                                                                                                            |
|-----|----------------------------------------------------------------------------------------------------------------------------------------------------|
|`0`  |Always return an empty binding if the player has no profile set                                                                                     |
|`1`  |Prefer `INPUT_AUTO_PROFILE_FOR_KEYBOARD` for bindings if on desktop OSs, and use gamepad bindings otherwise                                         |
|`2`  |Prefer `INPUT_AUTO_PROFILE_FOR_GAMEPAD` for bindings                                                                                                |
|`3`  |Prefer `INPUT_AUTO_PROFILE_FOR_KEYBOARD` for bindings if on a desktop OS and no gamepad is connected, otherwise use `INPUT_AUTO_PROFILE_FOR_GAMEPAD`|

&nbsp;

## Hotswap

`__input_config_hotswap()` holds macros that affect hotswapping Input. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

|Name                             |Typical Value   |Purpose                                                                                                                                                                             |
|---------------------------------|----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_HOTSWAP_DELAY`            |`33`            |Number of milliseconds between source swaps when in the [hotswap source mode](Source-Modes?id=input_source_modehotswap). This should be longer than a single frame (>17 ms at 60FPS)|
|`INPUT_HOTSWAP_ON_GAMEPAD_AXIS`  |`true`          |Whether to trigger a hotswap when a gamepad axis is moved                                                                                                                           |
|`INPUT_HOTSWAP_ON_MOUSE_BUTTON`  |`true`          |Whether to trigger a hotswap when a mouse button is pressed                                                                                                                         |
|`INPUT_HOTSWAP_ON_MOUSE_MOVEMENT`|`true`          |Whether to trigger a hotswap when the mouse is moved                                                                                                                                |
|`INPUT_HOTSWAP_AUTO_PROFILE`     |`true`          |Whether to automatically set the profile for player 0 when they hotswap to a new source                                                                                             |

&nbsp;

## Multiplayer

`__input_config_multiplayer()` holds macros that affect multiplayer in Input. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

|Name               |Typical Value|Purpose                                         |
|-------------------|-------------|------------------------------------------------|
|`INPUT_MAX_PLAYERS`|`4`          |Maximum number of players that the game supports|

&nbsp;

## External Data

`__input_config_external_data()` holds macros that affect how Input loads and uses external gamepad data. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

|Name                                   |Typical Value              |Purpose                                                                                                                                                                                                                                                                    |
|---------------------------------------|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_SDL2_REMAPPING`                 |`true`                     |Whether to use Input's own SDL2 database to remap gamepads, overriding the old and crusty database that GameMaker uses internally. Setting this to `false` will cause Input to use GameMaker's native database and, as a result, gamepad mapping data will be less accurate|
|`INPUT_SDL2_ALLOW_EXTERNAL`            |`true`                     |Whether to allow external SDL2 database loading from environment variable `%SDL_GAMECONTROLLERCONFIG%`. This is useful for compatibility with external gamepad mapping software                                                                                            |
|`INPUT_SDL2_ALLOW_EXTENDED`            |`false`                    |Whether to allow use of SDL2's extended bindings, accessed using the [extended `gp_*` constants](Library-Constants?id=extended-gamepad-constants)                                                                                                                          |
|`INPUT_SDL2_ALLOW_NONGAMEPAD_JOYSTICKS`|`false`                    |Whether to allow non-gamepad joysticks to be used. Examples are throttles, flight sticks, skateboards, plastic guitars, and so on                                                                                                                                          |
|`INPUT_SDL2_DATABASE_PATH`             |`"sdl2.txt"`               |Path to the SDL2 database to read gamepad remapping definitions from                                                                                                                                                                                                       |
|`INPUT_CONTROLLER_TYPE_PATH`           |`"controllertypes.csv"`    |Path to the controller type database to read gamepad types from                                                                                                                                                                                                            |
|`INPUT_BLACKLIST_PATH`                 |`"controllerblacklist.csv"`|Path to the controller blacklist database to read from                                                                                                                                                                                                                     |

&nbsp;

## Keyboard

`__input_config_keyboard()` holds macros that affect how Input treats keyboard input. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

|Name                              |Typical Value|Purpose                                                                               |
|----------------------------------|-------------|--------------------------------------------------------------------------------------|
|`INPUT_ANDROID_KEYBOARD_ALLOWED`  |`false`      |Whether to allow keyboard input on Android platform                                   |
|`INPUT_SWITCH_KEYBOARD_ALLOWED`   |`false`      |Whether to allow keyboard input on Switch platform                                    |
|`INPUT_MERGE_CONTROL_KEYS`        |`false`      |Whether to merge control keys, for example Left Shift and Right Shift upon user rebind|
|`INPUT_IGNORE_RESERVED_KEYS_LEVEL`|`2`          |Controls default key filtering behavior. See below                                    |

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

## Mouse

`__input_config_mouse()` holds macros that affect how Input treats mouse input. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

|Name                               |Typical Value|Purpose                                                                                                                                                             |
|-----------------------------------|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_MOUSE_ALLOW_SCANNING`       |`true`       |Whether to allow mouse input to be returned by [`input_binding_scan_start()`]()                                                                                     |
|`INPUT_MOUSE_MOVE_DEADZONE`        |`2`          |Size of the deadzone for detecting mouse movement, measured in pixels. Higher values increase how far the mouse must travel before reporting the mouse as being used|
|`INPUT_MOUSE_ALLOW_VIRTUAL_BUTTONS`|`true`       |Whether the mouse source can be used to interact with virtual buttons                                                                                               |

&nbsp;

## Touch

`__input_config_touch()` holds macros that affect how Input handles touch input and virtual buttons. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

|Name                                 |Typical Value|Purpose                                                                                                                                                                                                  |
|-------------------------------------|-------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_MAX_TOUCHPOINTS`              |`11`         |Maximum number of touch screen points to query. This applies to touch screen devices only (excludes PlayStation)                                                                                         |
|`INPUT_TOUCH_EDGE_DEADZONE`          |`35`         |Margin in pixels around the screen edge where gaining or losing a touch point will not register "pressed" or "released". Prevents false positives when dragging on to or off of the edge of a touchscreen|
|`INPUT_TOUCH_HISTORY_FRAMES`         |`10`         |How many frames of history to record for button that have the feature turned on                                                                                                                          |
|`INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD` |`50`         |Default minimum threshold for dpad- and thumbstick-type virtual buttons. Measures in pixels in GUI-space                                                                                                 |
|`INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD` |`100`        |Default maximum threshold for dpad- and thumbstick-type virtual buttons. Measures in pixels in GUI-space                                                                                                 |
|`INPUT_VIRTUAL_KEYBOARD_AUTOCAPITALIZATION_TYPE` |`kbv_autocapitalize_sentences`|Default [virtual keyboard autocapitalization type](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Virtual_Keys_And_Keyboards/keyboard_virtual_show.htm) used when [displaying the onscreen keyboard](Functions-(Other)#_keyboard_virtual_show)|
|`INPUT_VIRTUAL_KEYBOARD_PREDICTIVE_TEXT_ENABLED` |`false`|Whether to show predictive text when [displaying the onscreen keyboard](Functions-(Other)#_keyboard_virtual_show)                                                                                  |

&nbsp;

## Gamepads

`__input_config_gamepads()` holds macros that affect how Input's gamepads behave. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

|Name                                   |Typical Value          |Purpose                                                                                                                                                                                                                                                                     |
|---------------------------------------|-----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_DEFAULT_AXIS_MIN_THRESHOLD`     |`0.3`                  |Default minimum threshold for directional (thumbstick) axes. This value is used for detecting gamepad input when hotswapping so make sure you set it above 0.0                                                                                                              |
|`INPUT_DEFAULT_AXIS_MAX_THRESHOLD`     |`1.0`                  |Default maximum threshold for directional (thumbstick) axes                                                                                                                                                                                                                 |
|`INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD`  |`0.02`                 |Default minimum threshold for non-directional (trigger) axes. This value is used for detecting gamepad input when hotswapping so make sure you set it above 0.0                                                                                                             |
|`INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD`  |`1.0`                  |Default maximum threshold for non-directional (trigger) axes                                                                                                                                                                                                                |
|`INPUT_SWITCH_SWAP_AB`                 |`false`                |Whether to swap A and B button bindings on Switch gamepads including Joy-Cons. This applies cross-platform                                                                                                                                                                  |
|`INPUT_PS_REGION_SWAP_CONFIRM`         |`false`                |Whether to swap Cross (X) and Circle (O) button bindings per the PlayStation 4 system setting                                                                                                                                                                               |
|`INPUT_SWITCH_HORIZONTAL_HOLDTYPE`     |`true`                 |Whether the game uses the horizontal holdtype for single Joy-Cons. Set this to `false` for vertical holdtype. Input treats these two modes as mutually exclusive (come talk to us if you need to be able to swap at runtime). This macro only applies to the Switch platform|
|`INPUT_PS_TOUCHPAD_ALLOWED`            |`false`                |Whether to allow gamepad touchpad as mouse on PlayStation platforms                                                                                                                                                                                                         |
|`INPUT_SWITCH_JOYCON_MOTION_RIGHT_HAND`|`true`                 |Whether to use the right hand sensor for motion data when using detached dual Joy-Cons as a pair. When `false`, the left hand Joy-Con sensor will be used for motion data instead                                                                                           |
|`INPUT_GYRO_DEFAULT_AXIS_X`            |`INPUT_GYRO.AXIS_YAW`  |Default [`INPUT_GYRO` axis member](Library-Constants?id=Gyro-Axis) for controlling cursor in screenspace X axis                                                                                                                                                             |
|`INPUT_GYRO_DEFAULT_AXIS_Y`            |`INPUT_GYRO.AXIS_PITCH`|Default [`INPUT_GYRO` axis member](Library-Constants?id=Gyro-Axis) for controlling cursor in screenspace Y axis                                                                                                                                                             |
|`INPUT_GYRO_DEFAULT_SENSITIVITY_X`     |`2.0`                  |Default gamepad gyro sensitivity for cursor in screenspace X axis. At `1.0`, 180 degrees in world space covers screen width. Negative value indicate inverted axis                                                                                                          |
|`INPUT_GYRO_DEFAULT_SENSITIVITY_Y`     |`-2.0`                 |Default gamepad gyro sensitivity for cursor in screenspace Y axis. At `1.0`, 180 degrees in world space covers screen height. Negative value indicate inverted axis                                                                                                         |

&nbsp;

## Cursor

`__input_config_cursor()` holds macros that affect how Input's native cursor feature behaves. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

|Name                      |Typical Value|Purpose                                                                                                             |
|--------------------------|-------------|--------------------------------------------------------------------------------------------------------------------|
|`INPUT_CURSOR_VERB_UP`    |`"aim_up"`   |Verb that controls upwards motion for a player's cursor                                                             |
|`INPUT_CURSOR_VERB_DOWN`  |`"aim_down"` |Verb that controls downwards motion for a player's cursor                                                           |
|`INPUT_CURSOR_VERB_LEFT`  |`"aim_left"` |Verb that controls leftwards motion for a player's cursor                                                           |
|`INPUT_CURSOR_VERB_RIGHT` |`"aim_right"`|Verb that controls rightwards motion for a player's cursor                                                          |
|`INPUT_CURSOR_START_SPEED`|`5`          |The default speed for cursors when the game boots up. This can be changed per player with `input_cursor_speed_set()`|
|`INPUT_CURSOR_EXPONENT`   |`1`          |Cursor movement exponent. This is applied when using keyboard and gamepad controls                                  |

&nbsp;

## Vibration

`__input_config_vibration()` holds macros that affect vibration when triggered using Input. This script never needs to be directly called in your code, but the script and the macros it contains must be present in a project for Input to work.

|Name                                   |Typical Value|Purpose                                                                                                                                                                              |
|---------------------------------------|-------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_VIBRATION_DEFAULT_STRENGTH`     |`1.0`        |The default vibration strength. This value can be changed later by using [`input_vibrate_set_strength()`](Functions-(Vibration)?id=vibrate_set_strength)                             |
|`INPUT_VIBRATION_JOYCON_STRENGTH`      |`0.4`        |Joy-Con vibration motors can be a bit, uh, intense. This value allows you to reduce the strength of vibration relative to other platforms                                            |
|`INPUT_TRIGGER_EFFECT_DEFAULT_STRENGTH`|`1.0`        |The default PS5 trigger effect strength. This value can be changed later by using [`input_trigger_effect_set_strength()`](Functions-(Trigger-Effects)?id=trigger_effect_set_strength)|
