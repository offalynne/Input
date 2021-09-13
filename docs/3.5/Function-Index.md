# Function Index

---

### [System](Functions-(System))

- [`input_tick()`](Functions-(System)#input_tick)

### [Players](Functions-(Players))

- [`input_player_connected([playerIndex])`](Functions-(Players)#input_player_connectedplayerindex)
- [`input_players_connected()`](Functions-(Players)#input_players_connected)
- [`input_player_source_set(source, [playerIndex])`](Functions-(Players)#input_player_source_setsource-playerindex)
- [`input_player_source_get([playerIndex])`](Functions-(Players)#input_player_source_getplayerindex)
- [`input_player_gamepad_set(gamepad, [playerIndex])`](Functions-(Players)#input_player_gamepad_setgamepad-playerindex)
- [`input_player_gamepad_get([playerIndex])`](Functions-(Players)#input_player_gamepad_getplayerindex)
- [`input_player_gamepad_get_description([playerIndex])`](Functions-(Players)#input_player_gamepad_get_descriptionplayerindex)
- [`input_player_gamepad_get_type([playerIndex])`](Functions-(Players)#input_player_gamepad_get_typeplayerindex
- [`input_player_gamepad_get_dpad_style([playerIndex])`](Functions-(Players)#input_player_gamepad_get_dpad_styleplayerindex)
- [`input_player_gamepad_get_invalid_bindings([playerIndex])`](Functions-(Players)#input_player_gamepad_get_invalid_bindingsplayerindex)

### [Default Bindings](Functions-(Default-Bindings))

- [`input_default_key(key, verb, [alternate])`](Functions-(Default-Bindings)#input_default_keykey-verb-alternate)
- [`input_default_mouse_button(button, verb, [alternate])`](Functions-(Default-Bindings)#input_default_mouse_buttonbutton-verb-alternate)
- [`input_default_mouse_wheel_up(verb, [alternate])`](Functions-(Default-Bindings)#input_default_mouse_wheel_upverb-alternate)
- [`input_default_mouse_wheel_down(verb, [alternate])`](Functions-(Default-Bindings)#input_default_mouse_wheel_downverb-alternate)
- [`input_default_gamepad_button(button, verb, [alternate])`](Functions-(Default-Bindings)#input_default_gamepad_buttonbutton-verb-alternate)
- [`input_default_gamepad_axis(axis, negative, verb, [alternate])`](Functions-(Default-Bindings)#input_default_gamepad_axisaxis-negative-verb-alternate)
- [`input_default_gamepad_swap_ab(state)`](Functions-(Default-Bindings)#input_default_gamepad_swap_abstate)

?> The following two functions are optional. Please read their description for suggestions for usage

- [`input_default_joycon_button(button, verb, [alternate])`](Functions-(Default-Bindings)#input_default_joycon_buttonbutton-verb-alternate)
- [`input_default_joycon_axis(axis, negative, verb, [alternate])`](Functions-(Default-Bindings)#input_default_joycon_axisaxis-negative-verb-alternate)

### [Checkers](Functions-(Checkers))

- [`input_check(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_checkverb-playerindex-bufferduration)
- [`input_check_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_pressedverb-playerindex-bufferduration)
- [`input_check_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_releasedverb-playerindex-bufferduration)
- [`input_check_repeat(verb, [playerIndex], [delay], [predelay])`](Functions-(Checkers)#input_check_repeatverb-playerindex-delay-predelay)
- [`input_check_double(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_doubleverb-playerindex-bufferduration)
- [`input_check_double_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_double_pressedverb-playerindex-bufferduration)
- [`input_check_double_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_double_releasedverb-playerindex-bufferduration)
- [`input_value(verb, [playerIndex])`](Functions-(Checkers)#input_valueverb-playerindex)
- [`input_is_analogue(verb, [playerIndex])`](Functions-(Checkers)#input_is_analogueverb-playerindex)
- [`input_check_press_most_recent([array], [playerIndex])`](Functions-(Checkers)#input_check_press_most_recentarray-playerindex)

### [2D Checkers](Functions-(2D-Checkers))

- [`input_x(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_xverbleft-verbright-verbup-verbdown-playerindex)
- [`input_y(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_xverbleft-verbright-verbup-verbdown-playerindex)
- [`input_xy(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_yverbleft-verbright-verbup-verbdown-playerindex)
- [`input_direction(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_directionverbleft-verbright-verbup-verbdown-playerindex)
- [`input_distance(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_distanceverbleft-verbright-verbup-verbdown-playerindex)

### [Bindings](Functions-(Bindings))

- [`input_value_is_binding(value)`](Functions-(Bindings)#input_value_is_bindingvalue)
- [`input_binding_scan_tick([source], [playerIndex])`](Functions-(Bindings)#input_binding_scan_ticksource-playerindex)
- [`input_binding_set(verb, binding, [playerIndex], [alternate])`](Functions-(Bindings)#input_binding_setverb-binding-playerindex-alternate)
- [`input_binding_set_safe(verb, binding, [playerIndex], [alternate])`](Functions-(Bindings)#input_binding_set_safeverb-binding-playerindex-alternate)
- [`input_binding_get(verb, [source], [playerIndex], [alternate])`](Functions-(Bindings)#input_binding_getverb-source-playerindex-alternate)
- [`input_binding_get_collisions(binding, [playerIndex])`](Functions-(Bindings)#input_binding_get_collisionsbinding-playerindex)
- [`input_binding_remove(verb, source, [playerIndex], [alternate])`](Functions-(Bindings)#input_binding_removeverb-source-playerindex-alternate)
- [`input_binding_swap(verbA, alternateA, verbB, alternateB, [source], [playerIndex])`](Functions-(Bindings)#input_binding_swapverba-alternatea-verbb-alternateb-source-playerindex)
- [`input_binding_get_name(binding)`](Functions-(Bindings)#input_binding_get_namebinding)

### [Binding System](Functions-(Binding-System))

- [`input_bindings_reset([source], [playerIndex], [resetThresholds])`](Functions-(Binding-System)#input_bindings_resetsource-playerindex-resetthresholds)
- [`input_bindings_write([playerIndex])`](Functions-(Binding-System)#input_bindings_writeplayerindex)
- [`input_bindings_read(string, [playerIndex])`](Functions-(Binding-System)#input_bindings_readstring-playerindex)
- [`input_bindings_copy(source, destination)`](Functions-(Binding-System)#input_bindings_copysource-destination)

### [Source Assignment](Functions-(Source-Assignment))

- [`input_assignment_tick(minPlayers, maxPlayers, leaveVerb)`](Functions-(Source-Assignment)#input_assignment_tickminplayers-maxplayers-leaveverb)
- [`input_hotswap_tick([playerIndex])`](Functions-(Source-Assignment)#input_hotswap_tickplayerindex)
- [`input_source_get_name(source)`](Functions-(Source-Assignment)#input_source_get_namesource)
- [`input_source_detect(source, [gamepad])`](Functions-(Source-Assignment)#input_source_detectsource-gamepad)
- [`input_source_detect_any()`](Functions-(Source-Assignment)#input_source_detect_any)
- [`input_source_is_available(source, [gamepad])`](Functions-(Source-Assignment)#input_source_is_availablesource-gamepad)

### [History](Functions-(History))

- [`input_history_global_include(verb, ...)`](Functions-(History)#input_history_global_includeverb)
- [`input_history_start([playerIndex])`](Functions-(History)#input_history_startplayerindex)
- [`input_history_clear([playerIndex])`](Functions-(History)#input_history_clearplayerindex)
- [`input_history_get([playerIndex])`](Functions-(History)#input_history_getplayerindex)
- [`input_history_end([playerIndex])`](Functions-(History)#input_history_endplayerindex)

### [String](Functions-(String))

?> String functions are provided for handling text input in a device and platform agnostic context, serving as an extension to the inbuilt [`keyboard_string`](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/keyboard_string.htm) value.

- [`input_string_get()`](Functions-(String)#input_string_get)
- [`input_string_set([string])`](Functions-(String)#input_string_setstring)
- [`input_string_async_get(prompt, [string], [allow_empty])`](Functions-(String)#input_string_async_getprompt-string-allow_empty)
- [`input_string_async_is_active()`](Functions-(String)#input_string_async_is_active)
- [`input_string_dialog_async_event()`](Functions-(String)#input_string_dialog_async_event)
- [`input_platform_text_source()`](Functions-(String)#input_platform_text_source)

### [Other](Functions-(Other))

- [`input_axis_threshold_set(axis, min, max, [playerIndex])`](Functions-(Other)#input_axis_threshold_setaxis-min-max-playerindex)
- [`input_axis_threshold_get(axis, [playerIndex])`](Functions-(Other)#input_axis_threshold_getaxis-playerindex)
- [`input_consume(verb, [playerIndex])`](Functions-(Other)#input_consumeverb-playerindex)
- [`input_guess_keyboard_layout()`](Functions-(Other)#input_guess_keyboard_layout)
- [`input_verb_set(verb, value, [playerIndex])`](Functions-(Other)#input_verb_setverb-value-playerindex)
- [`input_ignore_key_add(key)`](Functions-(Other)#input_ignore_key_addkey)
- [`input_ignore_key_remove(key)`](Functions-(Other)#input_ignore_key_removekey)

### [Gamepad (Direct)](Functions-(Gamepad))

?> Gamepad functions are provided for convenience if you want to implement your own features using Input's SDL implementation. In general, [Player functions](Function-Index#players) are the intended way to use Input and are preferred.

- [`input_gamepad_check(gamepadIndex, GMconstant)`](Functions-(Gamepad)#input_gamepad_checkgamepadindex-gmconstant)
- [`input_gamepad_check_pressed(gamepadIndex, GMconstant)`](Functions-(Gamepad)#input_gamepad_check_pressedgamepadindex-gmconstant)
- [`input_gamepad_check_released(gamepadIndex, GMconstant)`](Functions-(Gamepad)#input_gamepad_check_releasedgamepadindex-gmconstant)
- [`input_gamepad_value(gamepadIndex, GMconstant)`](Functions-(Gamepad)#input_gamepad_valuegamepadindex-gmconstant)
- [`input_gamepad_is_axis(gamepadIndex, GMconstant)`](Functions-(Gamepad)#input_gamepad_is_axisgamepadindex-gmconstant)
- [`input_gamepad_is_connected(gamepadIndex)`](Functions-(Gamepad)#input_gamepad_is_connectedgamepadindex)
- [`input_gamepad_get_description(gamepadIndex)`](Functions-(Gamepad)#input_gamepad_get_descriptiongamepadindex)
- [`input_gamepad_get_type(gamepadIndex)`](Functions-(Gamepad)#input_gamepad_get_typegamepadindex)
- [`input_gamepad_get_dpad_style(gamepadIndex)`](Functions-(Gamepad)#input_gamepad_get_dpad_stylegamepadindex)
- [`input_gamepad_gamepad_get_map(gamepadIndex)`](Functions-(Gamepad)#input_gamepad_gamepad_get_mapgamepadindex)
- [`input_gamepad_constant_get_name(constant)`](Functions-(Gamepad)#input_gamepad_constant_get_nameconstant)

### [Keyboard (Direct)](Functions-(Keyboard))

?> Keyboard functions are provided for convenience if you want to implement your own features using Input's keyboard implementation. In general, [Player functions](Function-Index#players) are the intended way to use Input and are preferred.

- [`input_keyboard_check(button)`](Functions-(Keyboard)#input_keyboard_checkkey)
- [`input_keyboard_check_pressed(button)`](Functions-(Keyboard)#input_keyboard_check_pressedkey)
- [`input_keyboard_check_released(button)`](Functions-(Keyboard)#input_keyboard_check_releasedkey)

### [Mouse (Direct)](Functions-(Mouse))

?> Mouse functions are provided for convenience if you want to implement your own features using Input's mouse implementation. In general, [Player functions](Function-Index#players) are the intended way to use Input and are preferred.

- [`input_mouse_check(button)`](Functions-(Mouse)#input_mouse_checkbutton)
- [`input_mouse_check_pressed(button)`](Functions-(Mouse)#input_mouse_check_pressedbutton)
- [`input_mouse_check_released(button)`](Functions-(Mouse)#input_mouse_check_releasedbutton)