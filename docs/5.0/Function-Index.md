# Function Index

&nbsp;

!> If you're using Input 5 on versions of GameMaker **before** 2022.5 (May 2022) then you'll need to call `input_tick()` in the Begin Step event of a persistent instance. This function handles all things Input behind the scenes, it is important to call `input_tick() once (and only once) each step of your game. A good way to do this is by making `obj_input_manager` [persistent](https://manual.yoyogames.com/#t=The_Asset_Editors%2FObjects.htm), and placing one instance in your first room.

### [Players](Functions-(Players))

- [`input_player_connected([playerIndex])`]()
- [`input_player_connected_count()`]()
- [`input_players_get_status()`](Functions-(Players)#input_players_get_status)
- [`input_player_get_gamepad([playerIndex])`](Functions-(Players)#input_player_gamepad_getplayerindex)
- [`input_player_get_gamepad_type([playerIndex])`](Functions-(Players)#input_player_gamepad_get_typeplayerindex)
- [`input_player_get_invalid_gamepad_bindings([playerIndex], [profileName])`]()
- [`input_player_ghost_set(state, [playerIndex])`]()
- [`input_player_ghost_get([playerIndex])`]()
- [`input_multiplayer_params_set(min, max, [dropDown])`]()
- [`input_multiplayer_params_get()`]()
- [`input_multiplayer_pass()`]()

### [Profiles](Functions-(Profiles))

- [`input_profile_reset_bindings(profileName, [playerIndex])`]()
- [`input_profile_auto([playerIndex])`]()
- [`input_profile_set(profileName, [playerIndex])`]()
- [`input_profile_get([playerIndex])`]()
- [`input_profile_create(profileName, [playerIndex])`]()
- [`input_profile_destroy(profileName, [playerIndex])`]()
- [`input_profile_exists(profileName, [playerIndex])`]()
- [`input_profile_get_array([playerIndex])`]()

### [Checkers](Functions-(Checkers))

- [`input_check(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_checkverb-playerindex-bufferduration)
- [`input_check_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_pressedverb-playerindex-bufferduration)
- [`input_check_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_releasedverb-playerindex-bufferduration)
- [`input_check_repeat(verb, [playerIndex], [delay], [predelay])`](Functions-(Checkers)#input_check_repeatverb-playerindex-delay-predelay)
- [`input_check_double(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_doubleverb-playerindex-bufferduration)
- [`input_check_double_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_double_pressedverb-playerindex-bufferduration)
- [`input_check_double_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_double_releasedverb-playerindex-bufferduration)
- [`input_check_long(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_longverb-playerindex-bufferduration)
- [`input_check_long_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_long_pressedverb-playerindex-bufferduration)
- [`input_check_long_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_long_releasedverb-playerindex-bufferduration)
- [`input_value(verb, [playerIndex])`](Functions-(Checkers)#input_valueverb-playerindex)
- [`input_held_time(verb, [playerIndex])`](Functions-(Checkers)#input_held_timeverb-playerIndex)
- [`input_is_analogue(verb, [playerIndex])`](Functions-(Checkers)#input_is_analogueverb-playerindex)
- [`input_check_press_most_recent([array], [playerIndex])`](Functions-(Checkers)#input_check_press_most_recentarray-playerindex)

### [2D Checkers](Functions-(2D-Checkers))

- [`input_x(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_xverbleft-verbright-verbup-verbdown-playerindex)
- [`input_y(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_xverbleft-verbright-verbup-verbdown-playerindex)
- [`input_xy(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_yverbleft-verbright-verbup-verbdown-playerindex)
- [`input_direction(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_directionverbleft-verbright-verbup-verbdown-playerindex)
- [`input_distance(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_distanceverbleft-verbright-verbup-verbdown-playerindex)

### [Extended Verbs](Functions-(Extended-Verbs))

- [`input_chord_create(name, maxTimeBetweenPresses, verb1, verb2, ...)`]()
- [`input_combo_create(name, [phaseTimeout])`]()
- [`input_combo_get_phase(name, [playerIndex])`]()
- [`input_combo_get_phase_count(name)`]()

### [Binding Creators](Functions-(Binding-Creators))

- [`input_value_is_binding(value)`](Functions-(Binding-Creators)#input_value_is_bindingvalue)
- [`input_binding_empty()`]()
- [`input_binding_key(key)`]()
- [`input_binding_mouse_button(button)`]()
- [`input_binding_mouse_wheel_down()`]()
- [`input_binding_mouse_wheel_up()`]()
- [`input_binding_gamepad_button(button)`]()
- [`input_binding_gamepad_axis(axis, negative)`]()
- [`input_binding_scan_tick([sourceFilter], [playerIndex])`]()

### [Binding Access](Functions-(Binding-Access))

- [`input_binding_is_valid(binding, [playerIndex])`]()
- [`input_binding_set(verb, binding, [playerIndex], [alternate], [profileName])`]()
- [`input_binding_set_safe(verb, binding, [playerIndex], [alternate], [profileName])`]()
- [`input_binding_get(verb, [playerIndex], [alternate], [profileName])`]()
- [`input_binding_test_collisions(verb, binding, [playerIndex], [profileName])`]()
- [`input_binding_remove(verb, [playerIndex], [alternate], [profileName])`]()
- [`input_binding_swap(verbA, alternateA, verbB, alternateB, [playerIndex], [profileName])`]()
- [`input_binding_get_name(binding)`]()

### [Binding System](Functions-(Binding-System))

- [`input_bindings_reset([source], [playerIndex], [resetThresholds])`](Functions-(Binding-System)#input_bindings_resetsource-playerindex-resetthresholds)
- [`input_bindings_write([playerIndex])`](Functions-(Binding-System)#input_bindings_writeplayerindex)
- [`input_bindings_read(string, [playerIndex])`](Functions-(Binding-System)#input_bindings_readstring-playerindex)
- [`input_bindings_copy(source, destination)`](Functions-(Binding-System)#input_bindings_copysource-destination)
- [`input_binding_system_swap_gamepad_ab(state)`](Functions-(Binding-System)#input_binding_system_swap_gamepad_abstate)

### [Verbs](Functions-(Verbs))

- [`input_consume(verb, [playerIndex])`](Functions-(Other)#input_consumeverb-playerindex)
- [`input_verb_set(verb, value, [playerIndex])`](Functions-(Other)#input_verb_setverb-value-playerindex)
- [`input_verb_get_groups(verb)`](Functions-(Verbs)?id=input_verb_get_groupsverb)
- [`input_verb_group_active(verbGroup, state, [playerIndex])`](Functions-(Verbs)?id=input_verb_group_activeverbgroup-state-playerindex)
- [`input_verb_group_is_active(verbGroup, [playerIndex])`](Functions-(Verbs)?id=input_verb_group_is_activeverbgroup-playerindex)

### [Sources](Functions-(Sources))

- [`input_source_mode_set(state)`]()
- [`input_source_mode_get()`]()
- [`input_source_detect_input(source)`](Functions-(Sources)#input_source_detectsource-gamepad)
- [`input_source_detect_new()`](Functions-(Sources)#input_source_detect_any)
- [`input_source_set(source, [playerIndex], [autoProfile])`]()
- [`input_source_add(source, [playerIndex])`]()
- [`input_source_share(source, arrayOfPlayerIndexes, [autoProfile])`]()
- [`input_source_clear([playerIndex])`]()
- [`input_source_using(source, [playerIndex])`]()
- [`input_source_get_array([playerIndex])`]()
- [`input_source_is_available(source, [gamepad])`](Functions-(Sources)#input_source_is_availablesource-gamepad)

### [Other](Functions-(Other))

- [`input_tick()`]()
- [`input_axis_threshold_set(axis, min, max, [playerIndex])`](Functions-(Other)#input_axis_threshold_setaxis-min-max-playerindex)
- [`input_axis_threshold_get(axis, [playerIndex])`](Functions-(Other)#input_axis_threshold_getaxis-playerindex)
- [`input_ignore_key_add(key)`](Functions-(Other)#input_ignore_key_addkey)
- [`input_ignore_key_remove(key)`](Functions-(Other)#input_ignore_key_removekey)
- [`input_clear_momentary(state)`](Functions-(Other)#input_clear_momentarystate)
- [`input_guess_keyboard_layout()`](Functions-(Other)#input_guess_keyboard_layout)
- [`input_platform_text_source()`]()

### [Gamepad (Direct)](Functions-(Gamepad))

?> Gamepad functions are provided for convenience if you want to implement your own features using Input's SDL implementation. In general, [Player functions](Function-Index#players) are the intended way to use Input and are preferred.

- [`input_gamepad_check(gamepadIndex, GMconstant)`](Functions-(Gamepad)#input_gamepad_checkgamepadindex-gmconstant)
- [`input_gamepad_check_pressed(gamepadIndex, GMconstant)`](Functions-(Gamepad)#input_gamepad_check_pressedgamepadindex-gmconstant)
- [`input_gamepad_check_released(gamepadIndex, GMconstant)`](Functions-(Gamepad)#input_gamepad_check_releasedgamepadindex-gmconstant)
- [`input_gamepad_value(gamepadIndex, GMconstant)`](Functions-(Gamepad)#input_gamepad_valuegamepadindex-gmconstant)
- [`input_gamepad_is_axis(gamepadIndex, GMconstant)`](Functions-(Gamepad)#input_gamepad_is_axisgamepadindex-gmconstant)
- [`input_gamepad_is_connected(gamepadIndex)`](Functions-(Gamepad)#input_gamepad_is_connectedgamepadindex)
- [`input_gamepad_disconnected()`](Functions-(Gamepad)#input_gamepad_disconnected)
- [`input_gamepad_get_button_color(gamepadIndex, GMconstant)`](Functions-(Gamepad)#input_gamepad_get_button_colorgamepadindex-gmconstant)
- [`input_gamepad_get_button_label(gamepadIndex, GMconstant)`](Functions-(Gamepad)#input_gamepad_get_button_labelgamepadindex-gmconstant)
- [`input_gamepad_get_description(gamepadIndex)`](Functions-(Gamepad)#input_gamepad_get_descriptiongamepadindex)
- [`input_gamepad_get_type(gamepadIndex)`](Functions-(Gamepad)#input_gamepad_get_typegamepadindex)
- [`input_gamepad_get_dpad_style(gamepadIndex)`](Functions-(Gamepad)#input_gamepad_get_dpad_stylegamepadindex)
- [`input_gamepad_gamepad_get_map(gamepadIndex)`](Functions-(Gamepad)#input_gamepad_gamepad_get_mapgamepadindex)
- [`input_gamepad_constant_get_name(constant)`](Functions-(Gamepad)#input_gamepad_constant_get_nameconstant)
- [`input_gamepads_get_status()`](Functions-(Gamepad)#input_gamepads_get_status)

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
- [`input_mouse_x()`](Functions-(Mouse)#input_mouse_x)
- [`input_mouse_y()`](Functions-(Mouse)#input_mouse_y)
- [`input_mouse_moved()`](Functions-(Mouse)#input_mouse_moved)
- [`input_mouse_transform_function_set()`]()
- [`input_mouse_transform_function_get()`]()
