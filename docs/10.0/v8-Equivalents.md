# Version 8 Equivalents

Input 10 is a big change. To help ease the transition from Input 8, this page contains a big list of equivalent functions. Some features have been altered significantly or removed and they are indicated as such.

&nbsp;

## Checking Verbs

|Version 8             |Version 10          |
|----------------------|--------------------|
|`input_check`         |`InputCheck`        |
|`input_check_pressed` |`InputCheckPressed` |
|`input_check_released`|`InputCheckReleased`|
|`input_value`         |`InputValue`        |
|`input_is_analogue`   |_removed_           |

&nbsp;

## 2D Checkers

|Version 8            |Version 10      |
|---------------------|----------------|
|`input_direction`    |`InputDirection`|
|`input_distance`     |`InputDistance` |
|`input_x`            |`InputX`        |
|`input_y`            |`InputY`        |
|`input_xy`           |_removed_       |
|`input_radial_sector`|_removed_       |

&nbsp;

## Advanced Checkers

|Version 8                      |Version 10                |
|-------------------------------|--------------------------|
|`input_check_repeat`           |`InputRepeat`             |
|`input_check_double`           |_removed_                 |
|`input_check_double_pressed`   |_removed_                 |
|`input_check_double_released`  |_removed_                 |
|`input_check_long`             |`InputLong`               |
|`input_check_long_pressed`     |`InputLongPressed`        |
|`input_check_long_released`    |`InputLongReleased`       |
|`input_check_quick_pressed`    |_removed_                 |
|`input_check_quick_pressed_2d` |_removed_                 |
|`input_check_opposing`         |`InputOpposing`           |
|`input_check_opposing_repeat`  |`InputOpposingRepeat`     |
|`input_check_opposing_pressed` |`InputOpposingPressed`    |
|`input_held_time`              |Similar to `InputDuration`|
|`input_held_time_released`     |Similar to `InputDuration`|
|`input_check_press_most_recent`|_removed_                 |
|`input_max_value`              |_removed_                 |

&nbsp;

## Further Verb Functions

|Version 8                   |Version 10          |
|----------------------------|--------------------|
|`input_verb_consume`        |`InputVerbConsume`  |
|`input_verb_set`            |`InputPlugInVerbSet`|
|`input_chord_create`        |_removed_           |
|`input_verb_get_group`      |_removed_           |
|`input_verb_group_active`   |_removed_           |
|`input_verb_group_is_active`|_removed_           |
|`input_verb_group_get_verbs`|_removed_           |

&nbsp;

## Binding Creators

?> The binding system has been totally rewritten in Input 10 and special binding creators are no longer necessary. Default bindings are now declared using `InputDefineVerb` which accepts standard GameMaker binding constants (`vk_space`, `gp_face2` etc.). Bindings can be set with `InputBindingSet()` which also accepts standard GameMaker binding constants.

|Version 8                       |Version 10          |
|--------------------------------|--------------------|
|`input_value_is_binding`        |_removed_           |
|`input_binding_empty`           |_removed_           |
|`input_binding_key`             |_removed_           |
|`input_binding_mouse_button`    |_removed_           |
|`input_binding_mouse_wheel_up`  |_removed_           |
|`input_binding_mouse_wheel_down`|_removed_           |
|`input_binding_gamepad_button`  |_removed_           |
|`input_binding_gamepad_axis`    |_removed_           |
|`input_binding_virtual_button`  |_removed_           |

&nbsp;

## Binding Access

|Version 8                      |Version 10           |
|-------------------------------|---------------------|
|`input_binding_is_valid`       |_removed_            |
|`input_binding_set`            |`InputBindingSet`    |
|`input_binding_set_safe`       |`InputBindingSetSafe`|
|`input_binding_get`            |`InputBindingGet`    |
|`input_binding_get_name`       |_removed_            |
|`input_binding_get_source_type`|_removed_            |
|`input_binding_test_collisions`|`InputBindingFind`   |
|`input_binding_remove`         |_removed_            |
|`input_binding_swap`           |`InputBindingSwap`   |
|`input_binding_gamepad_set`    |_removed_            |
|`input_binding_gamepad_get`    |_removed_            |
|`input_binding_threshold_set`  |_removed_            |
|`input_binding_threshold_get`  |_removed_            |
|`input_binding_get_verbs  `    |_removed_            |

