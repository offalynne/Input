function __input_class_player() constructor
{
    __source_array   = [];
    verbs            = {};
    chord_state_dict = {};
    combo_state_dict = {};
    last_input_time  = -infinity;
    cursor           = new __input_class_cursor();
    
    rebind_state         = 0;
    rebind_gamepad       = undefined;
    rebind_target_source = undefined;
    rebind_this_frame    = false;
    
    //This struct is the one that gets serialized/deserialized
    config = { axis_thresholds : {} };
    
    
    
    #region Source Manipulation
    
    static __clear_sources = function()
    {
        array_resize(__source_array, 0);
        last_input_time = current_time;
    }
    
    static __set_ghost = function()
    {
        __clear_sources();
        __add_source("ghost");
    }
    
    static __add_source = function(_source, _gamepad = undefined)
    {
        if ((_source == INPUT_SOURCE.GAMEPAD) && (_gamepad == undefined)) _gamepad = __get_gamepad();
        
        if (__is_using_source(_source, _gamepad)) return;
        
        array_push(__source_array, new __input_class_source(_source, _gamepad));
        
        last_input_time = current_time;
    }
    
    static __is_using_source = function(_source, _gamepad = undefined)
    {
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i].__collides_with(_source, _gamepad)) return true;
            ++_i;
        }
        
        return false;
    }
    
    static __is_connected = function()
    {
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i].__is_connected()) return true;
            ++_i;
        }
        
        return false;
    }
    
    static __get_gamepad = function()
    {
        var _i = 0;
        repeat(array_length(__source_array))
        {
            var _gamepad = __source_array[_i].gamepad;
            if (_gamepad != undefined) return _gamepad;
            ++_i;
        }
        
        return undefined;
    }
    
    #endregion
    
    
    
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
        var _v = 0;
        repeat(array_length(global.__input_all_verb_array))
        {
            with(verbs[$ global.__input_all_verb_array[_v]]) clear();
            ++_v;
        }
        
        __input_player_tick_sources();
        
        //Update our basic verbs first
        tick_basic_verbs();
        
        //Update our chords
        //We directly access verb values to detect state here
        tick_chord_verbs();
        
        //Update our combos
        //We directly access verb values to detect state here
        tick_combo_verbs();
        
        with(cursor)
        {
            tick(other.rebind_state);
            limit();
        }
    }
    
    static tick_basic_verbs = function()
    {
        var _v = 0;
        repeat(array_length(global.__input_basic_verb_array))
        {
            with(verbs[$ global.__input_basic_verb_array[_v]]) tick();
            ++_v;
        }
    }
    
    static tick_chord_verbs = function()
    {
        var _i = 0;
        repeat(array_length(global.__input_chord_verb_array))
        {
            var _chord_name = global.__input_chord_verb_array[_i];
            if (chord_state_dict[$ _chord_name].__evaluate(verbs))
            {
                with(verbs[$ _chord_name])
                {
                    value = 1;
                    raw   = 1;
                    tick();
                }
            }
            else
            {
                verbs[$ _chord_name].tick();
            }
            
            ++_i;
        }
    }
    
    static tick_combo_verbs = function()
    {
        var _i = 0;
        repeat(array_length(global.__input_combo_verb_array))
        {
            var _combo_name = global.__input_combo_verb_array[_i];
            if (combo_state_dict[$ _combo_name].__tick(verbs) == __INPUT_COMBO_STATE.__SUCCESS)
            {
                with(verbs[$ _combo_name])
                {
                    value = 1;
                    raw   = 1;
                    tick();
                }
            }
            else
            {
                verbs[$ _combo_name].tick();
            }
            
            ++_i;
        }
    }
    
    /// @param configName
    /// @param verb
    static __ensure_verb = function(_config_name, _verb)
    {
        if ((_config_name != __INPUT_CONFIG_KEYBOARD)
        &&  (_config_name != __INPUT_CONFIG_MOUSE)
        &&  (_config_name != __INPUT_CONFIG_GAMEPAD)
        &&  (_config_name != __INPUT_CONFIG_JOYCON))
        {
            __input_error("Invalid config (", _config_name, ")");
            return undefined;
        }
        
        if (_verb == "")
        {
            __input_error("Verb name cannot be an empty string");
            return undefined;
        }
        
        if (!is_struct(verbs[$ _verb]))
        {
            verbs[$ _verb] = new __input_class_verb();
        }
        
        var _source_verb_struct = config[$ _config_name];
        if (!is_struct(_source_verb_struct))
        {
            if (__INPUT_DEBUG) __input_trace("Source verb struct not found, creating a new one");
            _source_verb_struct = {};
            config[$ _config_name] = _source_verb_struct;
        }
        else
        {
            if (__INPUT_DEBUG) __input_trace("Source verb struct = ", _source_verb_struct);
        }
        
        var _verb_alternate_array = _source_verb_struct[$ _verb];
        if (!is_array(_verb_alternate_array))
        {
            if (__INPUT_DEBUG) __input_trace("Verb alternate array not found, creating a new one");
            _verb_alternate_array = array_create(INPUT_MAX_ALTERNATE_BINDINGS);
            
            var _i = 0;
            repeat(INPUT_MAX_ALTERNATE_BINDINGS)
            {
                _verb_alternate_array[@ _i] = __INPUT_BINDING_NULL;
                ++_i;
            }
            
            _source_verb_struct[$ _verb] = _verb_alternate_array;
        }
        else
        {
            if (__INPUT_DEBUG) __input_trace("Verb alternate array = ", _verb_alternate_array);
        }
        
        if (__INPUT_DEBUG) __input_trace("Verb alternate array length = ", array_length(_verb_alternate_array));
    }
    
    /// @param verb
    /// @param alternate
    /// @param bindingStruct
    static __set_binding = function(_verb, _alternate, _binding_struct)
    {
        config[$ __get_config_name_from_binding(_binding_struct)][$ _verb][@ _alternate] = _binding_struct;
    }
    
    /// @param verb
    /// @param alternate
    /// @param bindingStruct
    static __set_mixed_binding = function(_verb, _alternate, _binding_struct)
    {
        config[$ __INPUT_CONFIG_MIXED][$ _verb][@ _alternate] = _binding_struct;
    }
    
    /// @param configName
    /// @param verb
    /// @param alternate
    static __remove_binding = function(_config_name, _verb, _alternate)
    {
        config[$ _config_name][$ _verb][@ _alternate] = __INPUT_BINDING_NULL;
    }
    
    /// @param configName
    /// @param verb
    /// @param alternate
    static __reset_binding = function(_config_name, _verb, _alternate)
    {
        //Grab the equivalent binding from the default player
        var _binding = global.__input_default_player.config[$ _config_name][$ _verb][@ _alternate];
        
        //If the binding is a struct then duplicate so we don't get nasty
        if (is_struct(_binding)) _binding.__duplicate();
        
        //And set the value!
        config[$ _config_name][$ _verb][@ _alternate] = _binding;
    }
    
    /// @param configName
    /// @param verb
    /// @param alternate
    static __get_binding = function(_config_name, _verb, _alternate)
    {
        return config[$ _config_name][$ _verb][_alternate];
    }
    
    static __add_chord = function(_name)
    {
        //Set up a verb container on the player separate from the bindings
        if (is_struct(verbs[$ _name]))
        {
            __input_error("Chord \"", _name, "\" has already been added to this player");
        }
        else
        {
            if (__INPUT_DEBUG) __input_trace("Verb \"", _name, "\" not found on player, creating a new one as a chord");
            
            var _verb_struct = new __input_class_verb();
            _verb_struct.name     = _name;
            _verb_struct.type     = "chord";
            _verb_struct.analogue = false; //Chord verbs are never analogue
            verbs[$ _name] = _verb_struct;
            
            //We also need to store additional tracking information for combos
            chord_state_dict[$ _name] = new __input_class_chord_state(_name, global.__input_chord_verb_dict[$ _name]);
        }
    }
    
    static __add_combo = function(_name)
    {
        //Set up a verb container on the player separate from the bindings
        if (is_struct(verbs[$ _name]))
        {
            __input_error("Combo \"", _name, "\" has already been added to this player");
        }
        else
        {
            if (__INPUT_DEBUG) __input_trace("Verb \"", _name, "\" not found on player, creating a new one as a combo");
            
            var _verb_struct = new __input_class_verb();
            _verb_struct.name     = _name;
            _verb_struct.type     = "combo";
            _verb_struct.analogue = false; //Combo verbs are never analogue
            verbs[$ _name] = _verb_struct;
            
            //We also need to store additional tracking information for combos
            combo_state_dict[$ _name] = new __input_class_combo_state(_name, global.__input_combo_verb_dict[$ _name]);
        }
    }
    
    static __get_invalid_gamepad_bindings = function()
    {
        var _output = [];
        
        var _s = 0;
        repeat(array_length(__source_array))
        {
            var _source_struct = __source_array[_s];
            
            var _config_verb_struct = config[$ __get_config_name()];
            if (is_struct(_config_verb_struct))
            {
                var _gamepad_mapping_array = input_gamepad_get_map(gamepad);
                
                var _v = 0;
                repeat(array_length(global.__input_basic_verb_array))
                {
                    var _verb_name = global.__input_basic_verb_array[_v];
                    
                    var _alternate_array = _config_verb_struct[$ _verb_name];
                    var _a = 0;
                    repeat(INPUT_MAX_ALTERNATE_BINDINGS)
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
            
            ++_s;
        }
        
        return _output;
    }
    
    
    
    #region Config name getters
    
    static __get_config_name = function()
    {
        var _source_count = array_length(sources);
        if (_source_count <= 0) return undefined;
        if (_source_count <= 1) return sources[0].__get_config_name();
        
        //TODO
        return undefined;
    }
    
    /// @param binding
    static __get_config_name_from_binding = function(_binding)
    {
        if (_binding.type == __INPUT_BINDING_KEY)
        {
            return __INPUT_CONFIG_KEYBOARD;
        }
        else if ((_binding.type == __INPUT_BINDING_MOUSE_BUTTON    )
             ||  (_binding.type == __INPUT_BINDING_MOUSE_WHEEL_UP  )
             ||  (_binding.type == __INPUT_BINDING_MOUSE_WHEEL_DOWN))
        {
            return __INPUT_CONFIG_MOUSE;
        }
        else if ((_binding.type == __INPUT_BINDING_GAMEPAD_BUTTON)
             ||  (_binding.type == __INPUT_BINDING_GAMEPAD_AXIS))
        {
            if (global.__input_joycon_default_defined)
            {
                //Use the joycon config if the player is using a joycon at the moment
                if (source == INPUT_SOURCE.GAMEPAD)
                {
                    var _gamepad_struct = global.__input_gamepads[gamepad];
                    if (is_struct(_gamepad_struct) && ((_gamepad_struct.raw_type == "SwitchJoyConLeft") || (_gamepad_struct.raw_type == "SwitchJoyConRight")))
                    {
                        return __INPUT_CONFIG_JOYCON;
                    }
                }
                else if (_binding.joycon) //Or if the binding itself is explicitly for a joycon
                {
                    return __INPUT_CONFIG_JOYCON;
                }
            }
            
            return __INPUT_CONFIG_GAMEPAD;
        }
        
        __input_error("Binding type \"", _binding.type, "\" unrecognised");
        return undefined;
    }
    
    static __get_config_name_from_source = function(_source)
    {
        //If undefined is passed in, use the player's current source
        if (_source == undefined) return __get_config_name();
        
        if (is_numeric(_source))
        {
            //Convert enum if necessary
            switch(_source)
            {
                case INPUT_SOURCE.NONE:
                case INPUT_SOURCE.GHOST:
                    return undefined;
                break;
                
                case INPUT_SOURCE.KEYBOARD: return __INPUT_CONFIG_KEYBOARD; break;
                case INPUT_SOURCE.MOUSE:    return __INPUT_CONFIG_MOUSE;    break;
                case INPUT_SOURCE.GAMEPAD:  return __INPUT_CONFIG_GAMEPAD;  break;
                
                default:
                    __input_error("Invalid source (", _source, ")");
                break;
            }
        }
        
        //Value is probably a string, return that
        return _source;
    }
    
    #endregion
    
    
    
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
            case INPUT_SOURCE.GHOST:
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
