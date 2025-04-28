# Version 8 Equivalents

Input 10 is a big change. To help ease the transition from Input 8, this page contains a big list of equivalent functions. Some features have been altered significantly or removed and they are indicated as such.

&nbsp;

## Checking Verbs

|Version 8             |Version 10     |
|----------------------|---------------|
|`input_check`         |`InputCheck`   |
|`input_check_pressed` |`InputPressed` |
|`input_check_released`|`InputReleased`|
|`input_value`         |`InputValue`   |
|`input_is_analogue`   |_removed_      |

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
|`input_check_press_last`       |_removed_                 |
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

?> Rebinding in Input 10 operates per device rather than per player. Input 10 requires that you call `InputDeviceGetRebindingResult()` to return the result of rebinding rather than waiting for a callback as in Input 8.

|Version 8                          |Version 10               |
|-----------------------------------|-------------------------|
|`input_binding_scan_abort`         |`InputDeviceSetRebinding` or `InputDeviceStopAllRebinding`|
|`input_binding_scan_in_progress`   |`InputDeviceGetRebinding`|
|`input_binding_scan_time_remaining`|_removed_                |
|`input_binding_scan_params_clear`  |_removed_                |
|`input_binding_scan_params_get`    |_removed_                |
|`input_binding_scan_params_set`    |_removed_                |
|`input_binding_scan_start`         |`InputDeviceSetRebinding`|

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

?> The information that Input 10 needs to store between gameplay sessions a lot simpler than previous versions. Importing and exporting system-level and profile-level data is now the same thing as player bindings.

|Version 8             |Version 10           |
|----------------------|---------------------|
|`input_system_reset`  |`InputBindingsReset` |
|`input_system_export` |`InputBindingsExport`|
|`input_system_verify` |_removed_            |
|`input_system_import` |`InputBindingsImport`|
|`input_player_reset`  |`InputBindingsReset` |
|`input_player_export` |`InputBindingsExport`|
|`input_player_verify` |_removed_            |
|`input_player_import` |`InputBindingsImport`|
|`input_player_copy`   |_removed_            |
|`input_profile_export`|`InputBindingsExport`|
|`input_profile_verify`|_removed_            |
|`input_profile_import`|`InputBindingsImport`|
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

?> Profiles have largely been removed from Input 10. Players now have two hardcoded profiles - one for keyboard and mouse, and another for gamepads. You should use `InputBindingsImport()` and `InputBindingsExport()` to replicate the old profile feature.

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

&nbsp;

## Vibration

?> Vibration functionality has been moved out of the core library and into the [Vibration plug-in](Plug-in-Vibration).

|Version 8                   |Version 10               |
|----------------------------|-------------------------|
|`input_vibrate_constant`    |`InputVibrateConstant`   |
|`input_vibrate_adsr`        |`InputVibrateADSR`       |
|`input_vibrate_pulse`       |`InputVibratePulse`      |
|`input_vibrate_curve`       |`InputVibrateCurve`      |
|`input_vibrate_stop`        |`InputVibrateStop`       |
|`input_vibrate_set_pause`   |`InputVibrateStPause`    |
|`input_vibrate_get_pause`   |`InputVibrateGetPause`   |
|`input_vibrate_set_strength`|`InputVibrateSetStrength`|
|`input_vibrate_get_strength`|`InputVibrateGetStrength`|

&nbsp;

## Color

?> Color functionality has been moved out of the core library and into the [Color plug-in](Plug-in-Color).

|Version 8          |Version 10       |
|-------------------|-----------------|
|`input_color_get`  |`InputColorGet`  |
|`input_color_set`  |`InputColorSet`  |
|`input_color_reset`|`InputColorReset`|

&nbsp;

## Gyro & Motion

?> Gyro and motion functionality has been moved out of the core library and into the [Gyro & Motion plug-in](Plug-in-Gyro-Motion).

|Version 8                      |Version 10       |
|-------------------------------|-----------------|
|`input_motion_data_get`        |`InputMotionGet` |
|`input_cursor_gyro_enabled_get`|_removed_        |
|`input_cursor_gyro_enabled_set`|_removed_        |
|`input_cursor_gyro_params_get` |_removed_        |
|`input_cursor_gyro_params_set` |_removed_        |

&nbsp;

## Trigger Effects