&nbsp;

## Binding Scanner

|Version 8                          |Version 10           |
|-----------------------------------|---------------------|
|`input_binding_scan_abort`         |                     |
|`input_binding_scan_in_progress`   |                     |
|`input_binding_scan_time_remaining`|                     |
|`input_binding_scan_params_clear`  |                     |
|`input_binding_scan_params_get`    |                     |
|`input_binding_scan_params_set`    |                     |
|`input_binding_scan_start`         |                     |

&nbsp;

## Icons

?> The binding icon feature has been replaced by the "Binding Icons" plug-in.

|Version 8               |Version 10           |
|------------------------|---------------------|
|`input_binding_get_icon`|`InputIconGetDirect` |
|`input_verb_get_icon`   |`InputIconGet`       |

&nbsp;

## Cursor

?> The cursor functions have been removed in Input 10.

|Version 8                       |Version 10           |
|--------------------------------|---------------------|
|`input_cursor_x`                |_removed_            |
|`input_cursor_y`                |_removed_            |
|`input_cursor_dx`               |_removed_            |
|`input_cursor_dy`               |_removed_            |
|`input_cursor_speed_set`        |_removed_            |
|`input_cursor_speed_get`        |_removed_            |
|`input_cursor_inverted_set`     |_removed_            |
|`input_cursor_inverted_get`     |_removed_            |
|`input_cursor_coord_space_set`  |_removed_            |
|`input_cursor_coord_space_get`  |_removed_            |
|`input_cursor_mouse_enabled_set`|_removed_            |
|`input_cursor_mouse_enabled_get`|_removed_            |

&nbsp;

## Cursor Control

?> The cursor functions have been removed in Input 10.

|Version 8                    |Version 10           |
|-----------------------------|---------------------|
|`input_cursor_set`           |_removed_            |
|`input_cursor_translate`     |_removed_            |
|`input_cursor_limit_aabb`    |_removed_            |
|`input_cursor_limit_circle`  |_removed_            |
|`input_cursor_limit_boundary`|_removed_            |
|`input_cursor_limit_remove`  |_removed_            |
|`input_cursor_limit_get`     |_removed_            |
|`input_cursor_elastic_set`   |_removed_            |
|`input_cursor_elastic_remove`|_removed_            |
|`input_cursor_elastic_get`   |_removed_            |

&nbsp;

## Mouse Capture

?> Mouse capture is a now a native GameMaker feature.

|Version 8                |Version 10           |
|-------------------------|---------------------|
|`input_mouse_capture_set`|_removed_            |
|`input_mouse_capture_get`|_removed_            |

&nbsp;

## Accessibility

?> The accessibility API has been removed in Input 10.

|Version 8                                |Version 10           |
|-----------------------------------------|---------------------|
|`input_axis_threshold_set`               |_removed_            |
|`input_axis_threshold_get`               |_removed_            |
|`input_accessibility_global_toggle_set`  |_removed_            |
|`input_accessibility_global_toggle_get`  |_removed_            |
|`input_accessibility_verb_toggle_set`    |_removed_            |
|`input_accessibility_verb_toggle_get`    |_removed_            |
|`input_accessibility_global_cooldown_set`|_removed_            |
|`input_accessibility_global_cooldown_get`|_removed_            |
|`input_accessibility_verb_cooldown_set`  |_removed_            |
|`input_accessibility_verb_cooldown_get`  |_removed_            |

&nbsp;

## Exporting and Importing

