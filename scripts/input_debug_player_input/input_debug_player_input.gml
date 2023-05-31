/// Returns an array that contains bindings for each keyboard key, mouse button, and gamepad
/// button/axis that the player is pressing. This function uses the same ignore/allow/source
/// filter behaviour as the binding scan feature (see input_binding_scan_params_set())
/// 
/// N.B. This function is provided for debug use only and does very little error checking.
///      Use input_binding_scan_start() for player-facing binding scan
/// 
/// @param [playerIndex=0]

function input_debug_player_input(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _result = [];
    
    var _filter_func = function(_input, _ignore_struct, _allow_struct) //Returns <false> if the binding failed to pass the filter
    {
        if (is_struct(_ignore_struct) &&  variable_struct_exists(_ignore_struct, string(_input))) return false;
        if (is_struct(_allow_struct ) && !variable_struct_exists(_allow_struct,  string(_input))) return false;
        return true;
    }
    
    with(_global.__players[_player_index])
    {
        var _source_filter = __rebind_source_filter ?? __source_array;
        
        //Return an empty array if the player is in an invalid state
        if (__source_contains(INPUT_TOUCH, false)) return _result;
        if (array_length(__source_array) <= 0) return _result;
        if (array_length(_source_filter) <= 0) return _result;
        if (__ghost) return _result;
        if (!__active) return _result;
        if (!__connected) return _result;
        
        var _ignore_struct = __rebind_ignore_struct;
        var _allow_struct  = __rebind_allow_struct;
        
        var _i = 0;
        repeat(array_length(_source_filter))
        {
            if (_global.__use_is_instanceof)
            {
                if (!is_instanceof(_source_filter[_i], __input_class_source))
                {
                    __input_error("Value in filter array is not a source (index ", _i, ", ", _source_filter[_i], ")");
                }
            }
            else
            {
                if (instanceof(_source_filter[_i]) != "__input_class_source")
                {
                    __input_error("Value in filter array is not a source (index ", _i, ", ", _source_filter[_i], ")");
                }
            }
            
            with(_source_filter[_i])
            {
                if (self == INPUT_KEYBOARD)
                {
                    if (_global.__any_keyboard_binding_defined)
                    {
                        var _j = __INPUT_KEYCODE_MIN;
                        repeat(1 + (256 - __INPUT_KEYCODE_MIN))
                        {
                            if (_j == 256)
                            {
                                var _keyboard_key = __input_keyboard_key();
                                if (_keyboard_key <= 256) break;
                            }
                            else
                            {
                                var _keyboard_key = _j;
                            }
                            
                            if (keyboard_check(_keyboard_key)
                            && (_keyboard_key >= __INPUT_KEYCODE_MIN) && (_keyboard_key <= __INPUT_KEYCODE_MAX)
                            && !__input_key_is_ignored(_keyboard_key)
                            && _filter_func(_keyboard_key, _ignore_struct, _allow_struct))
                            {
                                //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
                                var _binding = new __input_class_binding();
                                _binding.__set_key(_keyboard_key, true);
                                
                                //On Mac we update the binding label to the actual keyboard character if it is a Basic Latin alphabetic character
                                //This works around problems where a keyboard might be sending a character code for e.g. A but the OS is typing another letter
                                if (__INPUT_ON_MACOS)
                                {
                                    var _keychar = string_upper(keyboard_lastchar);
                                    
                                    //Basic Latin only
                                    if ((ord(_keychar) >= ord("A")) && (ord(_keychar) <= ord("Z")))
                                    {
                                        _binding.__set_label(_keychar);
                                        __input_key_name_set(_keyboard_key, _keychar);    
                                    }
                                }
                                
                                array_push(_result, _binding);
                            }
                            
                            ++_j;
                        }
                    }
                }
                
                if (self == INPUT_MOUSE)
                {
                    if (INPUT_MOUSE_ALLOW_SCANNING)
                    {
                        if (_global.__mouse_allowed && !_global.__window_focus_block_mouse)
                        {
                            if (_filter_func(mb_left, _ignore_struct, _allow_struct)
                            && mouse_check_button(mb_left))
                            {
                                array_push(_result, input_binding_mouse_button(mb_left));
                            }
                            
                            if (_filter_func(mb_middle, _ignore_struct, _allow_struct)
                            &&  mouse_check_button(mb_middle))
                            {
                                array_push(_result, input_binding_mouse_button(mb_middle));
                            }
                            
                            if (_filter_func(mb_right, _ignore_struct, _allow_struct)
                            &&  mouse_check_button(mb_right))
                            {
                                array_push(_result, input_binding_mouse_button(mb_right));
                            }
                            
                            if (_filter_func(mb_side1, _ignore_struct, _allow_struct)
                            &&  mouse_check_button(mb_side1))
                            {
                                array_push(_result, input_binding_mouse_button(mb_side1));
                            }
                            
                            if (_filter_func(mb_side2, _ignore_struct, _allow_struct)
                            &&  mouse_check_button(mb_side2))
                            {
                                array_push(_result, input_binding_mouse_button(mb_side2));
                            }
                        }
                        
                        if (mouse_wheel_up() && _filter_func(__INPUT_BINDING_MOUSE_WHEEL_UP, _ignore_struct, _allow_struct))
                        {
                            array_push(_result, input_binding_mouse_wheel_up());
                        }
                        
                        if (mouse_wheel_down() && _filter_func(__INPUT_BINDING_MOUSE_WHEEL_DOWN, _ignore_struct, _allow_struct))
                        {
                            array_push(_result, input_binding_mouse_wheel_down());
                        }
                    }
                }
                
                if (__source == __INPUT_SOURCE.GAMEPAD)
                {
                    if (_global.__any_gamepad_binding_defined)
                    {
                        //Gamepad buttons and axes
                        var _check_array = [gp_face1,     gp_face2,     gp_face3,      gp_face4, 
                                            gp_padu,      gp_padd,      gp_padl,       gp_padr, 
                                            gp_shoulderl, gp_shoulderr, gp_shoulderlb, gp_shoulderrb,
                                            gp_start,     gp_select,    gp_stickl,     gp_stickr,
                                            gp_axislh,    gp_axislv,    gp_axisrh,     gp_axisrv,    ];
                        
                        //Extended buttons
                        if (INPUT_SDL2_ALLOW_EXTENDED)
                        {
                            array_push(_check_array, gp_guide, gp_misc1, gp_touchpad, gp_paddle1, gp_paddle2, gp_paddle3, gp_paddle4);
                        }
                        
                        var _j = 0;
                        repeat(array_length(_check_array))
                        {
                            var _check = _check_array[_j];
                            if (input_gamepad_is_axis(__gamepad, _check))
                            {
                                var _value = input_gamepad_value(__gamepad, _check);
                                if ((abs(_value) > input_axis_threshold_get(_check, _player_index).mini) && _filter_func(_check, _ignore_struct, _allow_struct))
                                {
                                    var _binding = input_binding_gamepad_axis(_check, (_value < 0));
                                    if (_global.__source_mode == INPUT_SOURCE_MODE.MULTIDEVICE) _binding.__gamepad_set(__gamepad);
                                    array_push(_result, _binding);
                                }
                            }
                            else
                            {
                                if (input_gamepad_check(__gamepad, _check) && _filter_func(_check, _ignore_struct, _allow_struct))
                                {
                                    var _binding = input_binding_gamepad_button(_check);
                                    if (_global.__source_mode == INPUT_SOURCE_MODE.MULTIDEVICE) _binding.__gamepad_set(__gamepad);
                                    array_push(_result, _binding);
                                }
                            }
                            
                            ++_j;
                        }
                    }
                }
            }
            
            ++_i;
        }
    }
    
    return _result;
}