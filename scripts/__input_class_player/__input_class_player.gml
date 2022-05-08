function __input_class_player() constructor
{
    __index = undefined;
    
    __source_array     = [];
    __verb_state_dict  = {};
    __chord_state_dict = {};
    __combo_state_dict = {};
    __last_input_time  = -infinity;
    
    __rebind_state      = 0;
    __rebind_error      = undefined;
    __rebind_start_time = current_time;
    __rebind_this_frame = false;
    
    //This struct is the one that gets serialized/deserialized
    __profiles_dict = { axis_thresholds : {} };
    __profile_name = undefined;
    
    __ghost = false;
    
   __cursor = new __input_class_cursor();
   __cursor.__player = self;
    
    
    
    #region Profiles
    
    static __profile_create = function(_profile_name)
    {
        if (variable_struct_exists(__profiles_dict, _profile_name)) __input_error("Profile \"", _profile_name, "\" already exists for player ", __index);
        
        if (INPUT_DEBUG_PROFILES) __input_trace("Profile \"", _profile_name, "\" created for player ", __index);
        __profiles_dict[$ _profile_name] = {};
    }
    
    static __profile_destroy = function(_profile_name)
    {
        if (variable_struct_exists(global.__input_default_profile_dict, _profile_name))
        {
            __input_error("Cannot remove profile \"", _profile_name, "\" as it is a default profile");
        }
        
        if (INPUT_DEBUG_PROFILES) __input_trace("Profile \"", _profile_name, "\" destroyed for player ", __index);
        
        if (__profile_name == _profile_name) __profile_name = undefined;
        variable_struct_remove(__profiles_dict, _profile_name);
        if (__profile_name == undefined) __profile_set(__profile_get_auto());
    }
    
    static __profile_exists = function(_profile_name)
    {
        return variable_struct_exists(__profiles_dict, _profile_name);
    }
    
    static __profile_get_array = function()
    {
        return variable_struct_get_names(__profiles_dict);
    }
    
    static __profile_set = function(_profile_name)
    {
        if (_profile_name == undefined)
        {
            __input_trace("Warning! Failed to set profile for player ", __index, " (was ", _profile_name, ")");
            return;
        }
        
        if (!variable_struct_exists(__profiles_dict, _profile_name))
        {
            __input_error("Profile \"", _profile_name, "\" doesn't exist for player ", __index);
        }
        
        if (__profile_name != _profile_name) __input_trace("Setting player ", __index, " profile to \"", _profile_name, "\"");
        __profile_name = _profile_name;
    }
    
    /// @param [profileName=undefined]
    static __profile_get = function(_profile_name = undefined)
    {
        if (_profile_name == undefined) return __profile_name;
        
        if (!variable_struct_exists(__profiles_dict, _profile_name))
        {
            __input_error("Profile \"", _profile_name, "\" doesn't exist for player ", __index);
        }
        
        return _profile_name;
    }
    
    static __profile_get_auto = function()
    {
        if (__ghost) return undefined;
        if ((global.__input_source_mode == INPUT_SOURCE_MODE.MULTI_DEVICE) && (__index == 0)) return INPUT_AUTO_PROFILE_FOR_MULTIDEVICE;
        
        var _count = array_length(__source_array);
        
        //If there're no sources then return a null value
        if (_count == 0) return undefined;
        
        //If we have one source then return the profile for that source
        if (_count == 1)
        {
            switch(__source_array[0].__source)
            {
                case __INPUT_SOURCE.KEYBOARD: return INPUT_AUTO_PROFILE_FOR_KEYBOARD; break;
                case __INPUT_SOURCE.MOUSE:    return INPUT_AUTO_PROFILE_FOR_MOUSE;    break;
                case __INPUT_SOURCE.GAMEPAD:  return INPUT_AUTO_PROFILE_FOR_GAMEPAD;  break;
                
                default:
                    __input_error("Invalid source (", __source_array[0].__source, ")");
                break;
            }
        }
        
        //If we have any more sources than that then return the "mixed" automatic profile
        return INPUT_AUTO_PROFILE_FOR_MIXED;
    }
    
    static __profile_set_auto = function()
    {
        var _profile_name = __profile_get_auto();
        if (_profile_name != undefined) __profile_set(_profile_name);
    }
    
    /// @param profileName
    static __profile_ensure = function(_profile_name)
    {
        if (_profile_name == "")
        {
            __input_error("Profile name cannot be an empty string");
            return undefined;
        }
        
        var _profile_struct = __profiles_dict[$ _profile_name];
        if (!is_struct(_profile_struct))
        {
            _profile_struct = {};
            __profiles_dict[$ _profile_name] = _profile_struct;
        }
    }
    
    static __profile_reset_bindings = function(_profile_name)
    {
        var _v = 0;
        repeat(array_length(global.__input_basic_verb_array))
        {
            var _verb_name = global.__input_basic_verb_array[_v];
            
            var _alternate = 0;
            repeat(INPUT_MAX_ALTERNATE_BINDINGS)
            {
                __binding_reset(_profile_name, _verb_name, _alternate);
                ++_alternate;
            }
            
            ++_v;
        }
    }
    
    #endregion
    
    
    
    #region Sources
    
    static __sources_clear = function()
    {
        if ((__rebind_state > 0) && (array_length(__source_array) > 0)) __rebind_error = INPUT_BINDING_SCAN_EVENT.SOURCE_CHANGED;
        
        array_resize(__source_array, 0);
        __last_input_time = current_time;
        
        if (INPUT_DEBUG_SOURCES) __input_trace("Sources cleared for player ", __index);
    }
    
    /// @param source
    static __source_add = function(_source)
    {
        //We don't use __source_contains() here because it'll report a false positive when assigning keyboard+mouse together
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i] == _source)
            {
                if (INPUT_DEBUG_SOURCES) __input_trace("Cannot add ", _source, " to player ", __index, ", it has already been assigned");
                return;
            }
            
            ++_i;
        }
        
        if (__rebind_state > 0) __rebind_error = INPUT_BINDING_SCAN_EVENT.SOURCE_CHANGED;
        
        array_push(__source_array, _source);
        __last_input_time = current_time;
        
        if (INPUT_DEBUG_SOURCES) __input_trace("Assigned source ", _source, " to player ", __index);
    }
    
    /// @param source
    static __source_remove = function(_source)
    {
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i] == _source)
            {
                array_delete(__source_array, _i, 1);
                if (INPUT_DEBUG_SOURCES) __input_trace("Removed source ", _source, " from player ", __index);
            }
            else
            {
                ++_i;
            }
        }
    }
    
    /// @param source
    static __source_contains = function(_source)
    {
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i].__equal_to(_source)) return true;
            ++_i;
        }
        
        return false;
    }
    
    static __is_connected = function()
    {
        if (__ghost) return true;
        
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i].__is_connected()) return true;
            ++_i;
        }
        
        return false;
    }
    
    static __source_get_gamepad = function()
    {
        var _i = 0;
        repeat(array_length(__source_array))
        {
            var _gamepad = __source_array[_i].gamepad;
            if (input_gamepad_is_connected(_gamepad)) return _gamepad;
            ++_i;
        }
        
        return undefined;
    }
    
    static __sources_any_input = function()
    {
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i].__any_input()) return true;
            ++_i;
        }
        
        return false;
    }
    
    #endregion
    
    
    
    #region Bindings
    
    /// @param profileName
    /// @param verb
    /// @param alternate
    static __binding_get = function(_profile_name, _verb, _alternate)
    {
        return __profiles_dict[$ __profile_get(_profile_name)][$ _verb][_alternate];
    }
    
    /// @param profileName
    /// @param verb
    /// @param alternate
    /// @param bindingStruct
    static __binding_set = function(_profile_name, _verb, _alternate, _binding_struct)
    {
        __profiles_dict[$ __profile_get(_profile_name)][$ _verb][@ _alternate] = _binding_struct;
        if (INPUT_DEBUG_BINDING) __input_trace("Binding for profile \"", _profile_name, "\" verb \"", _verb, "\" alternate ", _alternate, " set to ", _binding_struct);
    }
    
    /// @param profileName
    /// @param verb
    /// @param alternate
    static __binding_remove = function(_profile_name, _verb, _alternate)
    {
        __profiles_dict[$ __profile_get(_profile_name)][$ _verb][@ _alternate] = __INPUT_BINDING_NULL;
        if (INPUT_DEBUG_BINDING) __input_trace("Binding for profile \"", _profile_name, "\" verb \"", _verb, "\" alternate ", _alternate, " removed (set to null)");
    }
    
    /// @param profileName
    /// @param verb
    /// @param alternate
    static __binding_reset = function(_profile_name, _verb, _alternate)
    {
        //Grab the equivalent binding from the default player
        var _binding_struct = global.__input_default_player.__profiles_dict[$ _profile_name][$ _verb][_alternate];
        
        //If the binding is a struct then duplicate so we don't get nasty
        if (is_struct(_binding_struct)) _binding_struct.__duplicate();
        
        //And set the value!
        __profiles_dict[$ __profile_get(_profile_name)][$ _verb][@ _alternate] = _binding_struct;
        
        if (INPUT_DEBUG_BINDING) __input_trace("Binding for profile \"", _profile_name, "\" verb \"", _verb, "\" alternate ", _alternate, " reset to ", _binding_struct);
    }
    
    #endregion
    
    
    
    #region Verbs
    
    /// @param verbName
    static __ensure_verb = function(_profile_name, _verb_name)
    {
        if (_verb_name == "")
        {
            __input_error("Verb name cannot be an empty string");
            return undefined;
        }
        
        var _profile_struct = __profiles_dict[$ _profile_name];
        if (!is_struct(_profile_struct)) __input_error("Profile \"", _profile_name, "\" does not exist for player ", __index);
        
        if (!is_struct(__verb_state_dict[$ _verb_name]))
        {
            if (INPUT_DEBUG_VERBS) __input_trace("Verb \"", _verb_name, "\" not found on player ", __index, ", creating a new one");
            __verb_state_dict[$ _verb_name] = new __input_class_verb();
        }
        
        var _verb_alternate_array = _profile_struct[$ _verb_name];
        if (!is_array(_verb_alternate_array))
        {
            _verb_alternate_array = array_create(INPUT_MAX_ALTERNATE_BINDINGS);
            
            var _i = 0;
            repeat(INPUT_MAX_ALTERNATE_BINDINGS)
            {
                _verb_alternate_array[@ _i] = __INPUT_BINDING_NULL;
                ++_i;
            }
            
            _profile_struct[$ _verb_name] = _verb_alternate_array;
        }
    }
    
    /// @param verbName
    static __add_chord = function(_verb_name)
    {
        //Set up a verb container on the player separate from the bindings
        if (is_struct(__verb_state_dict[$ _verb_name]))
        {
            __input_error("Chord \"", _verb_name, "\" has already been added to player ", __index);
        }
        else
        {
            if (INPUT_DEBUG_VERBS) __input_trace("Verb \"", _verb_name, "\" not found on player ", __index, ", creating a new one as a chord");
            
            var _verb_struct = new __input_class_verb();
            _verb_struct.name     = _verb_name;
            _verb_struct.type     = "chord";
            _verb_struct.analogue = false; //Chord verbs are never analogue
            __verb_state_dict[$ _verb_name] = _verb_struct;
            
            //We also need to store additional tracking information for combos
            __chord_state_dict[$ _verb_name] = new __input_class_chord_state(_verb_name, global.__input_chord_verb_dict[$ _verb_name]);
        }
    }
    
    /// @param verbName
    static __add_combo = function(_verb_name)
    {
        //Set up a verb container on the player separate from the bindings
        if (is_struct(__verb_state_dict[$ _verb_name]))
        {
            __input_error("Combo \"", _verb_name, "\" has already been added to this player");
        }
        else
        {
            if (INPUT_DEBUG_VERBS) __input_trace("Verb \"", _verb_name, "\" not found on player ", __index, ", creating a new one as a combo");
            
            var _verb_struct = new __input_class_verb();
            _verb_struct.name     = _verb_name;
            _verb_struct.type     = "combo";
            _verb_struct.analogue = false; //Combo verbs are never analogue
            __verb_state_dict[$ _verb_name] = _verb_struct;
            
            //We also need to store additional tracking information for combos
            __combo_state_dict[$ _verb_name] = new __input_class_combo_state(_verb_name, global.__input_combo_verb_dict[$ _verb_name]);
        }
    }
    
    #endregion
    
    
    
    /// @param axis
    /// @param min
    /// @param max
    static axis_threshold_set = function(_axis, _min, _max)
    {
        var _axis_struct = __profiles_dict.axis_thresholds[$ _axis];
        if (!is_struct(_axis_struct))
        {
            _axis_struct = {};
            __profiles_dict.axis_thresholds[$ _axis] = _axis_struct;
        }
        
        _axis_struct.mini = _min
        _axis_struct.maxi = _max;
        
        if (INPUT_DEBUG_BINDING) __input_trace("Axis threshold for axis \"", _axis, "\" set to ", _min, " -> ", _max);
        
        return _axis_struct;
    }
    
    /// @param axis
    static axis_threshold_get = function(_axis)
    {
        var _struct = __profiles_dict.axis_thresholds[$ _axis];
        if (is_struct(_struct)) return _struct;
        
        if (INPUT_DEBUG_BINDING) __input_trace("No axis threshold found for axis ", _axis);
        
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
        with(__verb_state_dict[$ _verb_name])
        {
            force_value    = _value;
            force_analogue = _analogue;
        }
    }
    
    static __get_invalid_gamepad_bindings = function(_profile_name = undefined)
    {
        var _output = [];
        
        var _s = 0;
        repeat(array_length(__source_array))
        {
            var _source_struct = __source_array[_s];
            
            var _profile_verb_struct = __profiles_dict[$ __profile_get(_profile_name)];
            if (is_struct(_profile_verb_struct))
            {
                var _gamepad_mapping_array = input_gamepad_get_map(gamepad);
                
                var _v = 0;
                repeat(array_length(global.__input_basic_verb_array))
                {
                    var _verb_name = global.__input_basic_verb_array[_v];
                    
                    var _alternate_array = _profile_verb_struct[$ _verb_name];
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
    
    
    
    #region Tick functions
    
    static tick = function()
    {
        if (!__rebind_this_frame)
        {
            if (__rebind_state > 0) __input_trace("Binding scan failed: input_binding_scan_tick() not called last frame");
            __rebind_state = 0;
        }
        
        __rebind_this_frame = false;
        
        //Clear the momentary state for all verbs
        var _v = 0;
        repeat(array_length(global.__input_all_verb_array))
        {
            __verb_state_dict[$ global.__input_all_verb_array[_v]].__clear();
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
    }
    
    static tick_basic_verbs = function()
    {
        var _v = 0;
        repeat(array_length(global.__input_basic_verb_array))
        {
            with(__verb_state_dict[$ global.__input_basic_verb_array[_v]]) tick();
            ++_v;
        }
    }
    
    static tick_chord_verbs = function()
    {
        var _i = 0;
        repeat(array_length(global.__input_chord_verb_array))
        {
            var _chord_name = global.__input_chord_verb_array[_i];
            if (__chord_state_dict[$ _chord_name].__evaluate(__verb_state_dict))
            {
                with(__verb_state_dict[$ _chord_name])
                {
                    value = 1;
                    raw   = 1;
                    tick();
                }
            }
            else
            {
                __verb_state_dict[$ _chord_name].tick();
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
            if (__combo_state_dict[$ _combo_name].__tick(__verb_state_dict) == __INPUT_COMBO_STATE.__SUCCESS)
            {
                with(__verb_state_dict[$ _combo_name])
                {
                    value = 1;
                    raw   = 1;
                    tick();
                }
            }
            else
            {
                __verb_state_dict[$ _combo_name].tick();
            }
            
            ++_i;
        }
    }
    
    #endregion
}