|Version 8             |Version 10           |
|----------------------|---------------------|
|`input_system_reset`  |_removed_            |
|`input_system_export` |_removed_            |
|`input_system_verify` |_removed_            |
|`input_system_import` |_removed_            |
|`input_player_reset`  |`InputBindingsReset` |
|`input_player_export` |`InputBindingsExport`|
|`input_player_verify` |_removed_            |
|`input_player_import` |`InputBindingsImport`|
|`input_player_copy`   |_removed_            |
|`input_profile_export`|_removed_            |
|`input_profile_verify`|_removed_            |
|`input_profile_import`|_removed_            |
|`input_profile_copy`  |_removed_            |

&nbsp;

## Virtual Buttons

|Version 8                  |Version 10              |
|---------------------------|------------------------|
|`input_virtual_create`     |`InputVirtualCreate`    |
|`input_virtual_destroy_all`|`InputVirtualDestroyAll`|
|`input_is_virtual`         |_removed_               |
|`input_virtual_debug_draw` |`InputVirtualCreate`    |

&nbsp;

## Players
   
|Version 8                                  |Version 10                                    |
|-------------------------------------------|----------------------------------------------|
|`input_player_connected`                   |`InputPlayerIsConnected`                      |
|`input_player_connected_count`             |`InputPlayerConnectedCount`                   |
|`input_players_get_status`                 |`InputPlayerGetStatus`                        |
|`input_player_get_gamepad`                 |`InputPlayerGetDevice`                        |
|`input_player_get_gamepad_type`            |`InputPlayerGetGamepadType`                   |
|`input_player_get_invalid_gamepad_bindings`|_removed_                                     |
|`input_player_ghost_set`                   |`InputPlayerSetGhost`                         |
|`input_player_ghost_get`                   |`InputPlayerGetGhost`                         |
|`input_player_swap`                        |`InputPlayerSwap`                             |
|`input_player_gamepad_type_override_set`   |_removed_                                     |
|`input_player_gamepad_type_override_get`   |_removed_                                     |
|`input_player_active_set`                  |`InputPlayerSetBlocked`                       |
|`input_player_active_get`                  |`InputPlayerGetBlocked`                       |
|`input_player_using_gamepad`               |`InputPlayerUsingGamepad`                     |
|`input_player_using_mouse`                 |`InputPlayerUsingKbm`                         |
|`input_player_using_touch`                 |`InputPlayerUsingTouch`                       |
|`input_player_using_keyboard`              |`InputPlayerUsingKbm`                         |
|`input_players_using_source`               |`InputDeviceIsAvailable`                      |
|`input_player_disconnect`                  |`InputPlayerSetDevice` using `INPUT_NO_DEVICE`|

&nbsp;

## Profiles

?> Profiles have largely been removed from Input 10. Players now have two hardcoded profiles - one of keyboard and mouse, and another for gamepad.

|Version 8                     |Version 10              |
|------------------------------|------------------------|
|`input_profile_create`        |_removed_               |
|`input_profile_destroy`       |_removed_               |
|`input_profile_exists`        |_removed_               |
|`input_profile_get_array`     |_removed_               |
|`input_profile_set`           |_removed_               |
|`input_profile_get`           |_removed_               |
|`input_profile_auto`          |_removed_               |
|`input_profile_reset_bindings`|_removed_               |

&nbsp;

## Source Modes

?> Input 10 no longer has the concept of "source modes". The old `.HOTSWAP` source mode has been replaced by a specific [hotswap feature](Functions-(Hotswap)). `.JOIN` source mode has been replaced by the [Party plug-in](Plug-in-Party-Multiplayer).

|Version 8                         |Version 10              |
|----------------------------------|------------------------|
|`input_source_mode_set`           |_removed_               |
|`input_source_mode_get`           |_removed_               |
|`input_hotswap_params_set`        |_removed_               |
|`input_hotswap_params_get`        |_removed_               |
|`input_join_params_set`           |`InputPartySetParams`   |
|`input_join_params_get`           |`InputPartyGetParams`   |
|`input_join_is_finished`          |`InputPartyGetReady`    |