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
    
    __trigger_effect_paused     = false;
    __trigger_effect_strength   = INPUT_TRIGGER_EFFECT_DEFAULT_STRENGTH;
    __trigger_intercepted_left  = false;
    __trigger_intercepted_right = false;
    __trigger_effect_left       = undefined;
    __trigger_effect_right      = undefined;

    __color = undefined;
    
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
    
    __gyro_gamepad       = undefined;
    __gyro_axis_x        = INPUT_GYRO_DEFAULT_AXIS_X;
    __gyro_axis_y        = INPUT_GYRO_DEFAULT_AXIS_Y;
    __gyro_sensitivity_x = INPUT_GYRO_DEFAULT_SENSITIVITY_X;
    __gyro_sensitivity_y = INPUT_GYRO_DEFAULT_SENSITIVITY_Y;
    
    __gyro_enabled_set(true);
    __gyro_enabled = false;
    
    
    
    #region Profiles
    
    static __profile_create = function(_profile_name)
    {
        if (variable_struct_exists(__profiles_dict, _profile_name)) __input_error("Profile \"", _profile_name, "\" already exists for player ", __index);
        
        if (__INPUT_DEBUG_PROFILES) __input_trace("Profile \"", _profile_name, "\" created for player ", __index);
        
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
        
        if (__INPUT_DEBUG_PROFILES) __input_trace("Profile \"", _profile_name, "\" destroyed for player ", __index);
        
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
                case __INPUT_SOURCE.TOUCH:    return INPUT_AUTO_PROFILE_FOR_TOUCH;    break;
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
                _existing_verb_dict[$ _verb_name] = _existing_alternate_array;
            }
            
            //Wipe existing bindings so if we have a length mismatch we don't get junk left behind
            var _a = 0;
            repeat(INPUT_MAX_ALTERNATE_BINDINGS)
            {
                _existing_alternate_array[@ _a] = input_binding_empty();
                ++_a;
            }
            
            //Verify that the input data has this verb
            var _alternate_array = _json[$ _verb_name];
            if (!is_array(_alternate_array)) __input_error("Player ", __index, " data is missing verb \"", _verb_name, "\"");
            
            if (!INPUT_FLEXIBLE_ALTERNATE_BINDING_IMPORT && (array_length(_alternate_array) != INPUT_MAX_ALTERNATE_BINDINGS))
            {
                __input_error("JSON malformed, player ", __index, " verb \"", _verb_name, "\" should have ", INPUT_MAX_ALTERNATE_BINDINGS, " alternate bindings, but it had ", array_length(_alternate_array));
            }
            
            //Iterate over every alternate and import the value into our local data
            var _a = 0;
            repeat(min(array_length(_alternate_array), INPUT_MAX_ALTERNATE_BINDINGS))
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
        
        //Reset all gamepad colours and trigger effects
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i].__source == __INPUT_SOURCE.GAMEPAD)
            {
                __input_gamepad_reset_color(__source_array[_i].__gamepad);
                __input_gamepad_stop_trigger_effects(__source_array[_i].__gamepad);
            }
        }
        
        //Clear the touch input tracking variable if it's us!
        if (global.__input_touch_player == self) __input_virtual_player_set(undefined);
        
        array_resize(__source_array, 0);
        __last_input_time = global.__input_current_time; //Set the last input time to delay hotswapping for a little while
        
        if (__INPUT_DEBUG_SOURCES) __input_trace("Sources cleared for player ", __index);
    }
    
    /// @param source
    static __source_add = function(_source)
    {
        //Ensure we're targeting the right source for our platform / configuration
        if (__INPUT_TOUCH_PRIMARY)
        {
            if (_source == INPUT_MOUSE) _source = INPUT_TOUCH;
        }
        else
        {
            if (_source == INPUT_TOUCH) _source = INPUT_MOUSE;
        }
        
        //We don't use __source_contains() here because it'll report a false positive when assigning keyboard+mouse together
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i] == _source)
            {
                if (__INPUT_DEBUG_SOURCES) __input_trace("Cannot add ", _source, " to player ", __index, ", it has already been assigned");
                return;
            }
            
            ++_i;
        }
        
        if (__rebind_state > 0) __binding_scan_failure(INPUT_BINDING_SCAN_EVENT.SOURCE_CHANGED);
        
        array_push(__source_array, _source);
        __last_input_time = global.__input_current_time; //Set the last input time to delay hotswapping for a little while
        __color_set(__color);        
        __input_player_apply_trigger_effects(__index);
        
        //Set the touch player index
        if ((_source == INPUT_TOUCH) || (INPUT_MOUSE_ALLOW_VIRTUAL_BUTTONS && (_source == INPUT_MOUSE))) __input_virtual_player_set(self);
        
        if (__INPUT_DEBUG_SOURCES) __input_trace("Assigned source ", _source, " to player ", __index);
    }
    
    /// @param source
    static __source_remove = function(_source)
    {
        //Ensure we're targeting the right source for our platform / configuration
        if (__INPUT_TOUCH_PRIMARY)
        {
            if (_source == INPUT_MOUSE) _source = INPUT_TOUCH;
        }
        else
        {
            if (_source == INPUT_TOUCH) _source = INPUT_MOUSE;
        }
        
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i] == _source)
            {
                //Reset gamepad colours and trigger effects when removing a gamepad source
                if (__source_array[_i].__source == __INPUT_SOURCE.GAMEPAD)
                {
                    __input_gamepad_reset_color(__source_array[_i].__gamepad);
                    __input_gamepad_stop_trigger_effects(__source_array[_i].__gamepad);
                }
                 
                //Clear the touch input tracking variable if it's us!
                if (((_source == INPUT_TOUCH) || (INPUT_MOUSE_ALLOW_VIRTUAL_BUTTONS && (_source == INPUT_MOUSE))) && (global.__input_touch_player == self)) __input_virtual_player_set(undefined);
                
                array_delete(__source_array, _i, 1);
                if (__INPUT_DEBUG_SOURCES) __input_trace("Removed source ", _source, " from player ", __index);
            }
            else
            {
                ++_i;
            }
        }
    }
    
    /// @param source
    static __source_contains = function(_source, _touch_remap = true)
    {
        //Ensure we're targeting the right source for our platform / configuration
        if (_touch_remap)
        {
            if (__INPUT_TOUCH_PRIMARY)
            {
                if (_source == INPUT_MOUSE) _source = INPUT_TOUCH;
            }
            else
            {
                if (_source == INPUT_TOUCH) _source = INPUT_MOUSE;
            }
        }
        
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
    /// @param allowFallback
    static __binding_get = function(_profile_name, _verb, _alternate, _allowFallback)
    {
        static _empty_binding = input_binding_empty();
        
        _profile_name = __profile_get(_profile_name);
        
        //Welp, we have no profile for this player
        //This'll usually happen if the player is yet to be assigned a source/profile during hotswapping
        if (_profile_name == undefined)
        {
            if (!_allowFallback) return _empty_binding;
            
            if (INPUT_FALLBACK_PROFILE_BEHAVIOR == 1)
            {
                if (__INPUT_ON_DESKTOP && global.__input_keyboard_allowed && global.__input_any_keyboard_binding_defined)
                {
                    //Try to use a keyboard profile if possible
                    _profile_name = INPUT_AUTO_PROFILE_FOR_KEYBOARD;
                }
                else if (global.__input_any_gamepad_binding_defined)
                {
                    //Try to use a gamepad profile if possible
                    _profile_name = INPUT_AUTO_PROFILE_FOR_GAMEPAD;
                }
                else
                {
                    //Return a "static" empty binding since everything else failed
                    return _empty_binding;
                }
            }
            else if ((INPUT_FALLBACK_PROFILE_BEHAVIOR == 2) && global.__input_any_gamepad_binding_defined)
            {
                //Try to use a gamepad profile if possible
                _profile_name = INPUT_AUTO_PROFILE_FOR_GAMEPAD;
            }
            else
            {
                return _empty_binding;
            }
        }
        
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
          || (_profile_name == INPUT_AUTO_PROFILE_FOR_TOUCH)
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
                
                case __INPUT_SOURCE.TOUCH:
                    if not (_profile_name == INPUT_AUTO_PROFILE_FOR_TOUCH)
                    {
                        if (global.__input_strict_binding_check)
                        {
                            __input_error("Touchscreen binding \"", input_binding_get_name(_binding_struct), "\" not supported for profile \"", _profile_name, "\"");
                        }
                        else
                        {
                            __input_trace("Warning! Touchscreen binding \"", input_binding_get_name(_binding_struct), "\" not supported for profile \"", _profile_name, "\"");
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
        __input_trace("Binding for profile \"", _profile_name, "\" verb \"", _verb, "\" alternate ", _alternate, " set to \"", input_binding_get_name(_binding_struct), "\"");
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
        if (__INPUT_DEBUG_BINDING) __input_trace("Binding for profile \"", _profile_name, "\" verb \"", _verb, "\" alternate ", _alternate, " removed (set to null)");
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
        
        if (__INPUT_DEBUG_BINDING) __input_trace("Binding for profile \"", _profile_name, "\" verb \"", _verb, "\" alternate ", _alternate, " reset to \"", input_binding_get_name(_binding_struct), "\"");
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
            if (__INPUT_DEBUG_VERBS) __input_trace("Verb \"", _verb_name, "\" not found on player ", __index, ", creating a new one");
            
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
            if (__INPUT_DEBUG_VERBS) __input_trace("Verb \"", _verb_name, "\" not found on player ", __index, ", creating a new one as a chord");
            
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
            if (__INPUT_DEBUG_VERBS) __input_trace("Verb \"", _verb_name, "\" not found on player ", __index, ", creating a new one as a combo");
            
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
        
        if (__INPUT_DEBUG_BINDING) __input_trace("Axis threshold for axis \"", _axis_name, "\" set to ", _min, " -> ", _max);
        
        return _axis_struct;
    }
    
    /// @param axisName
    static __axis_threshold_get = function(_axis_name)
    {
        var _struct = __axis_thresholds_dict[$ _axis_name];
        if (is_struct(_struct)) return _struct;
        
        if (__INPUT_DEBUG_BINDING) __input_trace("Warning! No axis threshold found for axis ", _axis_name);
        
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
    
    /// @param verb
    /// @param forceRawValue
    /// @param forceValue
    /// @param forceAnalogue
    static __verb_set_from_virtual = function(_verb_name, _raw_value, _value, _analogue)
    {
        if (is_string(_verb_name))
        {
            with(__verb_state_dict[$ _verb_name])
            {
                if (_value > (__virtual_value ?? -infinity))
                {
                    __virtual_value     = _value;
                    __virtual_raw_value = _raw_value;
                    __virtual_analogue  = _analogue;
                }
            }
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
        var _new_profiles_dict        = {};
        var _new_axis_thresholds_dict = {};
        var _new_gyro_params          = {};
    
        var _root_json = {
            profiles:           _new_profiles_dict,
            axis_thresholds:    _new_axis_thresholds_dict,
            gyro:               _new_gyro_params,
            vibration_strength: __vibration_strength,     
            trigger_effect_strength: __trigger_effect_strength,       
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
        
        //Copy gyro parameters
        _new_gyro_params.axis_x        = __gyro_axis_x;
        _new_gyro_params.axis_y        = __gyro_axis_y;
        _new_gyro_params.sensitivity_x = __gyro_sensitivity_x;
        _new_gyro_params.sensitivity_y = __gyro_sensitivity_y;
        
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
        
        //Copy gyro data
        if (variable_struct_exists(_json, "gyro"))
        {
            if (!is_struct(_json.gyro))
            {
                __input_error("Player ", __index, " gyro parameters are corrupted");
                return;
            }
            
            __gyro_axis_x        = _json.gyro.axis_x;
            __gyro_axis_y        = _json.gyro.axis_y;
            __gyro_sensitivity_x = _json.gyro.sensitivity_x;
            __gyro_sensitivity_y = _json.gyro.sensitivity_y;
        }
        else
        {
            __input_trace("Warning! Player ", __index, " gyro parameters not found, using defaults");
            __gyro_axis_x        = INPUT_GYRO_DEFAULT_AXIS_X;
            __gyro_axis_y        = INPUT_GYRO_DEFAULT_AXIS_Y;
            __gyro_sensitivity_x = INPUT_GYRO_DEFAULT_SENSITIVITY_X;
            __gyro_sensitivity_y = INPUT_GYRO_DEFAULT_SENSITIVITY_Y;
        }
        
        if (variable_struct_exists(_json, "vibration_strength"))
        {
            if (!is_numeric(_json.vibration_strength))
            {
                __input_error("Player ", __index, " vibration strength is corrupted");
                return;
            }
            
            __vibration_strength = _json.vibration_strength;
        }
        else
        {
            __input_trace("Warning! Player ", __index, " vibration strength not found, defaulting to ", INPUT_VIBRATION_DEFAULT_STRENGTH);
            __vibration_strength = INPUT_VIBRATION_DEFAULT_STRENGTH;
        }
        
        if (variable_struct_exists(_json, "trigger_effect_strength"))
        {
            if (!is_numeric(__trigger_effect_strength))
            {
                __input_error("Player ", __index, " trigger effect strength is corrupted");
                return;
            }
            
            __trigger_effect_strength = INPUT_TRIGGER_EFFECT_DEFAULT_STRENGTH;
        }
        else
        {
            __input_trace("Warning! Player ", __index, " trigger effect strength not found, defaulting to ", INPUT_TRIGGER_EFFECT_DEFAULT_STRENGTH);
            __vibration_strength = INPUT_TRIGGER_EFFECT_DEFAULT_STRENGTH;
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
        __vibration_strength   = INPUT_VIBRATION_DEFAULT_STRENGTH;
        __gyro_axis_x          = INPUT_GYRO_DEFAULT_AXIS_X;
        __gyro_axis_y          = INPUT_GYRO_DEFAULT_AXIS_Y;
        __gyro_sensitivity_x   = INPUT_GYRO_DEFAULT_SENSITIVITY_X;
        __gyro_sensitivity_y   = INPUT_GYRO_DEFAULT_SENSITIVITY_Y;
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
    
    static __trigger_effect_set = function(_trigger, _effect, _set)
    {
        var _gamepad = __source_get_gamepad();
        if ((_gamepad < 0) || !is_struct(_effect)) return;
        
        if (__trigger_effect_paused)
        {
            __input_trace("Warning! New trigger effect ignored, player ", __index, " trigger effect is paused");
            return;
        }

        var _intercepted = (global.__input_gamepads[_gamepad].__trigger_effect_apply(_trigger, _effect, __trigger_effect_strength) == false);
        
        if (!_set) return;
        if (_trigger == gp_shoulderlb)
        {
            __trigger_intercepted_left = _intercepted;
            __trigger_effect_left      = _effect;
        }
        else if (_trigger == gp_shoulderrb)
        {
            __trigger_intercepted_right = _intercepted;
            __trigger_effect_right      = _effect;                 
        }
        else
        {
            __input_error("Value ", _trigger ," not a gamepad trigger");
            return false;
        }
    }
    
    static __trigger_effect_pause = function(_state)
    {
        __trigger_effect_paused = _state;
    
        if (!_state)
        {
            __input_player_apply_trigger_effects(__index);
        }
        else
        {
            var _gamepad = __source_get_gamepad();
            if (_gamepad < 0) return;
        
            __input_gamepad_stop_trigger_effects(_gamepad);
        }
    }
    
    static __motion_data_get = function()
    {
        if ((global.__input_source_mode == INPUT_SOURCE_MODE.MIXED) && (__gyro_gamepad == undefined))
        {
            static __mixed_motion = {};
            with  (__mixed_motion)
            {
                acceleration_x = 0.0;
                acceleration_y = 0.0;
                acceleration_z = 0.0;

                angular_velocity_x = 0.0;
                angular_velocity_y = 0.0;
                angular_velocity_z = 0.0;
            }
    
            var _source_motion = undefined;
            var _motion_names  = variable_struct_get_names(__mixed_motion);
            var _using_motion  = false;
        
            var _name    = 0;
            var _gamepad = 0;
            repeat(array_length(global.__input_gamepads))
            {
                if not (is_struct(global.__input_gamepads[_gamepad])) continue;
            
                _using_motion  = true;
                _source_motion = global.__input_gamepads[_gamepad].__motion.__tick();
        
                _name = 0;
                repeat(array_length(_motion_names))
                {
                    __mixed_motion[$ _motion_names[_name]] += _source_motion[$ _motion_names[_name]];
                    ++_name;
                }
        
                ++_gamepad;
            }
    
            if not (_using_motion) __mixed_motion.acceleration_y = -1.0;
            return __mixed_motion;
        }
    
        var _gamepad_index = __gyro_gamepad;
        if ((global.__input_source_mode != INPUT_SOURCE_MODE.MULTIDEVICE) || (__gyro_gamepad == undefined))
        {
            _gamepad_index = __source_get_gamepad();
        }
    
        if ((_gamepad_index < 0) || !is_struct(global.__input_gamepads[_gamepad_index].__motion))
        {
            return undefined;
        }

        return global.__input_gamepads[_gamepad_index].__motion.__tick();
    }
    
    static __gyro_enabled_set = function(_state)
    {
        if (_state)
        {
            __gyro_screen_width  = display_get_width();
            __gyro_screen_height = display_get_height();
            
            switch(global.__input_pointer_coord_space)
            {
                case INPUT_COORD_SPACE.ROOM:
                    var _view_active = false;
                    try
                    {
                        _view_active = (view_enabled && view_visible[0]);
                    }
                    catch(_error)
                    {
                        __input_trace("Warning! Failed to determine whether a view is active");
                    }
                    
                    if (_view_active)
                    {
                        var _camera = view_camera[0];
                        __gyro_screen_width  = camera_get_view_width(_camera);
                        __gyro_screen_height = camera_get_view_height(_camera);
                    }
                    else
                    {
                        __gyro_screen_width  = room_width;
                        __gyro_screen_height = room_height;
                    }
                break;

                case INPUT_COORD_SPACE.GUI:                        
                    __gyro_screen_width  = display_get_gui_width();
                    __gyro_screen_height = display_get_gui_height();
                break;

                case INPUT_COORD_SPACE.DEVICE:
                    if (!__INPUT_ON_CONSOLE && (window_get_width != undefined))
                    {
                        __gyro_screen_width  = window_get_width();
                        __gyro_screen_height = window_get_height();
                    }
                break;
            }
        }
        
        __gyro_enabled = _state;
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
        if (__connected && (global.__input_source_mode != INPUT_SOURCE_MODE.MIXED) && (global.__input_source_mode != INPUT_SOURCE_MODE.MULTIDEVICE)) //Don't vibrate if we're likely to have multiple gamepads assigned
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
    
    static __color_set = function(_color)
    {        
        var _i = 0;
        repeat(array_length(__source_array))
        {
            if (__source_array[_i].__source == __INPUT_SOURCE.GAMEPAD)
            {
                with global.__input_gamepads[__source_array[_i].__gamepad] __color_set(_color);
            }   
            
            ++_i;
        }
        
        __color = _color;
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
        
        if (__source_contains(INPUT_TOUCH, false))
        {
            __input_trace("Binding scan failed: Player ", __index, " is using INPUT_TOUCH which cannot be rebound");
            __binding_scan_failure(INPUT_BINDING_SCAN_EVENT.SOURCE_INVALID);
            return;
        }
        
        if (array_length(__rebind_source_filter) <= 0)
        {
            __input_trace("Binding scan failed: Source array for player ", __index, " is empty (the player has no source assigned)");
            __binding_scan_failure(INPUT_BINDING_SCAN_EVENT.SOURCE_INVALID);
            return;
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
                if (global.__input_use_is_instanceof)
                {
                    if (!is_instanceof(__rebind_source_filter[_i], __input_class_source))
                    {
                        __input_error("Value in filter array is not a source (index ", _i, ", ", __rebind_source_filter[_i], ")");
                    }
                }
                else
                {
                    if (instanceof(__rebind_source_filter[_i]) != "__input_class_source")
                    {
                        __input_error("Value in filter array is not a source (index ", _i, ", ", __rebind_source_filter[_i], ")");
                    }
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
