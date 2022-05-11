# Quick Reference

&nbsp;

!> If you're using Input 5 on versions of GameMaker **before** 2022.5 (May 2022) then you'll need to call `input_tick()` in the Begin Step event of a persistent instance. This function handles all things Input behind the scenes, it is important to call `input_tick()` once (and only once) each step of your game. A good way to do this is by making `obj_input_manager` [persistent](https://manual.yoyogames.com/#t=The_Asset_Editors%2FObjects.htm), and placing one instance in your first room.

### Setting Up

- [`INPUT_DEFAULT_PROFILES`](Profiles?id=defining-default-profiles)
- [`input_binding_key(key)`](Functions-(Binding-Creators)?id=input_binding_keykey)
- [`input_binding_mouse_button(button)`](Functions-(Binding-Creators)?id=input_binding_mouse_buttonbutton)
- [`input_binding_mouse_wheel_down()`](Functions-(Binding-Creators)?id=input_binding_mouse_wheel_down)
- [`input_binding_mouse_wheel_up()`](Functions-(Binding-Creators)?id=input_binding_mouse_wheel_up)
- [`input_binding_gamepad_button(button)`](Functions-(Binding-Creators)?id=input_binding_gamepad_buttonbutton)
- [`input_binding_gamepad_axis(axis, negative)`](Functions-(Binding-Creators)?id=input_binding_gamepad_axisaxis-negative)

### Checking Verbs

- [`input_check(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_checkverb-playerindex-bufferduration)
- [`input_check_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_pressedverb-playerindex-bufferduration)
- [`input_check_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_releasedverb-playerindex-bufferduration)
- [`input_value(verb, [playerIndex])`](Functions-(Checkers)#input_valueverb-playerindex)
- [`input_x(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_xverbleft-verbright-verbup-verbdown-playerindex)
- [`input_y(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_xverbleft-verbright-verbup-verbdown-playerindex)
- [`input_direction(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_directionverbleft-verbright-verbup-verbdown-playerindex)
- [`input_distance(verbLeft, verbRight, verbUp, verbDown, [playerIndex])`](Functions-(2D-Checkers)#input_distanceverbleft-verbright-verbup-verbdown-playerindex)

### Showing Control Prompts

- [`input_player_get_gamepad_type([playerIndex])`](Functions-(Players)#input_player_gamepad_get_typeplayerindex)
- [`input_binding_get(verb, [playerIndex], [alternate], [profileName])`](Functions-(Binding-Access)?id=input_binding_getverb-playerindex-alternate-profilename)
- [`input_binding_get_name(binding)`](Functions-(Binding-Access)?id=input_binding_get_namebinding)
- 
### Console Compliance

- [`input_players_get_status()`](Functions-(Players)#input_players_get_status)
- [`input_binding_gamepad_swap_ab(state)`](Functions-(Binding-System)?id=input_binding_system_swap_gamepad_abstate)

### Fancy Ways Of Checking Verbs

- [`input_consume(verb, [playerIndex])`](Functions-(Other)#input_consumeverb-playerindex)
- [`input_check_repeat(verb, [playerIndex], [delay], [predelay])`](Functions-(Checkers)#input_check_repeatverb-playerindex-delay-predelay)
- [`input_check_double(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_doubleverb-playerindex-bufferduration)
- [`input_check_double_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_double_pressedverb-playerindex-bufferduration)
- [`input_check_double_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_double_releasedverb-playerindex-bufferduration)
- [`input_check_long(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_longverb-playerindex-bufferduration)
- [`input_check_long_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_long_pressedverb-playerindex-bufferduration)
- [`input_check_long_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_long_releasedverb-playerindex-bufferduration)

### Rebinding

- [`input_player_get_invalid_gamepad_bindings([playerIndex], [profileName])`](Functions-(Players)?id=input_player_get_invalid_gamepad_bindingsplayerindex)
- [`input_value_is_binding(value)`](Functions-(Binding-Creators)#input_value_is_bindingvalue)
- [`input_binding_scan_tick([sourceFilter], [playerIndex])`](Functions-(Binding-Creators)?id=input_binding_scan_ticksource-playerindex)
- [`input_binding_set_safe(verb, binding, [playerIndex], [alternate], [profileName])`](Functions-(Binding-Access)?id=input_binding_set_safeverb-binding-playerindex-alternate-profilename)
- [`input_profile_reset_bindings(profileName, [playerIndex])`](Functions-(Profiles)?id=input_profile_reset_bindingsprofilename-playerindex)
- [`input_bindings_reset([source], [playerIndex], [resetThresholds])`](Functions-(Binding-System)#input_bindings_resetsource-playerindex-resetthresholds)
- [`input_bindings_write([playerIndex])`](Functions-(Binding-System)#input_bindings_writeplayerindex)
- [`input_bindings_read(string, [playerIndex])`](Functions-(Binding-System)#input_bindings_readstring-playerindex)

### Local Multiplayer

- [`input_multiplayer_params_set(min, max, [dropDown])`](Functions-(Players)?id=input_multiplayer_params_setmin-max-dropdown)
- [`input_multiplayer_params_get()`](Functions-(Players)?id=input_multiplayer_params_get)
- [`input_multiplayer_pass()`](Functions-(Players)?id=input_multiplayer_is_finished)
- [`input_source_mode_set(state)`](Functions-(Sources)?id=input_source_mode_setmode)
- [`input_source_mode_get()`](Functions-(Sources)?id=input_source_mode_get)

### Chords and Combos

- [`input_chord_create(name, maxTimeBetweenPresses, verb1, verb2, ...)`](Functions-(Extended-Verbs)?id=input_chord_createname-maxtimebetweenpresses-verb1-verb2-)
- [`input_combo_create(name, [phaseTimeout])`](Functions-(Extended-Verbs)?id=input_combo_createname-phasetimeout)
- [`input_combo_get_phase(name, [playerIndex])`](Functions-(Extended-Verbs)?id=input_combo_get_phaseverb-playerindex)
- [`input_combo_get_phase_count(name)`](Functions-(Extended-Verbs)?id=input_combo_get_phase_countverb)
