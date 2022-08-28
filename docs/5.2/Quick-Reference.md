# Quick Reference

&nbsp;

?> This is a partial overview of the functions that Input offers you. There is plenty more that Input can do; for a complete rundown please see the [Full Function Index](Function-Index).

&nbsp;

## Setting Up

- [`INPUT_DEFAULT_PROFILES`](Profiles?id=defining-default-profiles)
- [`input_binding_key(key)`](Functions-(Binding-Creators)?id=input_binding_keykey)
- [`input_binding_mouse_button(button)`](Functions-(Binding-Creators)?id=input_binding_mouse_buttonbutton)
- [`input_binding_mouse_wheel_down()`](Functions-(Binding-Creators)?id=input_binding_mouse_wheel_down)
- [`input_binding_mouse_wheel_up()`](Functions-(Binding-Creators)?id=input_binding_mouse_wheel_up)
- [`input_binding_gamepad_button(button)`](Functions-(Binding-Creators)?id=input_binding_gamepad_buttonbutton)
- [`input_binding_gamepad_axis(axis, negative)`](Functions-(Binding-Creators)?id=input_binding_gamepad_axisaxis-negative)

!> If you're using Input 5 on versions of GameMaker **before** 2022.5 (May 2022) then you'll need to call `input_tick()` in the Begin Step event of a persistent instance. This function handles all things Input behind the scenes, it is important to call `input_tick()` once (and only once) each step of your game. A good way to do this is by making `obj_input_manager` [persistent](https://manual.yoyogames.com/#t=The_Asset_Editors%2FObjects.htm), and placing one instance in your first room.

&nbsp;

## Checking Verbs

- [`input_check(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_checkverb-playerindex-bufferduration)
- [`input_check_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_pressedverb-playerindex-bufferduration)
- [`input_check_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_releasedverb-playerindex-bufferduration)
- [`input_value(verb, [playerIndex])`](Functions-(Checkers)#input_valueverb-playerindex)
- [`input_x(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`](Functions-(2D-Checkers)#input_xverbleft-verbright-verbup-verbdown-playerindex-mostrecent)
- [`input_y(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`](Functions-(2D-Checkers)#input_xverbleft-verbright-verbup-verbdown-playerindex-mostrecent)
- [`input_direction(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`](Functions-(2D-Checkers)#input_directionverbleft-verbright-verbup-verbdown-playerindex-mostrecent)
- [`input_distance(verbLeft, verbRight, verbUp, verbDown, [playerIndex], [mostRecent])`](Functions-(2D-Checkers)#input_distanceverbleft-verbright-verbup-verbdown-playerindex-mostrecent)

&nbsp;

## Showing Control Prompts

- [`input_player_get_gamepad_type([playerIndex], [binding])`](Functions-(Players)#input_player_get_gamepad_typeplayerindex-binding)
- [`input_binding_get(verb, [playerIndex], [alternate], [profileName])`](Functions-(Binding-Access)?id=input_binding_getverb-playerindex-alternate-profilename)
- [`input_binding_get_name(binding)`](Functions-(Binding-Access)?id=input_binding_get_namebinding)

&nbsp;

## Local Multiplayer

- [`input_multiplayer_params_set(min, max, [dropDown])`](Functions-(Players)?id=input_multiplayer_params_setmin-max-dropdown)
- [`input_multiplayer_params_get()`](Functions-(Players)?id=input_multiplayer_params_get)
- [`input_multiplayer_is_finished()`](Functions-(Players)?id=input_multiplayer_is_finished)
- [`input_source_mode_set(state)`](Functions-(Sources)?id=input_source_mode_setmode)
- [`input_source_mode_get()`](Functions-(Sources)?id=input_source_mode_get)

&nbsp;

## Console Compliance

- [`input_players_get_status()`](Functions-(Players)#input_players_get_status)
- [`input_binding_gamepad_swap_ab(state)`](Functions-(Gamepad)?id=input_swap_gamepad_abstate)

&nbsp;

## Fancy Ways To Use Verbs

- [`input_consume(verb, [playerIndex])`](Functions-(Verbs)#input_consumeverb-playerindex)
- [`input_check_repeat(verb, [playerIndex], [delay], [predelay])`](Functions-(Checkers)#input_check_repeatverb-playerindex-delay-predelay)
- [`input_check_double(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_doubleverb-playerindex-bufferduration)
- [`input_check_double_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_double_pressedverb-playerindex-bufferduration)
- [`input_check_double_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_double_releasedverb-playerindex-bufferduration)
- [`input_check_long(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_longverb-playerindex-bufferduration)
- [`input_check_long_pressed(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_long_pressedverb-playerindex-bufferduration)
- [`input_check_long_released(verb, [playerIndex], [bufferDuration])`](Functions-(Checkers)#input_check_long_releasedverb-playerindex-bufferduration)

&nbsp;

## Rebinding

- [`input_binding_scan_start(successCallback, [failureCallback], [sourceFilter], [playerIndex])`](Functions-(Binding-Creators)?id=input_binding_scan_startsuccesscallback-failurecallback-sourcefilter-playerindex)
- [`input_binding_scan_abort([playerIndex])`](Functions-(Binding-Creators)?id=input_binding_scan_abortplayerindex)
- [`input_binding_scan_in_progress([playerIndex])`](Functions-(Binding-Creators)?id=input_binding_scan_in_progressplayerindex)
- [`input_binding_set_safe(verb, binding, [playerIndex], [alternate], [profileName])`](Functions-(Binding-Access)?id=input_binding_set_safeverb-binding-playerindex-alternate-profilename)
- [`input_profile_reset_bindings(profileName, [playerIndex])`](Functions-(Profiles)?id=input_profile_reset_bindingsprofilename-playerindex)
- [`input_system_export([outputString], [prettify])`](Functions-(Exporting-and-Importing)?id=input_system_exportoutputstring-prettify)
- [`input_system_import(stringOrStruct)`](Functions-(Exporting-and-Importing)?id=input_system_importstringorstruct)

&nbsp;

## Chords and Combos

- [`input_chord_create(name, maxTimeBetweenPresses, verb1, verb2, ...)`](Functions-(Extended-Verbs)?id=input_chord_createname-maxtimebetweenpresses-verb1-verb2-)
- [`input_combo_create(name, [phaseTimeout])`](Functions-(Extended-Verbs)?id=input_combo_createname-phasetimeout)
- [`input_combo_get_phase(name, [playerIndex])`](Functions-(Extended-Verbs)?id=input_combo_get_phaseverb-playerindex)
- [`input_combo_get_phase_count(name)`](Functions-(Extended-Verbs)?id=input_combo_get_phase_countverb)
