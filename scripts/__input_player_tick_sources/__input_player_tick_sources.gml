// Feather disable all
function __input_player_tick_sources(_player)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _current_profile_dict = is_string(__profile_name)? __profiles_dict[$ __profile_name] : undefined;
    
    var _is_multidevice_player = ((_global.__source_mode == INPUT_SOURCE_MODE.MULTIDEVICE) && (__index == 0));
    
    var _v = 0;
    repeat(array_length(_global.__basic_verb_array))
    {
        var _verb_name   = _global.__basic_verb_array[_v];
        var _verb_struct = __verb_state_dict[$ _verb_name];
        
        var _raw           = 0.0;
        var _value         = 0.0;
        var _analogue      = false;
        var _raw_analogue  = false;
        var _min_threshold = 0;
        var _max_threshold = 1;
        
        with(_verb_struct)
        {
            //We've had our value set this frame via a virtual button
            if ((__virtual_value != undefined) && (__virtual_raw_value != undefined) && (__virtual_analogue != undefined))
            {
                _raw   = __virtual_raw_value;
                _value = __virtual_value;
                
                _analogue     = __virtual_analogue;
                _raw_analogue = __virtual_analogue;
                
                _min_threshold = 0;
                _max_threshold = 1;
                
                __virtual_value     = undefined;
                __virtual_raw_value = undefined;
                __virtual_analogue  = undefined;
            }
            
            //We've had our value set this frame via input_verb_set()
            if ((__force_value != undefined) && (__force_analogue != undefined))
            {
                _raw   = __force_value;
                _value = __force_value;
                
                _analogue     = __force_analogue;
                _raw_analogue = __force_analogue;
                
                _min_threshold = 0;
                _max_threshold = 1;
                
                __force_value    = undefined;
                __force_analogue = undefined;
            }
        }
        
        if (_global.__game_input_allowed && is_struct(_current_profile_dict))
        {
            var _s = 0;
            repeat(array_length(__source_array))
            {
                var _source_struct  = __source_array[_s];
                var _source_type    = _source_struct.__source;
                var _source_gamepad = _source_struct.__gamepad;
                    
                var _alternate_array = _current_profile_dict[$ _verb_name];
                    
                switch(_source_type)
                {
                    case __INPUT_SOURCE.KEYBOARD:
                        var _alternate = 0;
                        repeat(INPUT_MAX_ALTERNATE_BINDINGS)
                        {
                            var _binding = _alternate_array[_alternate];
                            switch(_binding.__type)
                            {
                                case __INPUT_BINDING_KEY:
                                    if (keyboard_check(_binding.__value))
                                    {
                                        _value        = 1.0;
                                        _raw          = 1.0;
                                        _analogue     = false;
                                        _raw_analogue = false;
                                    }
                                        
                                    //If we're on Android then check the alternate keyboard key as well
                                    if (__INPUT_ON_ANDROID)
                                    {
                                        if ((_binding.__android_lowercase != undefined) && keyboard_check(_binding.__android_lowercase))
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
                                    
                                case __INPUT_BINDING_MOUSE_BUTTON:
                                    if (!INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER) __input_error("Binding unsupported\nplayer index = ", _player.__index, "\nprofile = ", _player.__profile_name, "\nsource = ", _source_struct, "\nverb = ", _verb_name, "\nalt = ", _alternate, "\nbinding = ", _binding);
                                        
                                    if (input_mouse_check(_binding.__value))
                                    {
                                        _value        = 1.0;
                                        _raw          = 1.0;
                                        _analogue     = false;
                                        _raw_analogue = false;
                                    }
                                break;
                                    
                                case __INPUT_BINDING_MOUSE_WHEEL_UP:
                                    if (!INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER) __input_error("Binding unsupported\nplayer index = ", _player.__index, "\nprofile = ", _player.__profile_name, "\nsource = ", _source_struct, "\nverb = ", _verb_name, "\nalt = ", _alternate, "\nbinding = ", _binding);
                                        
                                    if (mouse_wheel_up())
                                    {
                                        _value        = 1.0;
                                        _raw          = 1.0;
                                        _analogue     = false;
                                        _raw_analogue = false;
                                    }
                                break;
                                    
                                case __INPUT_BINDING_MOUSE_WHEEL_DOWN:
                                    if (!INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER) __input_error("Binding unsupported\nplayer index = ", _player.__index, "\nprofile = ", _player.__profile_name, "\nsource = ", _source_struct, "\nverb = ", _verb_name, "\nalt = ", _alternate, "\nbinding = ", _binding);
                                        
                                    if (mouse_wheel_down())
                                    {
                                        _value        = 1.0;
                                        _raw          = 1.0;
                                        _analogue     = false;
                                        _raw_analogue = false;
                                    }
                                break;
                                    
                                default:
                                    if ((_global.__source_mode != INPUT_SOURCE_MODE.MIXED) && (_global.__source_mode != INPUT_SOURCE_MODE.MULTIDEVICE))
                                    {
                                        __input_error("Binding unsupported\nplayer index = ", _player.__index, "\nprofile = ", _player.__profile_name, "\nsource = ", _source_struct, "\nverb = ", _verb_name, "\nalt = ", _alternate, "\nbinding = ", _binding);
                                    }
                                break;
                            }
                            
                            ++_alternate;
                        }
                    break;
                        
                    case __INPUT_SOURCE.MOUSE:
                        var _alternate = 0;
                        repeat(INPUT_MAX_ALTERNATE_BINDINGS)
                        {
                            var _binding = _alternate_array[_alternate];
                            switch(_binding.__type)
                            {
                                case __INPUT_BINDING_MOUSE_BUTTON:
                                    if (input_mouse_check(_binding.__value))
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
                                    if ((_global.__source_mode != INPUT_SOURCE_MODE.MIXED) && (_global.__source_mode != INPUT_SOURCE_MODE.MULTIDEVICE))
                                    {
                                        __input_error("Binding unsupported\nplayer index = ", _player.__index, "\nprofile = ", _player.__profile_name, "\nsource = ", _source_struct, "\nverb = ", _verb_name, "\nalt = ", _alternate, "\nbinding = ", _binding);
                                    }
                                break;
                            }
                                
                            ++_alternate;
                        }
                    break;
                        
                    case __INPUT_SOURCE.TOUCH:
                    break;
                        
                    case __INPUT_SOURCE.GAMEPAD:
                        if (!input_gamepad_is_connected(_source_gamepad))
                        {
                            ++_s;
                            continue;
                        }
                            
                        var _alternate = 0;
                        repeat(INPUT_MAX_ALTERNATE_BINDINGS)
                        {
                            var _binding = _alternate_array[_alternate];
                                
                            //If we're in multidevice mode, break out of this binding if it doesn't match this gamepad
                            if (_is_multidevice_player && (_binding.__gamepad_index != undefined) && (_source_gamepad != _binding.__gamepad_index)) continue;
                                
                            switch(_binding.__type)
                            {
                                case __INPUT_BINDING_GAMEPAD_BUTTON:
                                    if (_global.__gamepads[_source_gamepad].__get_held(_binding.__value))
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
                                    var _found_raw = _global.__gamepads[_source_gamepad].__get_value(_binding.__value);
                                        
                                    var _binding_threshold_min = _binding.__threshold_min;
                                    var _binding_threshold_max = _binding.__threshold_max;
                                        
                                    if ((_binding_threshold_min == undefined) || (_binding_threshold_max == undefined))
                                    {
                                        var _threshold_struct = __axis_threshold_get(_binding.__value);
                                        _binding_threshold_min = _threshold_struct.__mini;
                                        _binding_threshold_max = _threshold_struct.__maxi;
                                    }
                                        
                                    //Correct the raw value's sign if needed
                                    if (_binding.__axis_negative) _found_raw = -_found_raw;
                                        
                                    //The return value from this binding needs to be corrected using the thresholds previously defined
                                    var _found_value = _found_raw;
                                    _found_value = (_found_value - _binding_threshold_min) / (_binding_threshold_max - _binding_threshold_min);
                                    _found_value = clamp(_found_value, 0.0, 1.0);
                                        
                                    //If this binding is returning a value bigger than whatever we found before, let it override the old value
                                    //This is useful for situations where both the left + right analogue sticks are bound to movement
                                    if (_found_raw > _raw)
                                    {
                                        _raw           = _found_raw;
                                        _raw_analogue  = true;
                                        _min_threshold = _binding_threshold_min;
                                        _max_threshold = _binding_threshold_max;
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
                                    if ((_global.__source_mode != INPUT_SOURCE_MODE.MIXED) && (_global.__source_mode != INPUT_SOURCE_MODE.MULTIDEVICE))
                                    {
                                        __input_error("Binding unsupported\nplayer index = ", _player.__index, "\nprofile = ", _player.__profile_name, "\nsource = ", _source_struct, "\nverb = ", _verb_name, "\nalt = ", _alternate, "\nbinding = ", _binding);
                                    }
                                break;
                            }
                                
                            ++_alternate;
                        }
                    break;
                }
                    
                ++_s;
            }
        }
        
        with(_verb_struct)
        {
            __value = _value;
            __raw   = _raw;
            
            if (_raw_analogue != undefined) __raw_analogue = _raw_analogue;
            if (_analogue     != undefined) __analogue     = _analogue;
            
            __min_threshold = _min_threshold;
            __max_threshold = _max_threshold;
        }
        
        ++_v;
    }
}
