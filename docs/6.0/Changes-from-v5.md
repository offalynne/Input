# Changes from Input 5

&nbsp;

Input 6 introduces a number of new features alongside a small number of breaking changes. This page will help you make the jump.

&nbsp;

## New Features

- Input no longer clogs up global namespace
- The layout of folders in the asset browser has been reworked to make it easier to find functions
- `input_tick()` is dead. Long live `input_controller_object`
- Adds `input_verb_get_icon()` as an easier alternative to `input_binding_get_icon()`
- Loading the SDL2 database is now a lot faster when using newer versions of GameMaker (LTS will use the slower legacy code)
- If we cannot find a gamepad in the SDL2 database then we now use the original description rather than `"Unknown"`
- Adds `input_player_gamepad_type_override_set()` (and getter) to force gamepad appearance
- Input now ships with multiple gamepad type macros for easier referencing, such as `INPUT_GAMEPAD_TYPE_XBOX_ONE` and `INPUT_GAMEPAD_TYPE_JOYCON_LEFT`
- `input_source_add()`, `input_source_set()`, and `input_source_share()` now have an optional `exclusive` argument to control whether sources are unassigned when calling these functions (this defaults to `true` to maintain legacy behaviour)
- Adds `input_cursor_limit_boundary()` and expands `input_cursor_limit_get()` to include data for this limit type
- Adds `input_hotswap_params_set()` (and getter)
- `input_multiplayer_params_set()` and getter have been expanded
- `input_binding_scan_params_set()` and getter have been expanded
- The binding scan error code `INPUT_BINDING_SCAN_EVENT.SOURCE_FILTER_EMPTY` has been added
- When scanning for a binding with a source filter enabled, hotswapping is disabled
- Adds `input_verb_group_get_verbs()` and `input_verbs_groups_get()`
- Adds `input_gamepad_map_contains()`
- Adds `input_led_pattern_get()`
- Adds `INPUT_POINTER_TYPE` macro that contains the type of pointer available on the current hardware
- Adds `input_mouse_enabled_set()` (and getter) to control whether the mouse moves the internal cursor
- Adds `input_cursor_dx()` and `input_cursor_dy()`
- Adds `input_cursor_inverted_set()` (and getter)
- Adds `INPUT_WINDOWS_TOUCH_ALLOWED`, `INPUT_WINDOWS_TOUCH_PRIMARY`, `INPUT_SWITCH_TOUCHSCREEN_ALLOWED`, `INPUT_PS_TOUCHPAD_ALLOWED` config macros for finer control over touch behavior per platform
- Adds a secret macro to reduce debug spam from Input shhhh ask if you want to know where it is

&nbsp;

## Breaking Changes

- `input_direction()` now takes a default direction as the first argument, returned when a thumbstick is in a neutral position
- `input_consume()` has been renamed to `input_verb_consume()`
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
- `INPUT_TOUCH_POINTER_ALLOWED` has been renamed to `INPUT_TOUCHSCREEN_USES_MOUSE_SOURCE`

&nbsp;

## Removed Features

- The combo system has been removed
- The deprecated enum value `INPUT_COORD_SPACE.DISPLAY` has now been fully removed (use `INPUT_COORD_SPACE.DEVICE` instead)
- `input_cursor_previous_x()` and `input_cursor_previous_y()` have been removed (conceptually replaced by `input_cursor_dx()` and `input_cursor_dy()`)
