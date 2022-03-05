/// @param source
/// @param [playerIndex]

enum INPUT_BINDING_SCAN_EVENT
{
    SUCCESS_THIS_FRAME          = -1,  //input_binding_scan_tick() has been called twice this frame for this player, and the first execution succeeded
    ERROR_THIS_FRAME            = -2,  //input_binding_scan_tick() has been called twice this frame for this player, and the first execution failed due to an error
    SOURCE_INVALID              = -10, //Player source is not rebindable (is INPUT_SOURCE.NONE)
    //SOURCE_CHANGED              = -11, //Player source changed - No longer used 2021-08-04
    GAMEPAD_CHANGED             = -12, //Gamepad index changed
    GAMEPAD_INVALID             = -13, //Player gamepad is invalid (is INPUT_NO_GAMEPAD)
    BINDING_DOESNT_MATCH_SOURCE = -14, //The new binding doesn't match the source that was targetted for rebinding
    SCAN_TIMEOUT                = -20, //Scanning for a binding timed out - either the player didn't enter a new binding or a stuck key prevented the system from working
    LOST_FOCUS                  = -21, //The game lost focus
}

function input_binding_scan_tick(_source, _player_index = 0)
{
    if (_source == undefined) __input_error("Binding source must be specified");
    
    #region Check input arguments
    
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    #endregion
    
    with(global.__input_players[_player_index])
    {
        global.__input_rebind_last_player = self;
        rebind_this_frame = true;
        
        if (rebind_state == -2)
        {
            return INPUT_BINDING_SCAN_EVENT.SUCCESS_THIS_FRAME;
        }
        else if (rebind_state == -1)
        {
            return INPUT_BINDING_SCAN_EVENT.ERROR_THIS_FRAME;
        }
        else if (rebind_state == 0)
        {
            rebind_state         = 1;
            rebind_gamepad       = gamepad;
            rebind_target_source = _source;
            rebind_start_time    = current_time;
            
            __input_trace("Binding scan started for player ", _player_index, " (target source=", input_source_get_name(rebind_target_source), ", gamepad=", gamepad, ")");
            
            if (source != rebind_target_source)
            {
                __input_trace("Warning! Player not using target source \"", input_source_get_name(rebind_target_source), "\", force-setting their source");
                input_player_source_set(rebind_target_source, _player_index);
            }
        }
        else
        {
            #region Error checking
            
            if (!window_has_focus() || os_is_paused())
            {
                __input_trace("Binding scan failed: Game lost focus");
                rebind_state = -1;
                return INPUT_BINDING_SCAN_EVENT.LOST_FOCUS;
            }
            
            if (rebind_target_source == INPUT_SOURCE.NONE)
            {
                __input_trace("Binding scan failed: Source for player ", _player_index, " is INPUT_SOURCE.NONE");
                rebind_state = -1;
                return INPUT_BINDING_SCAN_EVENT.SOURCE_INVALID;
            }
            
            if ((rebind_target_source == INPUT_SOURCE.GAMEPAD) && (rebind_gamepad != gamepad))
            {
                __input_trace("Binding scan failed: Gamepad for player ", _player_index, " changed (from ", rebind_gamepad, " to ", gamepad, ")");
                rebind_state = -1;
                return INPUT_BINDING_SCAN_EVENT.GAMEPAD_CHANGED;
            }
            
            if ((rebind_target_source == INPUT_SOURCE.GAMEPAD) && (gamepad == INPUT_NO_GAMEPAD))
            {
                __input_trace("Binding scan failed: Gamepad for player ", _player_index, " is INPUT_NO_GAMEPAD");
                rebind_state = -1;
                return INPUT_BINDING_SCAN_EVENT.GAMEPAD_INVALID;
            }
            
            if (current_time - rebind_start_time > INPUT_BINDING_SCAN_TIMEOUT)
            {
                __input_trace("Binding scan failed: Timed out");
                rebind_state = -1;
                    
                return INPUT_BINDING_SCAN_EVENT.SCAN_TIMEOUT;
            }
            
            #endregion
            
            if (rebind_state == 1) //Waiting for the player to release all buttons
            {
                if (!any_input(rebind_target_source))
                {
                    __input_trace("Now scanning for a new binding from player ", _player_index);
                    rebind_state = 2;
                }
            }
            else if (rebind_state == 2) //Now grab the first button pressed
            {
                //Don't scan for bindings if the player is using the wrong source
                if (rebind_target_source != source) return undefined;
                
                var _new_binding = undefined;
                var _binding_source = INPUT_SOURCE.NONE;
                var _keyboard_key = __input_keyboard_key();
                var _mouse_button = __input_mouse_button();
                
                #region Listeners
                
                if (global.__input_keyboard_default_defined 
                && (_keyboard_key >= __INPUT_KEYCODE_MIN) && (_keyboard_key <= __INPUT_KEYCODE_MAX)
                && !__input_key_is_ignored(_keyboard_key))
                {
                    //Keyboard
                    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
                    _new_binding = new __input_class_binding();
                    _new_binding.set_key(_keyboard_key, true);
                    _binding_source = INPUT_SOURCE.KEYBOARD_AND_MOUSE;
                    
                    //On Mac we manually set the binding label to the actual keyboard character if it's an alphabetic symbol
                    //This works around problems where a keyboard might be sending a character code for e.g. A but the OS is typing another letter
                    if (os_type == os_macosx)
                    {
                        __input_trace("Binding label for keycode ", string(ord(_new_binding.label)), ", initially set to \"", _new_binding.label, "\"");
                        var _keychar = string_upper(keyboard_lastchar);
                        
                        //Basic Latin only
                        if ((ord(_keychar) >= ord("A")) && (ord(_keychar) <= ord("Z"))) _new_binding.set_label(_keychar);
                    }
                }
                else if (global.__input_mouse_default_defined && global.__input_mouse_allowed && !global.__input_mouse_blocked
                     && (_mouse_button != mb_none)
                     && (!__INPUT_TOUCH_SUPPORT || (_mouse_button != mb_left))) //GM conflates LMB and touch. Don't rebind
                {
                    //Mouse buttons
                    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
                    _new_binding = new __input_class_binding();
                    _new_binding.set_mouse_button(_mouse_button);
                    _binding_source = INPUT_SOURCE.KEYBOARD_AND_MOUSE;
                }
                else if (global.__input_mouse_default_defined && mouse_wheel_up())
                {
                    //Mouse wheel up
                    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
                    _new_binding = new __input_class_binding();
                    _new_binding.set_mouse_wheel_up();
                    _binding_source = INPUT_SOURCE.KEYBOARD_AND_MOUSE;
                }
                else if (global.__input_mouse_default_defined && mouse_wheel_down())
                {
                    //Mouse wheel down
                    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
                    _new_binding = new __input_class_binding();
                    _new_binding.set_mouse_wheel_down();
                    _binding_source = INPUT_SOURCE.KEYBOARD_AND_MOUSE;
                }
                else if (global.__input_gamepad_default_defined)
                {
                    //Gamepad buttons and axes
                    var _check_array = [gp_face1, gp_face2, gp_face3, gp_face4, 
                                        gp_padu, gp_padd, gp_padl, gp_padr, 
                                        gp_shoulderl, gp_shoulderr, gp_shoulderlb, gp_shoulderrb,
                                        gp_start, gp_select, gp_stickl, gp_stickr,
                                        gp_axislh, gp_axislv, gp_axisrh, gp_axisrv];
                    
                    //Extended buttons
                    if (INPUT_SDL2_ALLOW_EXTENDED)
                    {
                        array_push(_check_array, gp_guide);
                        array_push(_check_array, gp_misc1);
                        array_push(_check_array, gp_touchpad);
                        array_push(_check_array, gp_paddle1);
                        array_push(_check_array, gp_paddle2);
                        array_push(_check_array, gp_paddle3);
                        array_push(_check_array, gp_paddle4);
                    }
                    
                    var _i = 0;
                    repeat(array_length(_check_array))
                    {
                        var _check = _check_array[_i];
                        if (input_gamepad_is_axis(gamepad, _check))
                        {
                            var _value = input_gamepad_value(gamepad, _check);
                            if (abs(_value) > input_axis_threshold_get(_check, _player_index).mini)
                            {
                                //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
                                _new_binding = new __input_class_binding();
                                _new_binding.set_gamepad_axis(_check, (_value < 0));
                                _binding_source = INPUT_SOURCE.GAMEPAD;
                            }
                        }
                        else
                        {
                            if (input_gamepad_check(gamepad, _check))
                            {
                                //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
                                _new_binding = new __input_class_binding();
                                _new_binding.set_gamepad_button(_check);
                                _binding_source = INPUT_SOURCE.GAMEPAD;
                            }
                        }
                        
                        ++_i;
                    }
                }
                
                #endregion
                
                if (is_struct(_new_binding))
                {
                    if (_binding_source != rebind_target_source)
                    {
                        __input_trace("Binding scan failed: New binding source (", input_source_get_name(_binding_source), ") for ", _player_index, " doesn't match desired rebinding source (", input_source_get_name(rebind_target_source), ")");
                        rebind_state = -1;
                        return INPUT_BINDING_SCAN_EVENT.BINDING_DOESNT_MATCH_SOURCE;
                    }
                    else
                    {
                        __input_trace("Binding found for player ", _player_index, ": \"", input_binding_get_name(_new_binding), "\"");
                        rebind_state = -2;
                        return _new_binding;
                    }
                }
            }
        }
    }
    
    return undefined;
}
