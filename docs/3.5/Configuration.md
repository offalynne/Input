# Configuration

---

Compile time configuration is controlled by macros stored in `__input_config()` This script holds a number of macros that customise the behaviour of Input. `__input_config()` never needs to be directly called in code, but the script and the macros it contains must be present in a project for Input to work.

?> You should edit this script to customise Input for your own purposes.

|Name                                      |Typical Value            |Purpose                                                                                                                                               |
|------------------------------------------|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
|`INPUT_MAX_PLAYERS`                       |`4`                      |Maximum number of players that the game supports                                                                                                      |
|`INPUT_MAX_ALTERNATE_BINDINGS`            |`2`                      |Maximum number of alternate bindings per verb per input source                                                                                        |
|`INPUT_DEFAULT_MIN_THRESHOLD`             |`0.3`                    |Default minimum threshold for gamepad axes. This value is used for detecting gamepad input in [`input_hotswap_tick()`](Functions-(Source-Assignment)#input_hotswap_tickplayerindex) so make sure you set it above `0.0`|
|`INPUT_DEFAULT_MAX_THRESHOLD`             |`1.0`                    |Default maximum threshold for gamepad axes                                                                                                            |
|`INPUT_2D_CLAMP`                          |`true`                   |Whether to clamp [2D input](Functions-(2D-Checkers)) to a maximum distance of 1 unit                                                                  |
|`INPUT_TIMER_MILLISECONDS`                |`false`                  |Set to `true` to use milliseconds instead of frames for [`input_check_*()`](Functions-(Checker)) functions                                            |
|`INPUT_REPEAT_DEFAULT_DELAY`              |`10`                     |Default time between re-triggers for [`input_check_repeat()`](Functions-(Checkers)#input_check_repeatverb-playerindex-delay-predelay)                 |
|`INPUT_REPEAT_DEFAULT_PREDELAY`           |`30`                     |Default time before the first re-trigger for [`input_check_repeat()`](Functions-(Checkers)#input_check_repeatverb-playerindex-delay-predelay)         |
|`INPUT_DOUBLE_DELAY`                      |`12`                     |Delay between key presses for it to register as a double press. Whether this is in frames or milliseconds is controlled by `INPUT_TIMER_MILLISECONDS` |
|`INPUT_HISTORY_LENGTH`                    |`20`                     |Maximum number of verb events to record. Each event is a struct containing the time, verb name, and verb value                                        |
|`INPUT_HOTSWAP_DELAY`                     |`200`                    |Number of milliseconds between source swaps when using [`input_hotswap_tick()`](Functions-(Source-Assignment)#input_hotswap_tickplayerindex). This should be longer than a single frame (>17 ms at 60FPS)|
|`INPUT_HOTSWAP_ON_GAMEPAD_AXIS`           |`true`                   |Whether to trigger a hotswap when a gamepad axis is moved                                                                                             |
|`INPUT_HOTSWAP_ON_MOUSE_MOVEMENT`         |`true`                   |Whether to trigger a hotswap when the mouse is moved                                                                                                  |
|`INPUT_MOUSE_MODE`                        |`0`                      |What coordinate system to use for the mouse position. `0` = view-space, `1` = GUI-space, `2` = device-space                                           |
|`INPUT_MOUSE_MOVE_DEADZONE`               |`2`                      |Size of the deadzone for detecting mouse movement, measured in pixels                                                                                 |
|`INPUT_SDL2_REMAPPING`                    |`true`                   |Whether to use our own SDL2 database to remap controllers                                                                                             |
|`INPUT_SDL2_ALLOW_EXTERNAL`               |`true`                   |Whether to allow external SDL2 database loading from environment variable `%SDL_GAMECONTROLLERCONFIG%`                                                |
|`INPUT_SDL2_ALLOW_GUIDE`                  |`false`                  |Whether to allow use of SDL2's "guide" binding, accessed using Input's custom `gp_guide` macro. This generally only works with DInput controllers     |
|`INPUT_SDL2_ALLOW_MISC1`                  |`false`                  |Whether to allow use of SDL2's "misc1" binding, accessed using Input's custom `gp_misc1` macro. What this maps to varies from controller to controller|
|`INPUT_BINDING_SCAN_TIMEOUT`              |`10000`                  |Time (in milliseconds) to wait for a new binding before automatically cancelling the binding scan                                                     |
|`INPUT_SWITCH_HORIZONTAL_HOLDTYPE`        |`true`                   |Whether the game uses the horizontal holdtype for single Joy-Cons. Set this to `false` for vertical holdtype. Input treats these two modes as mutually exclusive (come talk to us if you need to be able to swap at runtime)|
|`INPUT_IGNORE_RESERVED_KEYS_LEVEL`        |`2`                      |Controls default key filtering behaviour. See below                                                                                                   |
|`INPUT_SDL2_DATABASE_PATH`                |`sdl2.txt`               |Path to the SDL2 database to read gamepad remapping definitions from                                                                                  |
|`INPUT_CONTROLLER_TYPE_PATH`              |`controllertypes.csv`    |Path to the controller type database to read gamepad types from                                                                                       |
|`INPUT_BLACKLIST_PATH`                    |`controllerblacklist.csv`|Path to the controller blacklist database to read from                                                                                                |

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
    - IME keys (0x15 to 0x1A, 0xE5)
    - Browser keys (0xA6 to 0xAC)
    - Media keys (0xAD to 0xB7)


You can modify this list at any time by calling [`input_ignore_key_add()`](Functions-(Other)#input_ignore_key_addkey) or [`input_ignore_key_remove()`](Functions-(Other)#input_ignore_key_removekey). This setting only affects Input and will not filter keys from native GameMaker functions.
