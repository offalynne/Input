// Feather disable all

function __input_class_combo_state(_name, _combo_def) constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE
    static __combo_params = __global.__combo_params;
    
    __name  = _name;
    __combo = _combo_def;
    
    __phase = 0;
    __reset();
    
    
    
    
    
    static __reset = function()
    {
        __success   = false;
        __direction = undefined;
        
        __new_phase   = (__phase != 0);
        __phase       = 0;
        __start_time  = __input_get_time();
        
        __charge_trigger    = true;
        __charge_measure    = false;
        __charge_start_time = undefined;
        __charge_end_time   = undefined;
        
        __allow_hold_dict    = {};
        __require_hold_array = [];
        
        __direction         = undefined;
        __direction_mapping = {};
    }
    
    static __evaluate = function(_player_verb_struct)
    {
        static _all_verb_array = __global.__all_verb_array;
        
        __new_phase = false;
        if (__success) __reset();
        
        var _phase_array = __combo.__phase_array;
        var _combo_length = array_length(_phase_array);
        if (_combo_length <= 0) return false;
        
        var _phase_data = _phase_array[__phase];
        var _phase_type = _phase_data.__type;
        var _phase_verb = _phase_data.__verb;
        
        if ((__direction == undefined) && __combo.__directional)
        {
            __determine_direction(_player_verb_struct, _phase_verb);
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
            if ((__phase > 0) && (__input_get_time() - __start_time > __combo.__phase_timeout))
            {
                if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" timeout failed (phase=", __phase, ")");
                __reset();
                return false;
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
                    if (not _verb_state.held)
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
        
        if (__check_valid(_player_verb_struct))
        {
            if (__phase >= _combo_length)
            {
                if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" success");
                    
                __success = true;
                return true;
            }
        }
        else
        {
            __reset();
        }
        
        return false;
    }
    
    static __next_phase = function(_phase_array, _reset_charge)
    {
        if (__charge_measure)
        {
            //Stop measuring the length of the charge
            if (_reset_charge) 
            {
                __charge_measure = false;
            }
            else
            {
                var _verb = _phase_array[__phase].__verb;
                _verb = __direction_mapping[$ _verb] ?? _verb;
                
                //Remove hold requirement when charge isn't reset
                __remove_from_require_hold_array(_verb);
            }
        }
        
        //Allow retriggering of a charge phase if that's the next type we're going to evaluate
        if ((__phase < array_length(_phase_array))
        &&  (_phase_array[__phase].__type == __INPUT_COMBO_PHASE.__CHARGE))
        {
            __charge_trigger = true;
        }
        
        ++__phase;
        __new_phase = true;
        __start_time = __input_get_time();
    }
    
    static __check_valid = function(_player_verb_struct)
    {
        static _all_verb_array = __global.__all_verb_array;
        var _ignore_dict = __combo.__ignore_dict;
        
        //Check everything that's meant to be pressed is being pressed
        var _i = 0;
        repeat(array_length(__require_hold_array))
        {
            var _verb = __require_hold_array[_i];
            if (not _player_verb_struct[$ _verb].held)
            {
                if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" failed, verb \"", _verb, "\" not held (phase=", __phase, ")");
                return false;
            }
            
            ++_i;
        }
        
        //Check that nothing that shouldn't be pressed isn't being pressed
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
                else if (not variable_struct_exists(_ignore_dict, __direction_mapping[$ _verb] ?? _verb)) //Don't trigger a failure if this verb has been ignored
                {
                    if (_state.held)
                    {
                        if (INPUT_COMBO_DEBUG && (__phase != 0)) __input_trace("Combo \"", __name, "\" failed, verb \"", _verb, "\" pressed erroneously (phase=", __phase, ")");
                        return false;
                    }
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
    
    
    
    static __determine_direction = function(_player_verb_struct, _phase_verb)
    {
        if (not __combo_params.__reset)
        {
            var _forward_verb          = __combo_params.__forward_verb;
            var _counterclockwise_verb = __combo_params.__counterclockwise_verb;
            var _backward_verb         = __combo_params.__backward_verb;
            var _clockwise_verb        = __combo_params.__clockwise_verb;
            
            var _forward_struct           = (_forward_verb          == undefined)? undefined : _player_verb_struct[$ _forward_verb];
            var _counterclockwise_struct  = (_counterclockwise_verb == undefined)? undefined : _player_verb_struct[$ _counterclockwise_verb];
            var _backward_struct          = (_backward_verb         == undefined)? undefined : _player_verb_struct[$ _backward_verb];
            var _clockwise_struct         = (_clockwise_verb        == undefined)? undefined : _player_verb_struct[$ _clockwise_verb];
            
            var _forward_state          = is_struct(_forward_struct         ) && (not           _forward_struct.__inactive) && _forward_struct.held;
            var _counterclockwise_state = is_struct(_counterclockwise_struct) && (not  _counterclockwise_struct.__inactive) && _counterclockwise_struct.held;
            var _backward_state         = is_struct(_backward_struct        ) && (not          _backward_struct.__inactive) && _backward_struct.held;
            var _clockwise_state        = is_struct(_clockwise_struct       ) && (not         _clockwise_struct.__inactive) && _clockwise_struct.held;
            
            if (_phase_verb == _forward_verb)
            {
                if (_forward_state)
                {
                    __set_direction(0);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _forward_verb, "\" used as forward verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_counterclockwise_state)
                {
                    __set_direction(90);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _counterclockwise_verb, "\" used as forward verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_backward_state)
                {
                    __set_direction(180);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _backward_verb, "\" used as forward verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_clockwise_state)
                {
                    __set_direction(270);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _clockwise_verb, "\" used as forward verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
            }
            else if (_phase_verb == _counterclockwise_verb)
            {
                if (_counterclockwise_state)
                {
                    __set_direction(0);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _counterclockwise_verb, "\" used as counter-clockwise verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_backward_state)
                {
                    __set_direction(90);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _backward_verb, "\" used as counter-clockwise verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_clockwise_state)
                {
                    __set_direction(180);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _clockwise_verb, "\" used as counter-clockwise verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_forward_state)
                {
                    __set_direction(270);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _forward_verb, "\" used as counter-clockwise verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
            }
            else if (_phase_verb == _backward_verb)
            {
                if (_backward_state)
                {
                    __set_direction(0);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _backward_verb, "\" used as backward verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_clockwise_state)
                {
                    __set_direction(90);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _clockwise_verb, "\" used as backward verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_forward_state)
                {
                    __set_direction(180);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _forward_verb, "\" used as backward verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_counterclockwise_state)
                {
                    __set_direction(270);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _counterclockwise_verb, "\" used as backward verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
            }
            else if (_phase_verb == _clockwise_verb)
            {
                if (_clockwise_state)
                {
                    __set_direction(0);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _clockwise_verb, "\" used as clockwise verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_forward_state)
                {
                    __set_direction(90);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _forward_verb, "\" used as clockwise verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_counterclockwise_state)
                {
                    __set_direction(180);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _counterclockwise_verb, "\" used as clockwise verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_backward_state)
                {
                    __set_direction(270);
                    if (INPUT_COMBO_DEBUG) __input_trace("Combo \"", __name, "\" direction determined from verb \"", _backward_verb, "\" used as clockwise verb \"", _phase_verb, "\", direction=", __direction, " (phase=", __phase, ")");
                }
            }
        }
    }
    
    static __set_direction = function(_direction)
    {
        var _forward_verb          = __combo_params.__forward_verb;
        var _counterclockwise_verb = __combo_params.__counterclockwise_verb;
        var _backward_verb         = __combo_params.__backward_verb;
        var _clockwise_verb        = __combo_params.__clockwise_verb;
        
        switch(_direction)
        {
            case 0:
                //No direction mapping needed
            break;
            
            case 90:
                if (_forward_verb          != undefined) __direction_mapping[$ _forward_verb         ] = _counterclockwise_verb;
                if (_counterclockwise_verb != undefined) __direction_mapping[$ _counterclockwise_verb] = _backward_verb;
                if (_backward_verb         != undefined) __direction_mapping[$ _backward_verb        ] = _clockwise_verb;
                if (_clockwise_verb        != undefined) __direction_mapping[$ _clockwise_verb       ] = _forward_verb;
            break;
           
            case 180:
                if (_forward_verb          != undefined) __direction_mapping[$ _forward_verb         ] = _backward_verb;
                if (_counterclockwise_verb != undefined) __direction_mapping[$ _counterclockwise_verb] = _clockwise_verb;
                if (_backward_verb         != undefined) __direction_mapping[$ _backward_verb        ] = _forward_verb;
                if (_clockwise_verb        != undefined) __direction_mapping[$ _clockwise_verb       ] = _counterclockwise_verb;
            break;
           
            case 270:
                if (_forward_verb          != undefined) __direction_mapping[$ _forward_verb         ] = _clockwise_verb;
                if (_counterclockwise_verb != undefined) __direction_mapping[$ _counterclockwise_verb] = _forward_verb;
                if (_backward_verb         != undefined) __direction_mapping[$ _backward_verb        ] = _counterclockwise_verb;
                if (_clockwise_verb        != undefined) __direction_mapping[$ _clockwise_verb       ] = _backward_verb;
            break;
            
            default:
                __input_error("Unhandled direction ", _direction);
            break;
        }
        
        __direction = (_direction + __combo_params.__reference_direction + 3600) mod 360;
    }
}