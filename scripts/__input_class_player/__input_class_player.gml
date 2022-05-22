function __input_class_player() constructor
{
    source          = INPUT_SOURCE.NONE;
    gamepad         = INPUT_NO_GAMEPAD;
    sources         = array_create(INPUT_SOURCE.__SIZE, undefined);
    verbs           = {};
    last_input_time = -1;
    cursor          = new __input_class_cursor();
    
    rebind_state      = 0;
    rebind_source     = undefined;
    rebind_gamepad    = undefined;
    rebind_verb       = undefined;
    rebind_alternate  = undefined;
    rebind_this_frame = false;
    rebind_backup_val = undefined;
    
    //This struct is the one that gets serialized/deserialized
    config = { axis_thresholds : {} };
    
    /// @param axis
    /// @param min
    /// @param max
    static axis_threshold_set = function(_axis, _min, _max)
    {
        var _axis_struct = config.axis_thresholds[$ _axis];
        if (!is_struct(_axis_struct))
        {
            _axis_struct = {};
            config.axis_thresholds[$ _axis] = _axis_struct;
        }
        
        _axis_struct.mini = _min
        _axis_struct.maxi = _max;
        return _axis_struct;
    }
    
    /// @param axis
    static axis_threshold_get = function(_axis)
    {
        var _struct = config.axis_thresholds[$ _axis];
        if (is_struct(_struct)) return _struct;
        
        if (__input_axis_is_directional(_axis))
        {
            return axis_threshold_set(_axis, INPUT_DEFAULT_AXIS_MIN_THRESHOLD, INPUT_DEFAULT_AXIS_MAX_THRESHOLD);
        }
        else
        {
            return axis_threshold_set(_axis, INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD, INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD);
        }
    }
    
    /// @param verb
    /// @param forceValue
    /// @param forceAnalogue
    static set_verb = function(_verb_name, _value, _analogue)
    {
        with(verbs[$ _verb_name])
        {
            force_value    = _value;
            force_analogue = _analogue;
        }
    }
    
    static tick = function()
    {
        if (!rebind_this_frame)
        {
            if (rebind_state > 0) __input_trace("Binding scan failed: input_binding_scan_tick() not called last frame");
            rebind_state = 0;
        }
        
        rebind_this_frame = false;
        
        //Clear the momentary state for all verbs
        var _verb_names = variable_struct_get_names(verbs);
        var _v = 0;
        repeat(array_length(_verb_names))
        {
            with(verbs[$ _verb_names[_v]]) clear();
            ++_v;
        }
        
        tick_source();
        
        //Update our verbs
        tick_verbs();
        
        with(cursor)
        {
            tick(other.rebind_state);
            limit();
        }
    }
    
    static tick_verbs = function()
    {
        var _verb_names = variable_struct_get_names(verbs);
        var _v = 0;
        repeat(array_length(_verb_names))
        {
            with(verbs[$ _verb_names[_v]]) tick();
            ++_v;
        }
    }
    
    static tick_source = function()
    {
        var _source_verb_struct = config[$ get_config_category()];
        if (is_struct(_source_verb_struct))
        {
            var _verb_names = variable_struct_get_names(_source_verb_struct);
            var _v = 0;
            repeat(array_length(_verb_names))
            {
                var _verb_name = _verb_names[_v];
                var _verb      = verbs[$ _verb_name];
                
                if ((_verb.force_value != undefined) && (_verb.force_analogue != undefined))
                {
                    //We've had our value set this frame via input_verb_set()
                    
                    with(_verb)
                    {
                        value = force_value;
                        raw   = force_value;
                        
                        raw_analogue = force_analogue;
                        analogue     = force_analogue;
                        
                        min_threshold = 0;
                        max_threshold = 1;
                        
                        force_value    = undefined;
                        force_analogue = undefined;
                    }
                }
                else
                {
                    //We've not had our value set - better go find out what it is
                    
                    var _raw           = 0.0;
                    var _value         = 0.0;
                    var _analogue      = undefined;
                    var _raw_analogue  = undefined;
                    var _min_threshold = undefined;
                    var _max_threshold = undefined;
                
                    var _alternate_array = _source_verb_struct[$ _verb_name];
                    var _a = 0;
                    repeat(array_length(_alternate_array))
                    {
                        var _binding = _alternate_array[_a];
                        if (is_struct(_binding))
                        {
                            switch(_binding.type)
                            {
                                case "key":
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
                            
                                case "gamepad button":
                                    if (input_gamepad_check(gamepad, _binding.value))
                                    {
                                        _value        = 1.0;
                                        _raw          = 1.0;
                                        _analogue     = false;
                                        _raw_analogue = false;
                                    }
                                break;
                            
                                case "mouse button":
                                    if (input_mouse_check(_binding.value))
                                    {
                                        _value        = 1.0;
                                        _raw          = 1.0;
                                        _analogue     = false;
                                        _raw_analogue = false;
                                    }
                                break;
                            
                                case "mouse wheel up":
                                    if (mouse_wheel_up())
                                    {
                                        _value        = 1.0;
                                        _raw          = 1.0;
                                        _analogue     = false;
                                        _raw_analogue = false;
                                    }
                                break;
                            
                                case "mouse wheel down":
                                    if (mouse_wheel_down())
                                    {
                                        _value        = 1.0;
                                        _raw          = 1.0;
                                        _analogue     = false;
                                        _raw_analogue = false;
                                    }
                                break;
                            
                                case "gamepad axis":
                                    //Grab the raw value directly from the gamepad
                                    //We keep a hold of this value for use in 2D checkers
                                    var _found_raw = input_gamepad_value(gamepad, _binding.value);
                                    
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
                            }
                        }
                    
                        ++_a;
                    }
                
                    with(_verb)
                    {
                        value = _value;
                        raw   = _raw;
                        
                        if (_raw_analogue != undefined) raw_analogue = _raw_analogue;
                        if (_analogue     != undefined) analogue     = _analogue;
                        min_threshold = _min_threshold;
                        max_threshold = _max_threshold;
                    }
                }
                
                ++_v;
            }
        }
    }
    
    /// @param sourceName
    /// @param verb
    /// @param alternate
    /// @param bindingStruct
    static set_binding = function(_config_category, _verb, _alternate, _binding_struct)
    {
        if (__INPUT_DEBUG)
        {
            __input_trace("Setting binding, args=", _config_category, ", ", _verb, ", ", _alternate, ", ", _binding_struct);
            __input_trace("callstack = ", debug_get_callstack());
        }
        
        if ((_config_category != "keyboard and mouse") && (_config_category != "gamepad") && (_config_category != "joycon"))
        {
            __input_error("Invalid config (", _config_category, ")");
            return undefined;
        }
        
        if (_alternate < 0)
        {
            __input_error("Invalid \"alternate\" argument (", _alternate, ")");
            return undefined;
        }
            
        if (_alternate >= INPUT_MAX_ALTERNATE_BINDINGS)
        {
            __input_error("\"alternate\" argument too large (", _alternate, " must be less than ", INPUT_MAX_ALTERNATE_BINDINGS, ")\nIncrease INPUT_MAX_ALTERNATE_BINDINGS for more alternate binding slots");
            return undefined;
        }
        
        if (_verb == "")
        {
            __input_error("Verb name cannot be an empty string");
            return undefined;
        }
        
        var _source_verb_struct = config[$ _config_category];
        if (!is_struct(_source_verb_struct))
        {
            if (__INPUT_DEBUG) __input_trace("Source verb struct not found, creating a new one");
            _source_verb_struct = {};
            config[$ _config_category] = _source_verb_struct;
        }
        else
        {
            if (__INPUT_DEBUG) __input_trace("Source verb struct = ", _source_verb_struct);
        }
        
        var _verb_alternate_array = _source_verb_struct[$ _verb];
        if (!is_array(_verb_alternate_array))
        {
            if (__INPUT_DEBUG) __input_trace("Verb alternate array not found, creating a new one");
            _verb_alternate_array = array_create(INPUT_MAX_ALTERNATE_BINDINGS, undefined);
            _source_verb_struct[$ _verb] = _verb_alternate_array;
        }
        else
        {
            if (__INPUT_DEBUG) __input_trace("Verb alternate array = ", _verb_alternate_array);
        }
        
        if (__INPUT_DEBUG) __input_trace("Verb alternate array length = ", array_length(_verb_alternate_array));
        
        _verb_alternate_array[@ _alternate] = _binding_struct;
        
        //Set up a verb container on the player separate from the bindings
        if (!is_struct(verbs[$ _verb]))
        {
            if (__INPUT_DEBUG) __input_trace("Verb not found on player, creating a new one");
            
            var _verb_struct = new __input_class_verb();
            _verb_struct.name = _verb;
            
            verbs[$ _verb] = _verb_struct;
        }
        
        return _binding_struct;
    }
    
    /// @param source
    /// @param verb
    /// @param alternate
    static get_binding = function(_source, _verb, _alternate)
    {
        var _source_verb_struct = config[$ convert_source_enum_to_config_category(_source)];
        if (is_struct(_source_verb_struct))
        {
            var _alternate_array = _source_verb_struct[$ _verb];
            if (is_array(_alternate_array))
            {
                var _binding = _alternate_array[_alternate];
                if (is_struct(_binding)) return _binding;
            }
        }
        
        return undefined;
    }
    
    static get_config_category = function()
    {
        //Use the joycon config if the player is using a joycon at the moment
        if ((source == INPUT_SOURCE.GAMEPAD) && variable_struct_exists(config, "joycon"))
        {
            var _gamepad_struct = global.__input_gamepads[gamepad];
            if (is_struct(_gamepad_struct) && ((_gamepad_struct.raw_type == "SwitchJoyConLeft") || (_gamepad_struct.raw_type == "SwitchJoyConRight")))
            {
                return "joycon";
            }
        }
        
        return global.__input_config_category_names[source];
    }
    
    static get_invalid_gamepad_bindings = function()
    {
        var _output = [];
        
        var _source_verb_struct = config[$ get_config_category()];
        if (is_struct(_source_verb_struct))
        {
            var _gamepad_mapping_array = input_gamepad_get_map(gamepad);
            
            var _verb_names = variable_struct_get_names(_source_verb_struct);
            var _v = 0;
            repeat(array_length(_verb_names))
            {
                var _verb_name = _verb_names[_v];
                var _alternate_array = _source_verb_struct[$ _verb_name];
                
                var _a = 0;
                repeat(array_length(_alternate_array))
                {
                    if (is_struct(_alternate_array[_a]))
                    {
                        var _verb_input = _alternate_array[_a].value;
                        
                        var _found = false;
                        var _m = 0;
                        repeat(array_length(_gamepad_mapping_array))
                        {
                            if (_gamepad_mapping_array[_m] == _verb_input)
                            {
                                _found = true;
                                break;
                            }
                            
                            ++_m;
                        }
                        
                        if (!_found) array_push(_output, { verb: _verb_name, alternate: _a, gm: _verb_input });
                    }
                    
                    ++_a;
                }
                
                ++_v;
            }
        }
        
        return _output;
    }
    
    /// @param binding
    static get_binding_config_category = function(_binding)
    {
        if ((_binding.type == "key")
        ||  (_binding.type == "mouse button")
        ||  (_binding.type == "mouse wheel up")
        ||  (_binding.type == "mouse wheel down"))
        {
            return "keyboard and mouse";
        }
        else if ((_binding.type == "gamepad button")
             ||  (_binding.type == "gamepad axis"))
        {
            //Use the joycon config if the player is using a joycon at the moment
            if ((source == INPUT_SOURCE.GAMEPAD) && variable_struct_exists(config, "joycon"))
            {
                var _gamepad_struct = global.__input_gamepads[gamepad];
                if (is_struct(_gamepad_struct) && ((_gamepad_struct.raw_type == "SwitchJoyConLeft") || (_gamepad_struct.raw_type == "SwitchJoyConRight")))
                {
                    return "joycon";
                }
            }
            
            return "gamepad";
        }
        
        __input_error("Binding type \"", _binding.type, "\" unrecognised");
        return undefined;
    }
    
    static convert_source_enum_to_config_category = function(_source)
    {
        //If undefined is passed in, use the player's current source
        if (_source == undefined) return get_config_category();
        
        if (is_numeric(_source))
        {
            //Convert enum if necessary
            switch(_source)
            {
                case INPUT_SOURCE.NONE: return undefined; break;
                
                case INPUT_SOURCE.KEYBOARD_AND_MOUSE: return "keyboard and mouse"; break;
                case INPUT_SOURCE.GAMEPAD:            return "gamepad";            break;
                
                default:
                    __input_error("Invalid source (", _source, ")");
                break;
            }
        }
        
        //Value is probably a string, return that
        return _source;
    }
    
    /// @param [source]
    static any_input = function(_source = source)
    {
        if (_source == all)
        {
            if (any_input(INPUT_SOURCE.KEYBOARD_AND_MOUSE)) return true;
            if (any_input(INPUT_SOURCE.GAMEPAD)) return true;
            return false;
        }
        
        switch(_source)
        {
            case INPUT_SOURCE.NONE:
                return false;
            break;
            
            case INPUT_SOURCE.KEYBOARD_AND_MOUSE:
                var _keyboard_valid = (global.__input_keyboard_default_defined && keyboard_check(vk_anykey) && !__input_key_is_ignored(__input_keyboard_key()));
                return (_keyboard_valid || global.__input_mouse_moved || input_mouse_check(mb_any) || mouse_wheel_up() || mouse_wheel_down());
            break;
            
            case INPUT_SOURCE.GAMEPAD:
                if (!gamepad_is_connected(gamepad)) return false;
                
                if (input_gamepad_check(gamepad, gp_face1)
                ||  input_gamepad_check(gamepad, gp_face2)
                ||  input_gamepad_check(gamepad, gp_face3)
                ||  input_gamepad_check(gamepad, gp_face4)
                ||  input_gamepad_check(gamepad, gp_padu)
                ||  input_gamepad_check(gamepad, gp_padd)
                ||  input_gamepad_check(gamepad, gp_padl)
                ||  input_gamepad_check(gamepad, gp_padr)
                ||  input_gamepad_check(gamepad, gp_shoulderl)
                ||  input_gamepad_check(gamepad, gp_shoulderr)
                ||  input_gamepad_check(gamepad, gp_start)
                ||  input_gamepad_check(gamepad, gp_select)
                ||  input_gamepad_check(gamepad, gp_stickl)
                ||  input_gamepad_check(gamepad, gp_stickr)
                ||  input_gamepad_check(gamepad, gp_stickr)
                ||  input_gamepad_check(gamepad, gp_stickr)
                ||  input_gamepad_check(gamepad, gp_stickr)
                ||  input_gamepad_check(gamepad, gp_stickr)
                ||  (abs(input_gamepad_value(gamepad, gp_shoulderlb)) > INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD)
                ||  (abs(input_gamepad_value(gamepad, gp_shoulderrb)) > INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD)
                ||  (abs(input_gamepad_value(gamepad, gp_axislh)) > INPUT_DEFAULT_AXIS_MIN_THRESHOLD)
                ||  (abs(input_gamepad_value(gamepad, gp_axislv)) > INPUT_DEFAULT_AXIS_MIN_THRESHOLD)
                ||  (abs(input_gamepad_value(gamepad, gp_axisrh)) > INPUT_DEFAULT_AXIS_MIN_THRESHOLD)
                ||  (abs(input_gamepad_value(gamepad, gp_axisrv)) > INPUT_DEFAULT_AXIS_MIN_THRESHOLD))
                {
                    return true;
                }
                
                if (INPUT_SDL2_ALLOW_EXTENDED)
                {
                    if (input_gamepad_check(gamepad, gp_guide)
                    ||  input_gamepad_check(gamepad, gp_misc1)
                    ||  input_gamepad_check(gamepad, gp_touchpad)
                    ||  input_gamepad_check(gamepad, gp_paddle1)
                    ||  input_gamepad_check(gamepad, gp_paddle2)
                    ||  input_gamepad_check(gamepad, gp_paddle3)
                    ||  input_gamepad_check(gamepad, gp_paddle4))
                    {
                        return true;
                    }
                }
                
                return false;
                    
            break;
        }
        
        return false;
    }
}
