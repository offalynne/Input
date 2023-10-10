# Changes from Input 5

&nbsp;

Input 6 introduces a number of new features alongside a small number of breaking changes. This page will help you understand the differences between the two versions and help guide you towards spotting issues before updating.

&nbsp;

## New Features

- Input no longer clogs up global namespace
- Feather is now disabled for every Input script
- The layout of folders in the asset browser has been reworked to make it easier to find functions
- Hotswapping has been optimised to improve performance in the most common use case for Input
- Hotswapping is also more reliable, including filtering out malfunctioning devices
- Improved device filtering (especially on Android)
- Blacklisted gamepads will no longer report as connected
- Fixes Steam Deck power button sticking
- `input_tick()` is dead. Long live `input_controller_object`
- Adds `input_verb_get_icon()` as an easier alternative to `input_binding_get_icon()`
- Loading the SDL2 database is now a lot faster when using newer versions of GameMaker (LTS will use the slower legacy code)
- If we cannot find a gamepad in the SDL2 database then we now use the original description rather than `"Unknown"`
- Adds a suite of new config macros in `__input_config_general()` to handle Input's behaviour with different sources across all target platforms
- Adds `input_player_gamepad_type_override_set()` (and getter) to force gamepad appearance
- `input_ghost_set()` now accepts the keyword `all` to set the state of all players
- `input_player_connected()` and `input_player_connected()` now have an optional `includeGhost` argument
- Input now ships with multiple gamepad type macros for easier referencing, such as `INPUT_GAMEPAD_TYPE_XBOX_ONE` and `INPUT_GAMEPAD_TYPE_JOYCON_LEFT`
- `input_source_add()`, `input_source_set()`, and `input_source_share()` now have an optional `exclusive` argument to control whether sources are unassigned when calling these functions (this defaults to `true` to maintain legacy behaviour)
- Adds `input_cursor_limit_boundary()` and expands `input_cursor_limit_get()` to include data for this limit type
- Adds `input_hotswap_params_set()` (and getter)
- `input_multiplayer_params_set()` and getter have been expanded
- `input_binding_scan_params_set()` and getter have been expanded
- `INPUT_DEFAULT_2D_MOST_RECENT` and `INPUT_DEFAULT_OPPOSING_MOST_RECENT` have been added to control the default behaviour of 2D checker and opposing checkers respectively
- The binding scan error code `INPUT_BINDING_SCAN_EVENT.SOURCE_FILTER_EMPTY` has been added
- When scanning for a binding with a source filter enabled, hotswapping is disabled
- Adds `input_binding_scan_time_remaining()` to return the amount of time left when scanning for a new binding
- Adds `input_verb_group_get_verbs()` and `input_verbs_groups_get()`
- Adds an additional supported value for `INPUT_FALLBACK_PROFILE_BEHAVIOR` that prioritises gamepad icons if a gamepad is connected (or required, in the case of consoles)
- Adds `input_gamepad_map_contains()`
- Adds `input_gamepad_is_any_connected()`
- Adds `input_led_pattern_get()`
- Adds `input_keyboard_virtual_show()` and `input_keyboard_virtual_hide()` for use on platforms that support it
- Adds `INPUT_POINTER_TYPE` macro that contains the type of pointer available on the current hardware
- Adds `input_cursor_mouse_enabled_set()` (and getter) to control whether the mouse moves the internal cursor
- Adds `input_mouse_enabled_set()` (and getter) to control whether the mouse moves the internal cursor
- Adds `input_cursor_dx()` and `input_cursor_dy()`
- Adds `input_cursor_inverted_set()` (and getter)
- Adds `INPUT_WINDOWS_TOUCH`, `INPUT_SWITCH_TOUCH` config macros for finer control over touch behavior per platform
- Adds `INPUT_ON_MOBILE` `INPUT_ON_PC` `INPUT_ON_STEAM_DECK` `INPUT_ON_CONSOLE` `INPUT_ON_WEB` as read-only constants
- Adds `input_player_active_get()` and `input_player_active_set()` to completely disable player input should you so wish (though you should continue to use "ghost mode" for networked players and AI)
- `input_verb_consume()` can now target all players by using the `all` keyword
- Adds gamepad tester to GameMaker's native debug overlay
- Input is now blocked when GameMaker's native debug overlay is open
- Binding scanner now respect ignore/allow lists when waiting for initial "no input" stage, leading to more reliable binding scanning when using defective or semi-defective devices
- Adds `input_icon_touch()` to handle virtual button bindings for `input_verb_get_icon()` etc.
- Better support for use of `game_restart()` (not that you should be using this highly cursed function)
- Adds a secret macro to reduce debug spam from Input shhhh ask if you want to know where it is

&nbsp;

## Breaking Changes

- Combo system has been reworked entirely
- `input_direction()` now takes a default direction as the first argument, returned when a thumbstick is in a neutral position
- `input_consume()` has been renamed to `input_verb_consume()`
- Setting a binding now consumes every verb to fix edge cases
- `input_cursor_elastic_set()` now defaults to moving the cursor at the same time as moving the elastic point
- `input_xy_quick_pressed()` has been renamed to `input_check_quick_pressed_2d()`
- `input_multiplayer_*()` functions have been renamed to `input_join_*()` to match the name of the source mode
- `INPUT_DEFAULT_PROFILES` has been replaced by `__input_config_verbs()`
- `INPUT_VERB_GROUPS` has been replaced by `__input_config_verb_groups()`
- `INPUT_HOTSWAP_CALLBACK` has been replaced by `input_hotswap_params_set()`
- `INPUT_MULTIPLAYER_LEAVE_VERB` and `INPUT_MULTIPLAYER_ABORT_CALLBACK` have been replaced by extra arguments in `input_join_params_set()`
- `input_icons()` has been removed and replaced with `input_icon_empty()` `input_icon_not_a_binding()` `input_icons_gamepad()` and `input_icons_keyboard_and_mouse()`
- `INPUT_VIBRATION_SWITCH_OS_STRENGTH` has been renamed to `INPUT_VIBRATION_JOYCON_STRENGTH` and will now only affect Joy-Cons (and will work cross-platform too)
- `input_gyro_enabled_set()`, `input_gyro_enabled_get()`, and `input_gyro_params_set()` have been renamed to `input_cursor_gyro…` to better indicate their usage
- `INPUT_TOUCH_POINTER_ALLOWED` has been removed, you may now use the macros in `__input_config_general()` to configure touch and mouse behavior per-platform
- `input_swap_gamepad_ab()` has been removed and replaced with `INPUT_SWITCH_SWAP_AB` (for use cross-platform for Nintendo-style gamepads) and `INPUT_PS_REGION_SWAP_CONFIRM` (which only applies to the PS4 export target specifically)
- Many macros from `__input_config_touch()` and `__input_config_vibration()` have been moved to `__input_config_general()`
- `input_gamepad_get_type()` and `input_player_get_gamepad_type()` can now return `INPUT_GAMEPAD_TYPE_UNKNOWN `

&nbsp;

## Removed Features

- The deprecated enum value `INPUT_COORD_SPACE.DISPLAY` has now been fully removed (use `INPUT_COORD_SPACE.DEVICE` instead)
- `input_cursor_previous_x()` and `input_cursor_previous_y()` have been removed (conceptually replaced by `input_cursor_dx()` and `input_cursor_dy()`)
