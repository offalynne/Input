// Feather disable all

function __input_class_combo_state(_name, _combo_def) constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE
    
    __name  = _name;
    __combo = _combo_def;
    
    __reset();
    
    
    
    static __evaluate = function(_player_verb_struct)
    {
        static _all_verb_array = _global.__all_verb_array;
        
        __new_phase = false;
        
        var _phase_array = __combo.__phase_array;
        var _combo_length = array_length(_phase_array);
        if (_combo_length <= 0) return false;
        
        if (__success)
        {
            if (not __check_valid())
            {
                if (INPUT_COMBO_DEBUG) __input_trace("Resetting successful combo \"", __name, "\"");
                __reset();
            }
        }
        else
        {
            var _phase_data = _phase_array[__phase];
            var _phase_type = _phase_data.__type;
            var _phase_verb = _phase_data.__verb;
            
            if ((__direction == undefined) && __combo.__directional)
            {
                with(_global.__combo_params)
                {
                    if (not __reset)
                    {
                        if (__side_on)
                        {
                            if (_phase_verb == __forward_verb)
                            {
                                __direction = __reference_direction;
                                //No direction mapping needed
                            }
                            else if (_phase_verb == __backward_verb)
                            {
                                __direction = (__reference_direction + 180 + 3600) mod 360; //Use a big offset here to fix any weird shit people do
                                
                                //Set up a mapping to flip forward/backward verbs
                                __direction_mapping[$ __forward_verb ] = __backward_verb;
                                __direction_mapping[$ __backward_verb] = __forward_verb;
                            }
                        }
                        else
                        {
                            if (_phase_verb == __forward_verb)
                            {
                                __direction = __reference_direction;
                                //No direction mapping needed
                            }
                            else if (_phase_verb == __counterclockwise_verb)
                            {
                                __direction = (__reference_direction + 90 + 3600) mod 360; //Use a big offset here to fix any weird shit people do
                                
                                //Set up a mapping to flip forward/backward verbs
                                __direction_mapping[$ __forward_verb         ] = __counterclockwise_verb;
                                __direction_mapping[$ __counterclockwise_verb] = __backward_verb;
                                __direction_mapping[$ __backward_verb        ] = __clockwise_verb;
                                __direction_mapping[$ __clockwise_verb       ] = __forward_verb;
                            }
                            else if (_phase_verb == __backward_verb)
                            {
                                __direction = (__reference_direction + 180 + 3600) mod 360; //Use a big offset here to fix any weird shit people do
                                
                                //Set up a mapping to flip forward/backward verbs
                                __direction_mapping[$ __forward_verb         ] = __backward_verb;
                                __direction_mapping[$ __counterclockwise_verb] = __clockwise_verb;
                                __direction_mapping[$ __backward_verb        ] = __forward_verb;
                                __direction_mapping[$ __clockwise_verb       ] = __counterclockwise_verb;
                            }
                            else if (_phase_verb == __backward_verb)
                            {
                                __direction = (__reference_direction + 270 + 3600) mod 360; //Use a big offset here to fix any weird shit people do
                                
                                //Set up a mapping to flip forward/backward verbs
                                __direction_mapping[$ __forward_verb         ] = __clockwise_verb;
                                __direction_mapping[$ __counterclockwise_verb] = __forward_verb;
                                __direction_mapping[$ __backward_verb        ] = __counterclockwise_verb;
                                __direction_mapping[$ __clockwise_verb       ] = __backward_verb;
                            }
                        }
                    }
                }
            }
            
            //Remap verbs based on directionality
            _phase_verb = __direction_mapping[$ _phase_verb] ?? _phase_verb;
            
            //Keep measuring the length of a charge until
            if (__charge_measure)
            {
                __charge_end_time = __input_get_time();
            }
            else
            {
                if (__phase > 0)
                {
                    if (__input_get_time() - __start_time > __combo.__phase_timeout)
                    {
                        if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" timeout failed (phase=", __phase, ")");
                        __reset();
                        return false;
                    }
                }
            }
            
            var _verb_state = _player_verb_struct[$ _phase_verb];
            if (not _verb_state.__inactive)
            {
                switch(_phase_type)
                {
                    case __INPUT_COMBO_PHASE.__PRESS:
                        if (_verb_state.press)
                        {
                            if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" phase ", __phase, " passed (press \"", _phase_verb, "\")");
                            __add_to_allow_hold_dict(_phase_verb);
                            __next_phase(_phase_array, true);
                        }
                    break;
                    
                    case __INPUT_COMBO_PHASE.__RELEASE:
                        if (_verb_state.release)
                        {
                            if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" phase ", __phase, " passed (release \"", _phase_verb, "\")");
                            __remove_from_allow_hold_dict(_phase_verb);
                            __remove_from_require_hold_array(_phase_verb);
                            __next_phase(_phase_array, true);
                        }
                    break;
                    
                    case __INPUT_COMBO_PHASE.__PRESS_OR_RELEASE:
                        if (_verb_state.press)
                        {
                            if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" phase ", __phase, " passed (PRESS or release \"", _phase_verb, "\")");
                            __add_to_allow_hold_dict(_phase_verb);
                            __next_phase(_phase_array, true);
                        }
                        else if (_verb_state.release)
                        {
                            if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" phase ", __phase, " passed (press or RELEASE \"", _phase_verb, "\")");
                            __remove_from_allow_hold_dict(_phase_verb);
                            __remove_from_require_hold_array(_phase_verb);
                            __next_phase(_phase_array, true);
                        }
                    break;
                    
                    case __INPUT_COMBO_PHASE.__HOLD:
                        if (_verb_state.held)
                        {
                            if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" phase ", __phase, " passed (hold \"", _phase_verb, "\")");
                            __add_to_allow_hold_dict(_phase_verb);
                            __add_to_require_hold_array(_phase_verb);
                            __next_phase(_phase_array, true);
                        }
                    break;
                    
                    case __INPUT_COMBO_PHASE.__CHARGE:
                        if (_verb_state.held)
                        {
                            if (__charge_trigger)
                            {
                                __charge_trigger = false;
                                __charge_measure = true;
                                
                                if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" phase ", __phase, " charge started (verb \"", _phase_verb, "\")");
                                
                                __add_to_allow_hold_dict(_phase_verb);
                                __add_to_require_hold_array(_phase_verb);
                                
                                __charge_start_time = __input_get_time();
                                __charge_end_time   = __input_get_time();
                            }
                            else
                            {
                                if (__input_get_time() - __charge_start_time > _phase_data.__min_time)
                                {
                                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" phase ", __phase, " passed (charge \"", _phase_verb, "\" for over ", _phase_data.__min_time, (INPUT_TIMER_MILLISECONDS? "ms" : " frames"), ")");
                                    __next_phase(_phase_array, false);
                                }
                            }
                        }
                    break;
                }
            }
            
            if (__check_valid())
            {
                if (__phase >= _combo_length)
                {
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" success");
                    __success = true;
                }
            }
            else
            {
                __reset();
            }
        }
        
        return __success;
    }
    
    static __next_phase = function(_phase_array, _reset_charge)
    {
        ++__phase;
        __new_phase = true;
        __start_time = __input_get_time();
        
        //Stop measuring the length of the charge
        if (_reset_charge) __charge_measure = false;
        
        //Allow retriggering of a charge phase if that's the next type we're going to evaluate
        if ((__phase < array_length(_phase_array))
        &&  (_phase_array[__phase].__type == __INPUT_COMBO_PHASE.__CHARGE))
        {
            __charge_trigger = false;
        }
    }
    
    static __check_valid = function()
    {
        //Check everything that's meant to be pressed is being pressed
        var _i = 0;
        repeat(array_length(__require_hold_array))
        {
            var _verb = __require_hold_array[_i];
            if (not _player_verb_struct[$ _verb].held) return false;
            ++_i;
        }
        
        //Check that nothing that shouldn't be pressed is being pressed
        var _i = 0;
        repeat(array_length(_all_verb_array))
        {
            var _verb = _all_verb_array[_i];
                
            var _state = _player_verb_struct[$ _verb];
            if (not _state.__inactive)
            {
                if (variable_struct_exists(__allow_hold_dict, _verb))
                {
                    //Once a verb has been released, don't allow it to be retriggered
                    if (not _state.held) variable_struct_remove(__allow_hold_dict, _verb);
                }
                else
                {
                    if (_state.held) return false;
                }
            }
            
            ++_i;
        }
        
        return true;
    }
    
    
    
    static __add_to_allow_hold_dict = function(_verb)
    {
        __allow_hold_dict[$ _verb] = true;
    }
    
    static __remove_from_allow_hold_dict = function(_verb)
    {
        variable_struct_remove(__allow_hold_dict, _verb);
    }
    
    static __add_to_require_hold_array = function(_verb)
    {
        var _i = 0;
        repeat(array_length(__require_hold_array))
        {
            if (__require_hold_array[_i] == _verb) return;            
            ++_i;
        }
        
        array_push(__require_hold_array, _verb);
    }
    
    static __remove_from_require_hold_array = function(_verb)
    {
        var _i = 0;
        repeat(array_length(__require_hold_array))
        {
            if (__require_hold_array[_i] == _verb)
            {
                array_delete(__require_hold_array, _i, 1);
                return;
            }
            
            ++_i;
        }
    }
    
    
    
    static __reset = function()
    {
        __success   = false;
        __direction = undefined;
        
        __phase       = 0;
        __new_phase   = false;
        __start_time  = undefined;
        
        __charge_trigger    = true;
        __charge_measure    = false;
        __charge_start_time = undefined;
        __charge_end_time   = undefined;
        
        __allow_hold_dict    = {};
        __require_hold_array = [];
        
        __direction         = undefined;
        __direction_mapping = {};
    }
}