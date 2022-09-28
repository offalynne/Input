function __input_class_player() constructor
{
    __index = undefined;
    
    __source_array          = [];
    __verb_state_dict       = {};
    __chord_state_dict      = {};
    __combo_state_dict      = {};
    __last_input_time       = -infinity;
    __verb_group_state_dict = {};
    
    __vibration_paused      = false;
    __vibration_strength    = INPUT_VIBRATION_DEFAULT_STRENGTH;
    __vibration_event_array = [];
    
    __rebind_state            = 0;
    __rebind_start_time       = global.__input_current_time;
    __rebind_success_callback = undefined;
    __rebind_failure_callback = undefined;
    __rebind_source_filter    = [];
    __rebind_ignore_struct    = undefined;
    __rebind_allow_struct     = undefined;
    
    __axis_thresholds_dict = {};
    
    __profiles_dict = {};
    __profile_name = undefined;
    
    __ghost = false;
    
    __connected = false;
    __post_disconnection_tick = false;
    
    __cursor = new __input_class_cursor();
    __cursor.__player = self;
    
    
    
    #region Profiles
    
    static __profile_create = function(_profile_name)
    {
        if (variable_struct_exists(__profiles_dict, _profile_name)) __input_error("Profile \"", _profile_name, "\" already exists for player ", __index);
        
        if (INPUT_DEBUG_PROFILES) __input_trace("Profile \"", _profile_name, "\" created for player ", __index);
        
        var _new_profile_struct = {};
        var _v = 0;
        repeat(array_length(global.__input_basic_verb_array))
        {
            var _verb_name = global.__input_basic_verb_array[_v];
            
            var _alternate_array = array_create(INPUT_MAX_ALTERNATE_BINDINGS, undefined);
            var _a = 0;
            repeat(INPUT_MAX_ALTERNATE_BINDINGS)
            {
                _alternate_array[@ _a] = input_binding_empty();
                ++_a;
            }
            
            _new_profile_struct[$ _verb_name] = _alternate_array;
            ++_v;
        }
        
        __profiles_dict[$ _profile_name] = _new_profile_struct;
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
        if (_profile_name == undefined) return true;
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
        if ((global.__input_source_mode == INPUT_SOURCE_MODE.MULTIDEVICE) && (__index == 0)) return INPUT_AUTO_PROFILE_FOR_MULTIDEVICE;
        
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
            
            //Also create bindings for every basic verb for this profile
            var _v = 0;
            repeat(array_length(global.__input_basic_verb_array))
            {
                var _verb_name = global.__input_basic_verb_array[_v];
                __verb_ensure(_profile_name, _verb_name);
                ++_v;
            }
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
    
    static __profile_export = function(_profile_name, _output_string, _prettify)
    {
        if (!variable_struct_exists(__profiles_dict, _profile_name))
        {
            __input_error("Profile \"", _profile_name, "\" doesn't exist for player ", __index);
        }
        
        var _output = {};
        
        var _profile_struct = __profiles_dict[$ _profile_name];
        var _v = 0;
        repeat(array_length(global.__input_basic_verb_array))
        {
            var _verb_name = global.__input_basic_verb_array[_v];
            
            var _new_alternate_array = [];
            _output[$ _verb_name] = _new_alternate_array;
            
            var _alternate_array = _profile_struct[$ _verb_name];
            var _a = 0;
            repeat(INPUT_MAX_ALTERNATE_BINDINGS)
            {
                array_push(_new_alternate_array, _alternate_array[_a].__export());
                ++_a;
            }
            
            ++_v;
        }
        
        if (_output_string)
        {
            if (_prettify)
            {
                return __input_snap_to_json(_output, true, true);
            }
            else
            {
                return json_stringify(_output);
            }
        }
        else
        {
            return _output;
        }
    }
    
    static __profile_import = function(_string, _profile_name)
    {
        if (is_string(_string))
        {
            var _json = json_parse(_string);
        }
        else
        {
            var _json = _string;
        }
        
        if (!is_struct(_json) && !is_array(_json))
        {
            __input_error("Input must be valid JSON (typeof=", _string, ")");
            return;
        }
        
        //Make sure the player has this particular profile set up
        __profile_ensure(_profile_name);
        var _existing_verb_dict = __profiles_dict[$ _profile_name];
        
        //Iterate over every verb
        var _v = 0;
        repeat(array_length(global.__input_basic_verb_array))
        {
            var _verb_name = global.__input_basic_verb_array[_v];
            
            var _existing_alternate_array = _existing_verb_dict[$ _verb_name];
            //Verify we have an existing alternate array to write into
            if (!is_array(_existing_alternate_array))
            {
                //If we don't have an existing array, create a new one
                _existing_alternate_array = array_create(INPUT_MAX_ALTERNATE_BINDINGS, undefined);
                
                var _a = 0;
                repeat(INPUT_MAX_ALTERNATE_BINDINGS)
                {
                    _existing_alternate_array[@ _a] = input_binding_empty();
                    ++_a;
                }
                
                _existing_verb_dict[$ _verb_name] = _existing_alternate_array;
            }
            
            var _alternate_array = _json[$ _verb_name];
            //Verify that the input data has this verb
            if (!is_array(_alternate_array)) __input_error("Player ", __index, " data is missing verb \"", _verb_name, "\"");
            
            if (array_length(_alternate_array) != INPUT_MAX_ALTERNATE_BINDINGS)
            {
                __input_error("JSON malformed, player ", __index, " verb \"", _verb_name, "\" should have ", INPUT_MAX_ALTERNATE_BINDINGS, " alternate bindings, but it had ", array_length(_alternate_array));
            }
            
            //Iterate over every alternate and import the value into our local data
            var _a = 0;
            repeat(INPUT_MAX_ALTERNATE_BINDINGS)
            {
                _existing_alternate_array[@ _a].__import(_alternate_array[_a]);
                ++_a;
            }
            
            ++_v;
        }
    }
    
    #endregion
    
    
    
    #region Sources
    
    static __sources_clear = function()
    {
        if ((__rebind_state > 0) && (array_length(__source_array) > 0)) __binding_scan_failure(INPUT_BINDING_SCAN_EVENT.SOURCE_CHANGED);
        
        array_resize(__source_array, 0);
        __last_input_time = global.__input_current_time;
        
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
        
        if (__rebind_state > 0) __binding_scan_failure(INPUT_BINDING_SCAN_EVENT.SOURCE_CHANGED);
        
        array_push(__source_array, _source);
        __last_input_time = global.__input_current_time;
        
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
        if (_source == INPUT_GAMEPAD)
        {
            //If we pass in the INPUT_GAMEPAD array then return <true> if any source is a gamepad
            var _i = 0;
            repeat(array_length(__source_array))
            {
                if (__source_array[_i].__source == __INPUT_SOURCE.GAMEPAD) return true;
                ++_i;
            }
            
            return false;
        }
        
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i].__equal_to(_source)) return true;
            ++_i;
        }
        
        return false;
    }
    
    static __source_get_gamepad = function()
    {
        var _i = 0;
        repeat(array_length(__source_array))
        {
            var _gamepad = __source_array[_i].__gamepad;
            if (input_gamepad_is_connected(_gamepad)) return _gamepad;
            ++_i;
        }
        
        return -1;
    }
    
    static __sources_any_input = function()
    {
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i].__scan_for_binding(__index, true, 0, undefined)) return true;
            ++_i;
        }
        
        return false;
    }
    
    static __sources_validate_binding = function(_binding)
    {
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i].__validate_binding(_binding)) return true;
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
        _profile_name = __profile_get(_profile_name);
        if (_profile_name == undefined) return global.__input_null_binding; //Return a "static" empty binding
        
        return __profiles_dict[$ _profile_name][$ _verb][_alternate];
    }
    
    /// @param profileName
    /// @param verb
    /// @param alternate
    /// @param bindingStruct
    static __binding_set = function(_profile_name, _verb, _alternate, _binding_struct)
    {
        _profile_name = __profile_get(_profile_name);
        
        if (_profile_name == undefined)
        {
            __input_trace("Warning! Cannot set binding, profile was <undefined>");
            return;
        }
        
        if (((_profile_name == INPUT_AUTO_PROFILE_FOR_KEYBOARD)
          || (_profile_name == INPUT_AUTO_PROFILE_FOR_MOUSE)
          || (_profile_name == INPUT_AUTO_PROFILE_FOR_GAMEPAD))
        && (_profile_name != INPUT_AUTO_PROFILE_FOR_MIXED)
        && (_profile_name != INPUT_AUTO_PROFILE_FOR_MULTIDEVICE))
        {
            switch(_binding_struct.__get_source_type())
            {
                case __INPUT_SOURCE.KEYBOARD:
                    if not ((_profile_name == INPUT_AUTO_PROFILE_FOR_KEYBOARD)
                         || (INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER && (_profile_name == INPUT_AUTO_PROFILE_FOR_MOUSE)))
                    {
                        if (global.__input_strict_binding_check)
                        {
                            __input_error("Keyboard binding \"", input_binding_get_name(_binding_struct), "\" not supported for profile \"", _profile_name, "\"");
                        }
                        else
                        {
                            __input_trace("Warning! Keyboard binding \"", input_binding_get_name(_binding_struct), "\" not supported for profile \"", _profile_name, "\"");
                        }
                        
                        return;
                    }
                break;
            
                case __INPUT_SOURCE.MOUSE:
                    if not ((_profile_name == INPUT_AUTO_PROFILE_FOR_MOUSE)
                         || (INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER && (_profile_name == INPUT_AUTO_PROFILE_FOR_KEYBOARD)))
                    {
                        if (global.__input_strict_binding_check)
                        {
                            __input_error("Mouse binding \"", input_binding_get_name(_binding_struct), "\" not supported for profile \"", _profile_name, "\"");
                        }
                        else
                        {
                            __input_trace("Warning! Mouse binding \"", input_binding_get_name(_binding_struct), "\" not supported for profile \"", _profile_name, "\"");
                        }
                        
                        return;
                    }
                break;
            
                case __INPUT_SOURCE.GAMEPAD:
                    if not (_profile_name == INPUT_AUTO_PROFILE_FOR_GAMEPAD)
                    {
                        if (global.__input_strict_binding_check)
                        {
                            __input_error("Gamepad binding \"", input_binding_get_name(_binding_struct), "\" not supported for profile \"", _profile_name, "\"");
                        }
                        else
                        {
                            __input_trace("Warning! Gamepad binding \"", input_binding_get_name(_binding_struct), "\" not supported for profile \"", _profile_name, "\"");
                        }
                        
                        return;
                    }
                break;
            }
        }
        
        __profiles_dict[$ _profile_name][$ _verb][@ _alternate] = _binding_struct;
        __input_trace("Binding for profile \"", _profile_name, "\" verb \"", _verb, "\" alternate ", _alternate, " set to ", _binding_struct);
    }
    
    /// @param profileName
    /// @param verb
    /// @param alternate
    static __binding_remove = function(_profile_name, _verb, _alternate)
    {
        _profile_name = __profile_get(_profile_name);
        
        if (_profile_name == undefined)
        {
            __input_trace("Warning! Cannot remove binding, profile was <undefined>");
            return;
        }
        
        __profiles_dict[$ _profile_name][$ _verb][@ _alternate] = input_binding_empty();
        if (INPUT_DEBUG_BINDING) __input_trace("Binding for profile \"", _profile_name, "\" verb \"", _verb, "\" alternate ", _alternate, " removed (set to null)");
    }
    
    /// @param profileName
    /// @param verb
    /// @param alternate
    static __binding_reset = function(_profile_name, _verb, _alternate)
    {
        _profile_name = __profile_get(_profile_name);
        
        if (_profile_name == undefined)
        {
            __input_trace("Warning! Cannot reset binding, profile was <undefined>");
            return;
        }
        
        //Verify the profile
        var _default_profile_struct = global.__input_default_player.__profiles_dict[$ _profile_name];
        if (!is_struct(_default_profile_struct)) __input_error("Profile \"", _profile_name, "\" doesn't exist as a default profile");
        
        //Grab the equivalent binding from the default player
        var _binding_struct = _default_profile_struct[$ _verb][_alternate];
        
        //If the binding is a struct then duplicate so we don't get nasty
        if (is_struct(_binding_struct)) _binding_struct = _binding_struct.__duplicate();
        
        //And set the value!
        __profiles_dict[$ _profile_name][$ _verb][@ _alternate] = _binding_struct;
        
        if (INPUT_DEBUG_BINDING) __input_trace("Binding for profile \"", _profile_name, "\" verb \"", _verb, "\" alternate ", _alternate, " reset to ", _binding_struct);
    }
    
    #endregion
    
    
    
    #region Verbs
    
    static __verb_group_ensure = function(_verb_group)
    {
        if (!variable_struct_exists(__verb_group_state_dict, _verb_group)) __verb_group_state_dict[$ _verb_group] = true;
    }
    
    static __verb_group_active = function(_verb_group, _state, _exclusive)
    {
        var _old_state = __verb_group_state_dict[$ _verb_group];
        if (_old_state != _state)
        {
            //Set the state of the verb group
            __verb_group_state_dict[$ _verb_group] = _state;
            
            //Iterate over every verb for this group and get them to update their state
            var _array = global.__input_group_to_verbs_dict[$ _verb_group];
            if (_state)
            {
                //If the verb group is active then the verbs should be active too
                var _i = 0;
                repeat(array_length(_array))
                {
                    __verb_state_dict[$ _array[_i]].__group_inactive = false;
                    ++_i;
                }
            }
            else
            {
                //If the verb group is inactive then the verbs should be inactive too
                var _i = 0;
                repeat(array_length(_array))
                {
                    with(__verb_state_dict[$ _array[_i]])
                    {
                        __group_inactive = true;
                        previous_held    = true; //Force the held state on to avoid unwanted early reset of an inactive verb
                        __inactive       = true;
                        __toggle_state   = false; //Used for "toggle momentary" accessibility feature
                    }
                    
                    ++_i;
                }
            }
        }
        
        //If we're calling this function in exclusive mode, deactivate all the other verb groups
        if (_state && _exclusive)
        {
            var _i = 0;
            repeat(array_length(global.__input_verb_group_array))
            {
                var _found_group = global.__input_verb_group_array[_i];
                if (_found_group != _verb_group) __verb_group_active(_found_group, false, false);
                ++_i;
            }
        }
    }
    
    static __verb_group_is_active = function(_verb_group)
    {
        return __verb_group_state_dict[$ _verb_group];
    }
    
    /// @param verbName
    static __verb_ensure = function(_profile_name, _verb_name)
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
            
            var _verb = new __input_class_verb_state();
            _verb.__player = self;
            _verb.name     = _verb_name;
            _verb.type     = __INPUT_VERB_TYPE.__BASIC;
            
            __verb_state_dict[$ _verb_name] = _verb;
        }
        
        var _verb_alternate_array = _profile_struct[$ _verb_name];
        if (!is_array(_verb_alternate_array))
        {
            _verb_alternate_array = array_create(INPUT_MAX_ALTERNATE_BINDINGS);
            
            var _i = 0;
            repeat(INPUT_MAX_ALTERNATE_BINDINGS)
            {
                _verb_alternate_array[@ _i] = input_binding_empty();
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
            
            var _verb_state_struct = new __input_class_verb_state();
            _verb_state_struct.__player = self;
            _verb_state_struct.name     = _verb_name;
            _verb_state_struct.type     = __INPUT_VERB_TYPE.__CHORD;
            _verb_state_struct.analogue = false; //Chord verbs are never analogue
            __verb_state_dict[$ _verb_name] = _verb_state_struct;
            
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
            
            var _verb_state_struct = new __input_class_verb_state();
            _verb_state_struct.__player = self;
            _verb_state_struct.name     = _verb_name;
            _verb_state_struct.type     = __INPUT_VERB_TYPE.__COMBO;
            _verb_state_struct.analogue = false; //Combo verbs are never analogue
            __verb_state_dict[$ _verb_name] = _verb_state_struct;
            
            //We also need to store additional tracking information for combos
            __combo_state_dict[$ _verb_name] = new __input_class_combo_state(_verb_name, global.__input_combo_verb_dict[$ _verb_name]);
        }
    }
    
    #endregion
    
    
    
    /// @param axisName
    /// @param min
    /// @param max
    static __axis_threshold_set = function(_axis_name, _min, _max)
    {
        var _axis_struct = __axis_thresholds_dict[$ _axis_name];
        if (!is_struct(_axis_struct))
        {
            _axis_struct = {};
            __axis_thresholds_dict[$ _axis_name] = _axis_struct;
        }
        
        _axis_struct.mini = _min
        _axis_struct.maxi = _max;
        
        if (INPUT_DEBUG_BINDING) __input_trace("Axis threshold for axis \"", _axis_name, "\" set to ", _min, " -> ", _max);
        
        return _axis_struct;
    }
    
    /// @param axisName
    static __axis_threshold_get = function(_axis_name)
    {
        var _struct = __axis_thresholds_dict[$ _axis_name];
        if (is_struct(_struct)) return _struct;
        
        if (INPUT_DEBUG_BINDING) __input_trace("Warning! No axis threshold found for axis ", _axis_name);
        
        if (__input_axis_is_directional(_axis_name))
        {
            return __axis_threshold_set(_axis_name, INPUT_DEFAULT_AXIS_MIN_THRESHOLD, INPUT_DEFAULT_AXIS_MAX_THRESHOLD);
        }
        else
        {
            return __axis_threshold_set(_axis_name, INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD, INPUT_DEFAULT_TRIGGER_MAX_THRESHOLD);
        }
    }
    
    /// @param verb
    /// @param forceValue
    /// @param forceAnalogue
    static __verb_set = function(_verb_name, _value, _analogue)
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
        
        _profile_name = __profile_get(_profile_name);
        
        if (_profile_name == undefined)
        {
            __input_trace("Warning! Cannot get invaliid bindings, profile was <undefined>");
            return _output;
        }
        
        var _s = 0;
        repeat(array_length(__source_array))
        {
            var _profile_verb_struct = __profiles_dict[$ _profile_name];
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
    
    static __export = function(_output_string, _prettify)
    {
        var _new_profiles_dict = {};
        var _new_axis_thresholds_dict = {};
    
        var _root_json = {
            profiles:           _new_profiles_dict,
            axis_thresholds:    _new_axis_thresholds_dict,
            vibration_strength: __vibration_strength,
        };
        
        //Copy profiles
        var _profile_name_array = variable_struct_get_names(__profiles_dict);
        var _f = 0;
        repeat(array_length(_profile_name_array))
        {
            var _profile_name = _profile_name_array[_f];
            _new_profiles_dict[$ _profile_name] = __profile_export(_profile_name_array[_f], false, false);
            ++_f;
        }
        
        //Copy axis threshold data
        var _axis_name_array = variable_struct_get_names(__axis_thresholds_dict);
        var _a = 0;
        repeat(array_length(_axis_name_array))
        {
            var _axis_name = _axis_name_array[_a];
            var _thresholds_struct = __axis_thresholds_dict[$ _axis_name];
            
            _new_axis_thresholds_dict[$ _axis_name] = {
                mini: _thresholds_struct.mini,
                maxi: _thresholds_struct.maxi,
            };
            
            ++_a;
        }
        
        if (_output_string)
        {
            if (_prettify)
            {
                return __input_snap_to_json(_root_json, true, true);
            }
            else
            {
                return json_stringify(_root_json);
            }
        }
        else
        {
            return _root_json;
        }
    }
    
    static __import = function(_string)
    {
        if (is_string(_string))
        {
            var _json = json_parse(_string);
        }
        else
        {
            var _json = _string;
        }
        
        if (!is_struct(_json) && !is_array(_json))
        {
            __input_error("Input must be valid JSON (typeof=", _string, ")");
            return;
        }
        
        //Iterate over every profile in the JSON
        if (!is_struct(_json[$ "profiles"]))
        {
            __input_error("Player ", __index, " profiles are corrupted");
            return;
        }
        
        var _profiles_dict = _json.profiles;
        var _profile_name_array = variable_struct_get_names(_profiles_dict);
        var _f = 0;
        repeat(array_length(_profile_name_array))
        {
            var _profile_name = _profile_name_array[_f];
            __profile_import(_json.profiles[$ _profile_name], _profile_name);
            ++_f;
        }
        
        //Copy axis threshold data
        if (!is_struct(_json[$ "axis_thresholds"]))
        {
            __input_error("Player ", __index, " gamepad axis thresholds are corrupted");
            return;
        }
        
        var _axis_thresholds_dict = _json.axis_thresholds;
        var _axis_name_array = variable_struct_get_names(_axis_thresholds_dict);
        var _a = 0;
        repeat(array_length(_axis_name_array))
        {
            var _axis_name = _axis_name_array[_a];
            var _new_thresholds_struct = _axis_thresholds_dict[$ _axis_name];
            
            if (!is_struct(_new_thresholds_struct))
            {
                __input_error("Player ", __index, " gamepad axis thresholds are corrupted");
                return;
            }
            
            __axis_thresholds_dict[$ _axis_name] = {
                mini: _new_thresholds_struct.mini,
                maxi: _new_thresholds_struct.maxi,
            };
            
            ++_a;
        }
        
        if (variable_struct_exists(_json, "vibration_strength"))
        {
            if (!is_numeric(__vibration_strength))
            {
                __input_error("Player ", __index, " vibration strength is corrupted");
                return;
            }
            
            __vibration_strength = INPUT_VIBRATION_DEFAULT_STRENGTH;
        }
        else
        {
            __input_trace("Warning! Player ", __index, " vibration strength not found, defaulting to ", INPUT_VIBRATION_DEFAULT_STRENGTH);
            __vibration_strength = INPUT_VIBRATION_DEFAULT_STRENGTH;
        }
    }
    
    static __reset = function()
    {
        var _profile_name_array = variable_struct_get_names(__profiles_dict);
        var _i = 0;
        repeat(array_length(_profile_name_array))
        {
            var _profile_name = _profile_name_array[_i];
        
            if (!variable_struct_exists(global.__input_default_profile_dict, _profile_name))
            {
                //If this profile isn't a default, remove it
                __profile_destroy(_profile_name);
            }
            else
            {
                //Otherwise reset this profile
                __profile_reset_bindings(_profile_name);
            }
            
            ++_i;
        }
        
        __axis_thresholds_dict = {};
    }
    
    static __vibration_add_event = function(_event)
    {
        if (__vibration_paused && !_event.__force)
        {
            __input_trace("Warning! New vibration event ignored, player ", __index, " vibration is paused")
        }
        else
        {
            array_push(__vibration_event_array, _event);
        }
    }
    
    
    
    #region Tick functions
    
    static tick = function()
    {
        //Update our "connected" variable
        if (__ghost)
        {
            __connected = true;
            __post_disconnection_tick = false;
        }
        else
        {
            __connected = false;
            
            var _i = 0;
            repeat(array_length(__source_array))
            {
                if (__source_array[_i].__is_connected())
                {
                    __connected = true;
                    __post_disconnection_tick = false;
                    break;
                }
                
                ++_i;
            }
        }
        
        //Do one tick after disconnection to clear out verb state
        if (!__post_disconnection_tick)
        {
            //Make sure to tick binding scan first
            //This'll catch disconnection if and when it happens
            if (__rebind_state > 0) __tick_binding_scan();
            
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
            
            __cursor.__tick();
            
            __tick_vibration();
            
            if (!__connected) __post_disconnection_tick = true;
        }
    }
    
    static tick_basic_verbs = function()
    {
        var _v = 0;
        repeat(array_length(global.__input_basic_verb_array))
        {
            __verb_state_dict[$ global.__input_basic_verb_array[_v]].tick(__verb_group_state_dict);
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
    
    static __tick_vibration = function()
    {
        if (__connected && (global.__input_source_mode != INPUT_SOURCE_MODE.MULTIDEVICE)) //Don't vibrate if we're likely to have multiple gamepads assigned
        {
            var _gamepad_index = __source_get_gamepad();
            if (_gamepad_index < 0) return;
            
            var _not_paused = !__vibration_paused;
            var _left  = 0;
            var _right = 0;
            
            var _time_step = __input_get_time() - __input_get_previous_time();
            var _array = __vibration_event_array;
            var _i = 0;
            repeat(array_length(_array))
            {
                with(_array[_i])
                {
                    if (_not_paused || __force)
                    {
                        var _result = __tick(_time_step);
                        _left  += __output_left;
                        _right += __output_right;
                    }
                    else
                    {
                        var _result = true;
                    }
                }
                
                if (_result)
                {
                    ++_i;
                }
                else
                {
                    array_delete(_array, _i, 1);
                }
            }
            
            global.__input_gamepads[_gamepad_index].__vibration_set(__vibration_strength*_left, __vibration_strength*_right);
        }
    }
    
    static __tick_binding_scan = function()
    {
        #region Error checking
        
        //if (!input_window_has_focus())
        //{
        //    __input_trace("Binding scan failed: Game lost focus");
        //    __binding_scan_failure(INPUT_BINDING_SCAN_EVENT.LOST_FOCUS);
        //    return ;
        //}
        
        if (array_length(__rebind_source_filter) <= 0)
        {
            __input_trace("Binding scan failed: Source array for player ", __index, " is empty (the player has no source assigned)");
            __binding_scan_failure(INPUT_BINDING_SCAN_EVENT.SOURCE_INVALID);
            return ;
        }
        
        if (__ghost)
        {
            __input_trace("Binding scan failed: Player ", __index, " is a ghost");
            __binding_scan_failure(INPUT_BINDING_SCAN_EVENT.PLAYER_IS_GHOST);
            return;
        }
        
        if (!__connected)
        {
            __input_trace("Binding scan failed: Player ", __index, " disconnected");
            __binding_scan_failure(INPUT_BINDING_SCAN_EVENT.PLAYER_DISCONNECTED);
            return;
        }
        
        if (global.__input_current_time - __rebind_start_time > INPUT_BINDING_SCAN_TIMEOUT)
        {
            __input_trace("Binding scan failed: Timed out");
            __binding_scan_failure(INPUT_BINDING_SCAN_EVENT.SCAN_TIMEOUT);
            return;
        }
        
        #endregion
        
        if (__rebind_state == 1) //Waiting for the player to release all buttons
        {
            if (!__sources_any_input())
            {
                __input_trace("Now scanning for a new binding from player ", __index);
                __rebind_state = 2;
            }
        }
        else if (__rebind_state == 2) //Now grab the first button pressed
        {
            var _new_binding    = undefined;
            var _binding_source = undefined;
                
            var _i = 0;
            repeat(array_length(__rebind_source_filter))
            {
                if (instanceof(__rebind_source_filter[_i]) != "__input_class_source")
                {
                    __input_error("Value in filter array is not a source (index ", _i, ", ", __rebind_source_filter[_i], ")");
                }
                
                var _source_binding = __rebind_source_filter[_i].__scan_for_binding(__index, false, __rebind_ignore_struct, __rebind_allow_struct);
                if (_source_binding != undefined)
                {
                    var _new_binding    = _source_binding;
                    var _binding_source = __rebind_source_filter[_i];
                }
                    
                ++_i;
            }
            
            if (input_value_is_binding(_new_binding)) __binding_scan_success(_new_binding);
        }
    }
    
    static __binding_scan_success = function(_binding)
    {
        __input_trace("Binding found for player ", __index, ": \"", _binding, "\"");
        __rebind_state = 0;
        
        if (is_method(__rebind_success_callback))
        {
            __rebind_success_callback(_binding);
        }
        else if (is_numeric(__rebind_success_callback) && script_exists(__rebind_success_callback))
        {
            script_execute(__rebind_success_callback, _binding);
        }
        else if (__rebind_success_callback != undefined)
        {
            __input_error("Binding scan success callback set to an illegal value (typeof=", typeof(__rebind_success_callback), ")");
        }
    }
    
    static __binding_scan_failure = function(_error_code)
    {
        __input_trace("Binding scan for player ", __index, " failed (error=", _error_code, ")");
        __rebind_state = 0;
        
        if (is_method(__rebind_failure_callback))
        {
            __rebind_failure_callback(_error_code);
        }
        else if (is_numeric(__rebind_failure_callback) && script_exists(__rebind_failure_callback))
        {
            script_execute(__rebind_failure_callback, _error_code);
        }
        else if (__rebind_failure_callback != undefined)
        {
            __input_error("Binding scan failure callback set to an illegal value (typeof=", typeof(__rebind_failure_callback), ")");
        }
    }
    
    #endregion
}