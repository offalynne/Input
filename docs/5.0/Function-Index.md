# Full Function Index

&nbsp;

!> If you're using Input 5 on versions of GameMaker **before** 2022.5 (May 2022) then you'll need to call `input_tick()` in the Begin Step event of a persistent instance. This function handles all things Input behind the scenes, it is important to call `input_tick()` once (and only once) each step of your game. A good way to do this is by making `obj_input_manager` [persistent](https://manual.yoyogames.com/#t=The_Asset_Editors%2FObjects.htm), and placing one instance in your first room.

&nbsp;

## [Players](Functions-(Players))

- [`input_player_connected([playerIndex])`](Functions-(Players)?id=input_player_connectedplayerindex)
- [`input_player_connected_count()`](Functions-(Players)?id=input_players_connected)
- [`input_players_get_status()`](Functions-(Players)#input_players_get_status)
- [`input_player_get_gamepad([playerIndex], [binding])`](Functions-(Players)#input_player_gamepad_getplayerindex-binding)
- [`input_player_get_gamepad_type([playerIndex], [binding])`](Functions-(Players)#input_player_gamepad_get_typeplayerindex-binding)
- [`input_player_get_invalid_gamepad_bindings([playerIndex], [profileName])`](Functions-(Players)?id=input_player_get_invalid_gamepad_bindingsplayerindex)
- [`input_player_ghost_set(state, [playerIndex])`](Functions-(Players)?id=input_player_ghost_setstate-playerindex)
- [`input_player_ghost_get([playerIndex])`](Functions-(Players)?id=input_player_ghost_getplayerindex)
- [`input_player_swap(playerIndexA, playerIndexB)`](Functions-(Players)?id=input_player_swapplayerindexa-playerindexb)
- [`input_multiplayer_params_set(min, max, [dropDown])`](Functions-(Players)?id=input_multiplayer_params_setmin-max-dropdown)
- [`input_multiplayer_params_get()`](Functions-(Players)?id=input_multiplayer_params_get)
- [`input_multiplayer_is_finished()`](Functions-(Players)?id=input_multiplayer_is_finished)

&nbsp;

## [Profiles](Functions-(Profiles))

- [`input_profile_reset_bindings(profileName, [playerIndex])`](Functions-(Profiles)?id=input_profile_reset_bindingsprofilename-playerindex)
- [`input_profile_auto([playerIndex])`](Functions-(Profiles)?id=input_profile_autoplayerindex)
- [`input_profile_set(profileName, [playerIndex])`](Functions-(Profiles)?id=input_profile_setprofilename-playerindex)
- [`input_profile_get([playerIndex])`](Functions-(Profiles)?id=input_profile_getplayerindex)
- [`input_profile_create(profileName, [playerIndex])`](Functions-(Profiles)?id=input_profile_createprofilename-playerindex)
- [`input_profile_destroy(profileName, [playerIndex])`](Functions-(Profiles)?id=input_profile_destroyprofilename-playerindex)
- [`input_profile_exists(profileName, [playerIndex])`](Functions-(Profiles)?id=input_profile_existsprofilename-playerindex)
- [`input_profile_get_array([playerIndex])`](Functions-(Profiles)?id=input_profile_get_arrayplayerindex)

&nbsp;

## [Checkers](Functions-(Checkers))

- [`input_check(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_checkverb-playerindex-bufferduration)
- [`input_check_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_pressedverb-playerindex-bufferduration)
- [`input_check_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_releasedverb-playerindex-bufferduration)
- [`input_check_repeat(verb, [playerIndex], [delay], [predelay])`](Functions-(Checkers)#input_check_repeatverb-playerindex-delay-predelay)
- [`input_check_repeat_opposing(verbNegative, verbPositive, [playerIndex], [mostRecent], [delay], [predelay])`](Functions-(Checkers)#input_check_repeat_opposingverbnegative-verbpositive-playerindex-mostrecent-delay-predelay)
- [`input_check_double(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_doubleverb-playerindex-bufferduration)
- [`input_check_double_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_double_pressedverb-playerindex-bufferduration)
- [`input_check_double_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_double_releasedverb-playerindex-bufferduration)
- [`input_check_long(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_longverb-playerindex-bufferduration)
- [`input_check_long_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_long_pressedverb-playerindex-bufferduration)
- [`input_check_long_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_long_releasedverb-playerindex-bufferduration)
- [`input_check_opposing(verbNegative, verbPositive, [playerIndex], [mostRecent])`](Functions-(Checkers)?id=input_check_opposingverbnegative-verbpositive-playerindex-mostrecent)
- [`input_value(verb, [playerIndex])`](Functions-(Checkers)#input_valueverb-playerindex)
- [`input_held_time(verb, [playerIndex])`](Functions-(Checkers)#input_held_timeverb-playerIndex)
- [`input_is_analogue(verb, [playerIndex])`](Functions-(Checkers)#input_is_analogueverb-playerindex)
- [`input_check_press_most_recent([array], [playerIndex])`](Functions-(Checkers)#input_check_press_most_recentarray-playerindex)

&nbsp;

## [2D Checkers](Functions-(2D-Checkers))

- [`input_x(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`](Functions-(2D-Checkers)#input_xverbleft-verbright-verbup-verbdown-playerindex-mostrecent)
- [`input_y(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`](Functions-(2D-Checkers)#input_xverbleft-verbright-verbup-verbdown-playerindex-mostrecent)
- [`input_xy(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`](Functions-(2D-Checkers)#input_yverbleft-verbright-verbup-verbdown-playerindex-mostrecent)
- [`input_direction(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`](Functions-(2D-Checkers)#input_directionverbleft-verbright-verbup-verbdown-playerindex-mostrecent)
- [`input_distance(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`](Functions-(2D-Checkers)#input_distanceverbleft-verbright-verbup-verbdown-playerindex-mostrecent)

&nbsp;

## [Extended Verbs](Functions-(Extended-Verbs))

- [`input_chord_create(name, maxTimeBetweenPresses, verb1, verb2, ...)`](Functions-(Extended-Verbs)?id=input_chord_createname-maxtimebetweenpresses-verb1-verb2-)
- [`input_combo_create(name, [phaseTimeout])`](Functions-(Extended-Verbs)?id=input_combo_createname-phasetimeout)
- [`input_combo_get_phase(name, [playerIndex])`](Functions-(Extended-Verbs)?id=input_combo_get_phaseverb-playerindex)
- [`input_combo_get_phase_count(name)`](Functions-(Extended-Verbs)?id=input_combo_get_phase_countverb)

&nbsp;

## [Binding Creators](Functions-(Binding-Creators))

- [`input_value_is_binding(value)`](Functions-(Binding-Creators)#input_value_is_bindingvalue)
- [`input_binding_empty()`](Functions-(Binding-Creators)?id=input_binding_empty)
- [`input_binding_key(key)`](Functions-(Binding-Creators)?id=input_binding_keykey)
- [`input_binding_mouse_button(button)`](Functions-(Binding-Creators)?id=input_binding_mouse_buttonbutton)
- [`input_binding_mouse_wheel_down()`](Functions-(Binding-Creators)?id=input_binding_mouse_wheel_down)
- [`input_binding_mouse_wheel_up()`](Functions-(Binding-Creators)?id=input_binding_mouse_wheel_up)
- [`input_binding_gamepad_button(button)`](Functions-(Binding-Creators)?id=input_binding_gamepad_buttonbutton)
- [`input_binding_gamepad_axis(axis, negative)`](Functions-(Binding-Creators)?id=input_binding_gamepad_axisaxis-negative)
- [`input_binding_scan_start(successCallback, [failureCallback], [sourceFilter], [playerIndex])`](Functions-(Binding-Creators)?id=input_binding_scan_startsuccesscallback-failurecallback-sourcefilter-playerindex)
- [`input_binding_scan_abort([playerIndex])`](Functions-(Binding-Creators)?id=input_binding_scan_abortplayerindex)
- [`input_binding_scan_in_progress([playerIndex])`](Functions-(Binding-Creators)?id=input_binding_scan_in_progressplayerindex)

&nbsp;

## [Binding Access](Functions-(Binding-Access))

- [`input_binding_is_valid(binding, [playerIndex])`](Functions-(Binding-Access)?id=input_binding_is_validbinding-playerindex)
- [`input_binding_set(verb, binding, [playerIndex], [alternate], [profileName])`](Functions-(Binding-Access)?id=input_binding_setverb-binding-playerindex-alternate-profilename)
- [`input_binding_set_safe(verb, binding, [playerIndex], [alternate], [profileName])`](Functions-(Binding-Access)?id=input_binding_set_safeverb-binding-playerindex-alternate-profilename)
- [`input_binding_get(verb, [playerIndex], [alternate], [profileName])`](Functions-(Binding-Access)?id=input_binding_getverb-playerindex-alternate-profilename)
- [`input_binding_test_collisions(verb, binding, [playerIndex], [profileName])`](Functions-(Binding-Access)?id=input_binding_test_collisionsverb-binding-playerindex-profilename)
- [`input_binding_remove(verb, [playerIndex], [alternate], [profileName])`](Functions-(Binding-Access)?id=input_binding_removeverb-playerindex-alternate-profilename)
- [`input_binding_swap(verbA, alternateA, verbB, alternateB, [playerIndex], [profileName])`](Functions-(Binding-Access)?id=input_binding_swapverba-alternatea-verbb-alternateb-source-playerindex-profilename)
- [`input_binding_get_name(binding)`](Functions-(Binding-Access)?id=input_binding_get_namebinding)

&nbsp;

## [Verbs](Functions-(Verbs))

- [`input_consume(verb, [playerIndex])`](Functions-(Other)#input_consumeverb-playerindex)
- [`input_verb_set(verb, value, [playerIndex])`](Functions-(Other)#input_verb_setverb-value-playerindex)
- [`input_verb_get_groups(verb)`](Functions-(Verbs)?id=input_verb_get_groupsverb)
- [`input_verb_group_active(verbGroup, state, [playerIndex])`](Functions-(Verbs)?id=input_verb_group_activeverbgroup-state-playerindex)
- [`input_verb_group_is_active(verbGroup, [playerIndex])`](Functions-(Verbs)?id=input_verb_group_is_activeverbgroup-playerindex)

&nbsp;

## [Sources](Functions-(Sources))

- [`input_source_mode_set(state)`](Functions-(Sources)?id=input_source_mode_setmode)
- [`input_source_mode_get()`](Functions-(Sources)?id=input_source_mode_get)
- [`input_source_detect_input(source)`](Functions-(Sources)#input_source_detect_inputsource-gamepad)
- [`input_source_detect_new()`](Functions-(Sources)#input_source_detect_new)
- [`input_source_set(source, [playerIndex], [autoProfile])`](Functions-(Sources)?id=input_source_setsource-playerindex-autoprofile)
- [`input_source_add(source, [playerIndex])`](Functions-(Sources)?id=input_source_addsource-playerindex)
- [`input_source_share(source, arrayOfPlayerIndexes, [autoProfile])`](Functions-(Sources)?id=input_source_sharesource-playerindex-autoprofile)
- [`input_source_clear([playerIndex])`](Functions-(Sources)?id=input_source_clearplayerindex)
- [`input_source_using(source, [playerIndex])`](Functions-(Sources)?id=input_source_usingsource-playerindex)
- [`input_source_get_array([playerIndex])`](Functions-(Sources)?id=input_source_get_arrayplayerindex)
- [`input_source_is_available(source, [gamepad])`](Functions-(Sources)#input_source_is_availablesource-gamepad)

&nbsp;

## [Cursor](Functions-(Cursor))

- [`input_cursor_x([playerIndex])`](Functions-(Cursor)?id=input_cursor_xplayerindex)
- [`input_cursor_y([playerIndex])`](Functions-(Cursor)?id=input_cursor_yplayerindex)
- [`input_cursor_set(x, y, [playerIndex], [relative])`](Functions-(Cursor)?id=input_cursor_setx-y-playerindex-relative)
- [`input_cursor_speed_set(speed, [playerIndex])`](Functions-(Cursor)?id=input_cursor_speed_setspeed-playerindex)
- [`input_cursor_speed_get([playerIndex])`](Functions-(Cursor)?id=input_cursor_speed_getplayerindex)
- [`input_cursor_coord_space_set(coordSpace, [playerIndex])`](Functions-(Cursor)?id=input_cursor_coord_space_setcoordspace-playerindex)
- [`input_cursor_coord_space_get([playerIndex])`](Functions-(Cursor)?id=input_cursor_coord_space_getplayerindex)
- [`input_cursor_limit_aabb(left, top, right, bottom, [playerIndex])`](Functions-(Cursor)?id=input_cursor_limit_aabbleft-top-right-bottom-playerindex)
- [`input_cursor_limit_circle(x, y, radius, [playerIndex])`](Functions-(Cursor)?id=input_cursor_limit_circlex-y-radius-playerindex)
- [`input_cursor_limit_remove([playerIndex])`](Functions-(Cursor)?id=input_cursor_limit_removeplayerindex)
- [`input_cursor_limit_get([playerIndex])`](Functions-(Cursor)?id=input_cursor_limit_getplayerindex)
- [`input_cursor_elastic_set(x, y, strength, [playerIndex])`](Functions-(Cursor)?id=input_cursor_elastic_setx-y-strength-playerindex)
- [`input_cursor_elastic_remove([playerIndex])`](Functions-(Cursor)?id=input_cursor_elastic_removeplayerindex)
- [`input_cursor_elastic_get([playerIndex])`](Functions-(Cursor)?id=input_cursor_elastic_getplayerindex)

&nbsp;

## [Accessibility](Functions-(Accessibility))

- [`input_accessibility_global_toggle_set(state)`](Functions-(Accessibility)?id=input_accessibility_global_toggle_setstate)
- [`input_accessibility_global_toggle_get()`](Functions-(Accessibility)?id=input_accessibility_global_toggle_get)
- [`input_accessibility_verb_toggle_set(verb, state)`](Functions-(Accessibility)?id=input_accessibility_verb_toggle_setverb-state)
- [`input_accessibility_verb_toggle_get(verb)`](Functions-(Accessibility)?id=input_accessibility_verb_toggle_getverb)

&nbsp;

## [Exporting and Importing](Functions-(Exporting-and-Importing))

- [`input_system_reset()`](Functions-(Exporting-and-Importing)?id=input_system_reset)
- [`input_system_export([outputString], [prettify])`](Functions-(Exporting-and-Importing)?id=input_system_exportoutputstring-prettify)
- [`input_system_import(stringOrStruct)`](Functions-(Exporting-and-Importing)?id=input_system_importstringorstruct)
- [`input_player_reset([playerIndex])`](Functions-(Exporting-and-Importing)?id=input_player_resetplayerindex)
- [`input_player_export([playerIndex], [outputString], [prettify])`](Functions-(Exporting-and-Importing)?id=input_player_exportplayerindex-outputstring-prettify)
- [`input_player_import(stringOrStruct, [playerIndex])`](Functions-(Exporting-and-Importing)?id=input_player_importstringorstruct-playerindex)
- [`input_player_copy(playerIndexSrc, playerIndexDst)`](Functions-(Exporting-and-Importing)?id=input_player_copyplayerindexsrc-playerindexdst)
- [`input_profile_export(profileName, [playerIndex], [outputString], [prettify])`](Functions-(Exporting-and-Importing)?id=input_profile_exportprofilename-playerindex-outputstring-prettify)
- [`input_profile_import(stringOrStruct, profileName, [playerIndex])`](Functions-(Exporting-and-Importing)?id=input_profile_importstringorstruct-profilename-playerindex)
- [`input_profile_copy(playerIndexSrc, profileNameSrc, playerIndexDst, profileNameDst)`](Functions-(Exporting-and-Importing)?id=input_profile_copyplayerindexsrc-profilenamesrc-playerindexdst-profilenamedst)

&nbsp;

## [Other](Functions-(Other))

- [`input_tick()`](Functions-(Other)?id=input_tick)
- [`input_axis_threshold_set(axis, min, max, [playerIndex])`](Functions-(Other)#input_axis_threshold_setaxis-min-max-playerindex)
- [`input_axis_threshold_get(axis, [playerIndex])`](Functions-(Other)#input_axis_threshold_getaxis-playerindex)
- [`input_ignore_key_add(key)`](Functions-(Other)#input_ignore_key_addkey)
- [`input_ignore_key_remove(key)`](Functions-(Other)#input_ignore_key_removekey)
- [`input_clear_momentary(state)`](Functions-(Other)#input_clear_momentarystate)
- [`input_swap_gamepad_ab(state)`](Functions-(Binding-System)#input_swap_gamepad_abstate)

&nbsp;

## [Mouse (Direct)](Functions-(Mouse))

- [`input_mouse_capture_set(state, [sensitivity])`](Functions-(Mouse)?id=input_mouse_capture_setstate-sensitivity)
- [`input_mouse_capture_get()`](Functions-(Mouse)?id=input_mouse_capture_get)
- [`input_mouse_x()`](Functions-(Mouse)#input_mouse_x)
- [`input_mouse_y()`](Functions-(Mouse)#input_mouse_y)
- [`input_mouse_dx()`](Functions-(Mouse)#input_mouse_dx)
- [`input_mouse_dy()`](Functions-(Mouse)#input_mouse_dy)
- [`input_mouse_moved()`](Functions-(Mouse)#input_mouse_moved)
- [`input_mouse_coord_space_set(coordSpace)`](Functions-(Mouse)?id=input_mouse_coord_space_setcoordspace)
- [`input_mouse_coord_space_get()`](Functions-(Mouse)?id=input_mouse_coord_space_get)

?> The following mouse functions are provided for convenience if you want to implement your own features using Input's mouse implementation. In general, [verbs](Verbs-and-Bindings) are the intended way to use Input and are preferred.

- [`input_mouse_check(button)`](Functions-(Mouse)#input_mouse_checkbutton)
- [`input_mouse_check_pressed(button)`](Functions-(Mouse)#input_mouse_check_pressedbutton)
- [`input_mouse_check_released(button)`](Functions-(Mouse)#input_mouse_check_releasedbutton)

&nbsp;

## [Gamepad (Direct)](Functions-(Gamepad))

?> Gamepad functions are provided for convenience if you want to implement your own features using Input's SDL implementation. In general, [verbs](Verbs-and-Bindings) are the intended way to use Input and are preferred.

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

&nbsp;

## [Keyboard (Direct)](Functions-(Keyboard))

?> Keyboard functions are provided for convenience if you want to implement your own features using Input's keyboard implementation. In general, [verbs](Verbs-and-Bindings) are the intended way to use Input and are preferred.

- [`input_keyboard_check(button)`](Functions-(Keyboard)#input_keyboard_checkkey)
- [`input_keyboard_check_pressed(button)`](Functions-(Keyboard)#input_keyboard_check_pressedkey)
- [`input_keyboard_check_released(button)`](Functions-(Keyboard)#input_keyboard_check_releasedkey)