?> Trigger effect functionality has been moved out of the core library and into the [Trigger Effect plug-in](Plug-in-Trigger-Effects).

|Version 8                          |Version 10                     |
|-----------------------------------|-------------------------------|
|`input_trigger_effect_off`         |`InputTriggerEffectOff`        |
|`input_trigger_effect_feedback`    |`InputTriggerEffectFeedback`   |
|`input_trigger_effect_vibration`   |`InputTriggerEffectVibration`  |
|`input_trigger_effect_weapon`      |`InputTriggerEffectWeapon`     |
|`input_trigger_effect_get_state`   |`InputTriggerEffectGetState`   |
|`input_trigger_effect_set_pause`   |`InputTriggerEffectSetPause`   |
|`input_trigger_effect_get_pause`   |`InputTriggerEffectGetPause`   |
|`input_trigger_effect_set_strength`|`InputTriggerEffectSetStrength`|
|`input_trigger_effect_get_strength`|`InputTriggerEffectGetStrength`|

&nbsp;

## Other

|Version 8                    |Version 10|
|-----------------------------|----------|
|`input_clear_momentary`      |Manual update functionality replaced by `InputManualCollect()` and `InputManualUpdate()`|
|`input_ignore_key_add`       |_removed_ |
|`input_ignore_key_remove`    |_removed_ |
|`input_debug_player_input`   |_removed_ |
|`input_debug_all_input`      |_removed_ |
|`input_game_has_focus`       |`InputGameHasFocus`|
|`input_keyboard_virtual_show`|_removed_ |
|`input_keyboard_virtual_hide`|_removed_ |
|`input_gamepad_tester_get`   |_removed_ |
|`input_gamepad_tester_set`   |_removed_ |

&nbsp;

## Mouse (Direct)

|Version 8                    |Version 10                                                 |
|-----------------------------|-----------------------------------------------------------|
|`input_mouse_x`              |`InputMouseRoomX` `InputMouseGuiX` `InputMouseDeviceX`     |
|`input_mouse_y`              |`InputMouseRoomY` `InputMouseGuiY` `InputMouseDeviceY`     |
|`input_mouse_dx`             |_removed_                                                  |
|`input_mouse_dy`             |_removed_                                                  |
|`input_mouse_moved`          |_removed_                                                  |
|`input_mouse_coord_space_set`|Replaced by coordinate space-specific functions (see above)|
|`input_mouse_coord_space_get`|_removed_                                                  |
|`input_mouse_check`          |`InputMouseCheck`                                          |
|`input_mouse_check_pressed`  |`InputMousePressed`                                        |
|`input_mouse_check_released` |`InputMouseReleased`                                       |
|`input_mouse_in_bounds`      |_removed_                                                  |
|`input_mouse_wheel_up`       |Can now use native GameMaker constant `m_scroll_up`        |
|`input_mouse_wheel_down`     |Can now use native GameMaker constant `m_scroll_down`      |

&nbsp;

## Gamepads (Direct)

?> The direct gamepad API has largely been removed in Input 10.

|Version 8                        |Version 10                  |
|---------------------------------|----------------------------|
|`input_gamepad_check`            |_removed_                   |
|`input_gamepad_check_pressed`    |_removed_                   |
|`input_gamepad_check_released`   |_removed_                   |
|`input_gamepad_value`            |`InputDeviceGetGamepadValue`|
|`input_gamepad_delta`            |_removed_                   |
|`input_gamepad_is_axis`          |_removed_                   |
|`input_gamepad_is_connected`     |`InputDeviceIsConnected`    |
|`input_gamepad_is_any_connected` |_removed_                   |
|`input_gamepad_get_description`  |`InputDeviceGetDescription` |
|`input_gamepad_get_type`         |`InputDeviceGetGamepadType` |
|`input_gamepad_get_map`          |_removed_                   |
|`input_gamepad_map_contains`     |_removed_                   |
|`input_gamepad_constant_get_name`|_removed_                   |
|`input_gamepads_get_status`      |_removed_                   |
|`input_led_pattern_get`          |_removed_                   |

&nbsp;

## Keyboard (Direct)

?> The direct keyboard API has been removed in Input 10.

|Version 8                      |Version 10                  |
|-------------------------------|----------------------------|
|`input_keyboard_check`         |_removed_                   |
|`input_keyboard_check_pressed` |_removed_                   |
|`input_keyboard_check_released`|_removed_                   |
