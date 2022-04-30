function __input_player_tick_sources()
{
    var _current_profile_dict = __profiles_dict[$ __profile_name];
    
    var _v = 0;
    repeat(array_length(global.__input_basic_verb_array))
    {
        var _verb_name   = global.__input_basic_verb_array[_v];
        var _verb_struct = __verb_state_dict[$ _verb_name];
        
        var _raw           = 0.0;
        var _value         = 0.0;
        var _analogue      = undefined;
        var _raw_analogue  = undefined;
        var _min_threshold = undefined;
        var _max_threshold = undefined;
        
        with(_verb_struct)
        {
            //We've had our value set this frame via input_verb_set()
            if ((force_value != undefined) && (force_analogue != undefined))
            {
                _raw   = force_value;
                _value = force_value;
                
                _analogue     = force_analogue;
                _raw_analogue = force_analogue;
                
                _min_threshold = 0;
                _max_threshold = 1;
                
                force_value    = undefined;
                force_analogue = undefined;
            }
        }
        
        var _s = 0;
        repeat(array_length(__source_array))
        {
            var _source_struct  = __source_array[_s];
            var _source_type    = _source_struct.source;
            var _source_gamepad = _source_struct.gamepad;
            
            if ((_source_type == INPUT_SOURCE.NONE) || (_source_type == INPUT_SOURCE.GHOST))
            {
                ++_s;
                continue;
            }
            
            var _alternate_array = _current_profile_dict[$ _verb_name];
            
            switch(_source_type)
            {
                case INPUT_SOURCE.KEYBOARD:
                    var _alternate = 0;
                    repeat(INPUT_MAX_ALTERNATE_BINDINGS)
                    {
                        var _binding = _alternate_array[_alternate];
                        switch(_binding.type)
                        {
                            case __INPUT_BINDING_KEY:
                                if (keyboard_check(_binding.value))
                                {
                                    _value        = 1.0;
                                    _raw          = 1.0;
                                    _analogue     = false;
                                    _raw_analogue = false;
                                }
                                
                                //If we're on Android then check the alternate keyboard key as well
                                if (os_type == os_android)
                                {
                                    if ((_binding.android_lowercase != undefined) && keyboard_check(_binding.android_lowercase))
                                    {
                                        _value        = 1.0;
                                        _raw          = 1.0;
                                        _analogue     = false;
                                        _raw_analogue = false;
                                    }
                                }
                            break;
                            
                            case undefined:
                                //Null binding
                            break;
                            
                            default:
                                __input_error("Binding unsupported for keyboard source\n", _binding);
                            break;
                        }
                        
                        ++_alternate;
                    }
                break;
                
                case INPUT_SOURCE.MOUSE:
                    var _alternate = 0;
                    repeat(INPUT_MAX_ALTERNATE_BINDINGS)
                    {
                        var _binding = _alternate_array[_alternate];
                        switch(_binding.type)
                        {
                            case __INPUT_BINDING_MOUSE_BUTTON:
                                if (input_mouse_check(_binding.value))
                                {
                                    _value        = 1.0;
                                    _raw          = 1.0;
                                    _analogue     = false;
                                    _raw_analogue = false;
                                }
                            break;
                            
                            case __INPUT_BINDING_MOUSE_WHEEL_UP:
                                if (mouse_wheel_up())
                                {
                                    _value        = 1.0;
                                    _raw          = 1.0;
                                    _analogue     = false;
                                    _raw_analogue = false;
                                }
                            break;
                            
                            case __INPUT_BINDING_MOUSE_WHEEL_DOWN:
                                if (mouse_wheel_down())
                                {
                                    _value        = 1.0;
                                    _raw          = 1.0;
                                    _analogue     = false;
                                    _raw_analogue = false;
                                }
                            break;
                            
                            case undefined:
                                //Null binding
                            break;
                             
                            default:
                                __input_error("Binding unsupported for mouse source\n", _binding);
                            break;
                        }
                        
                        ++_alternate;
                    }
                break;
                
                case INPUT_SOURCE.GAMEPAD:
                    var _alternate = 0;
                    repeat(INPUT_MAX_ALTERNATE_BINDINGS)
                    {
                        var _binding = _alternate_array[_alternate];
                        switch(_binding.type)
                        {
                            case __INPUT_BINDING_GAMEPAD_BUTTON:
                                if (input_gamepad_check(_source_gamepad, _binding.value))
                                {
                                    _value        = 1.0;
                                    _raw          = 1.0;
                                    _analogue     = false;
                                    _raw_analogue = false;
                                }
                            break;
                            
                            case __INPUT_BINDING_GAMEPAD_AXIS:
                                //Grab the raw value directly from the gamepad
                                //We keep a hold of this value for use in 2D checkers
                                var _found_raw = input_gamepad_value(_source_gamepad, _binding.value);
                                
                                var _axis_threshold = axis_threshold_get(_binding.value);
                                
                                //Correct the raw value's sign if needed
                                if (_binding.axis_negative) _found_raw = -_found_raw;
                                
                                //The return value from this binding needs to be corrected using the thresholds previously defined
                                var _found_value = _found_raw;
                                _found_value = (_found_value - _axis_threshold.mini) / (_axis_threshold.maxi - _axis_threshold.mini);
                                _found_value = clamp(_found_value, 0.0, 1.0);
                                
                                //If this binding is returning a value bigger than whatever we found before, let it override the old value
                                //This is useful for situations where both the left + right analogue sticks are bound to movement
                                if (_found_raw > _raw)
                                {
                                    _raw           = _found_raw;
                                    _raw_analogue  = true;
                                    _min_threshold = _axis_threshold.mini;
                                    _max_threshold = _axis_threshold.maxi;
                                }
                                
                                if (_found_value > _value)
                                {
                                    _value    = _found_value;
                                    _analogue = true;
                                }
                            break;
                            
                            case undefined:
                                //Null binding
                            break;
                            
                            default:
                                __input_error("Binding unsupported for gamepad source\n", _binding);
                            break;
                        }
                        
                        ++_alternate;
                    }
                break;
                
                case INPUT_SOURCE.ALL_GAMEPADS:
                    var _g = 0;
                    repeat(gamepad_get_device_count())
                    {
                        if (input_gamepad_is_connected(_g))
                        {
                            var _alternate = 0;
                            repeat(INPUT_MAX_ALTERNATE_BINDINGS)
                            {
                                var _binding = _alternate_array[_alternate];
                                switch(_binding.type)
                                {
                                    case __INPUT_BINDING_GAMEPAD_BUTTON:
                                        if (input_gamepad_check(_source_gamepad, _binding.value))
                                        {
                                            _value        = 1.0;
                                            _raw          = 1.0;
                                            _analogue     = false;
                                            _raw_analogue = false;
                                        }
                                    break;
                                    
                                    case __INPUT_BINDING_GAMEPAD_AXIS:
                                        //Grab the raw value directly from the gamepad
                                        //We keep a hold of this value for use in 2D checkers
                                        var _found_raw = input_gamepad_value(_source_gamepad, _binding.value);
                                        
                                        var _axis_threshold = axis_threshold_get(_binding.value);
                                        
                                        //Correct the raw value's sign if needed
                                        if (_binding.axis_negative) _found_raw = -_found_raw;
                                        
                                        //The return value from this binding needs to be corrected using the thresholds previously defined
                                        var _found_value = _found_raw;
                                        _found_value = (_found_value - _axis_threshold.mini) / (_axis_threshold.maxi - _axis_threshold.mini);
                                        _found_value = clamp(_found_value, 0.0, 1.0);
                                        
                                        //If this binding is returning a value bigger than whatever we found before, let it override the old value
                                        //This is useful for situations where both the left + right analogue sticks are bound to movement
                                        if (_found_raw > _raw)
                                        {
                                            _raw           = _found_raw;
                                            _raw_analogue  = true;
                                            _min_threshold = _axis_threshold.mini;
                                            _max_threshold = _axis_threshold.maxi;
                                        }
                                        
                                        if (_found_value > _value)
                                        {
                                            _value    = _found_value;
                                            _analogue = true;
                                        }
                                    break;
                                    
                                    case undefined:
                                        //Null binding
                                    break;
                                    
                                    default:
                                        __input_error("Binding unsupported for gamepad source\n", _binding);
                                    break;
                                }
                                
                                ++_alternate;
                            }
                        }
                        
                        ++_g;
                    }
                break;
            }
            
            ++_s;
        }
        
        with(_verb_struct)
        {
            value = _value;
            raw   = _raw;
            
            if (_raw_analogue != undefined) raw_analogue = _raw_analogue;
            if (_analogue     != undefined) analogue     = _analogue;
            
            min_threshold = _min_threshold;
            max_threshold = _max_threshold;
        }
        
        ++_v;
    }
}