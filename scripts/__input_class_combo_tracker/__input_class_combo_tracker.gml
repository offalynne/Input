function __input_class_combo_tracker(_name, _combo_definition_struct) constructor
{
    __name = _name;
    
    __definition_struct = _combo_definition_struct;
    __phase_array = __definition_struct.__phase_array;
    
    __phase = 0;
    __phase_start_time = infinity;
    
    __held_verbs_array    = [];
    __held_verbs_struct   = {};
    __pressed_verbs_array = [];
    __pressed_verbs_dict  = {};
    
    static __reset = function()
    {
        if (__phase != 0)
        {
            __phase = 0;
            
            array_resize(__held_verbs_array, 0);
            __held_verbs_struct = {};
            
            array_resize(__pressed_verbs_array, 0);
            __pressed_verbs_dict = {};
        }
        
        __phase_start_time = infinity;
    }
    
    static __tick = function(_player_verbs_struct)
    {
        var _phase_count = array_length(__phase_array);
        if (_phase_count <= 0) __input_error("Combo \"", __definition_struct.__name, "\" has no phases\nPlease add phases with either the .press() or .hold_start() method");
        
        if (__phase >= _phase_count)
        {
            var _i = 0;
            repeat(array_length(__held_verbs_array))
            {
                if (_player_verbs_struct[$ __held_verbs_array[_i]].value <= 0)
                {
                    __reset();
                    return __INPUT_COMBO_STATE.__FAIL;
                }
                
                ++_i;
            }
            
            return __INPUT_COMBO_STATE.__SUCCESS;
        }
        else
        {
            var _state = __evaluate_phase(_player_verbs_struct, __phase);
            switch(_state)
            {
                case __INPUT_COMBO_STATE.__FAIL:
                    __reset();
                    return __INPUT_COMBO_STATE.__FAIL;
                break;
                
                case __INPUT_COMBO_STATE.__SUCCESS:
                    ++__phase;
                    __phase_start_time = __input_get_time();
                    
                    if (__phase >= _phase_count)
                    {
                        //Success! Convert all pressed verbs to held verbs
                        
                        var _i = 0;
                        repeat(array_length(__pressed_verbs_array))
                        {
                            var _verb_name = __pressed_verbs_array[_i];
                            array_push(__held_verbs_array, _verb_name);
                            __held_verbs_struct[$ _verb_name] = true;
                            ++_i;
                        }
                        
                        //If we have no verbs to keep tracking then reset the tracker
                        if (array_length(__held_verbs_array) <= 0)
                        {
                            __reset();
                        }
                        else
                        {
                            //Clear out the pressed verbs (not technically needed but this is safer)
                            array_resize(__pressed_verbs_array, 0);
                            __pressed_verbs_dict = {};
                        }
                        
                        return __INPUT_COMBO_STATE.__SUCCESS;
                    }
                break;
            }
        }
        
        return __INPUT_COMBO_STATE.__WAITING;
    }
    
    static __evaluate_phase = function(_player_verbs_struct, _index)
    {
        if (__input_get_time() - __phase_start_time > __definition_struct.__phase_timeout) return __INPUT_COMBO_STATE.__FAIL;
        
        var _phase              = __phase_array[__phase];
        var _phase_type         = _phase.__type;
        var _phase_verbs_array  = _phase.__verb_array;
        var _phase_verbs_struct = _phase.__verb_struct;
                
        var _i = 0;
        repeat(array_length(__pressed_verbs_array))
        {
            var _verb_name = __pressed_verbs_array[_i];
            
            if (_player_verbs_struct[$ _verb_name].value <= 0)
            {
                array_delete(__pressed_verbs_array, _i, 1);
                variable_struct_remove(__pressed_verbs_dict, _verb_name);
            }
            else
            {
                ++_i;
            }
        }
        
        switch(_phase_type)
        {
            case __INPUT_COMBO_PHASE_TYPE.__PRESS:
            case __INPUT_COMBO_PHASE_TYPE.__HOLD_START:
                //Check that all the verbs we expect to be held from previous phases are indeed being held
                var _i = 0;
                repeat(array_length(__held_verbs_array))
                {
                    if (_player_verbs_struct[$ __held_verbs_array[_i]].value <= 0) return __INPUT_COMBO_STATE.__FAIL;
                    ++_i;
                }
                
                //Check that no incorrect verbs are being pressed
                var _i = 0;
                repeat(array_length(global.__input_verb_array))
                {
                    var _verb_name = global.__input_verb_array[_i];
                    
                    if ((_player_verbs_struct[$ _verb_name].value > 0)
                    &&  !variable_struct_exists(__held_verbs_struct, _verb_name)
                    &&  !variable_struct_exists(__pressed_verbs_dict, _verb_name)
                    &&  !variable_struct_exists(_phase_verbs_struct, _verb_name))
                    {
                        return __INPUT_COMBO_STATE.__FAIL;
                    }
                    
                    ++_i;
                }
                
                var _i = 0;
                repeat(array_length(_phase_verbs_array))
                {
                    var _verb_name = _phase_verbs_array[_i];
                    if ((_player_verbs_struct[$ _verb_name].value <= 0) || variable_struct_exists(__pressed_verbs_dict, _verb_name))
                    {
                        return __INPUT_COMBO_STATE.__WAITING;
                    }
                    
                    ++_i;
                }
                
                //For every verb that we pressed add it to our retrigger dictionary
                //Additionally, if we're starting a hold, then add the held verbs to our array
                var _i = 0;
                repeat(array_length(_phase_verbs_array))
                {
                    var _verb_name = _phase_verbs_array[_i];
                    
                    array_push(__pressed_verbs_array, _verb_name);
                    __pressed_verbs_dict[$ _verb_name] = true;
                    
                    if (_phase_type == __INPUT_COMBO_PHASE_TYPE.__HOLD_START)
                    {
                        array_push(__held_verbs_array, _verb_name);
                        __held_verbs_struct[$ _verb_name] = true;
                    }
                    
                    ++_i;
                }
                
                return __INPUT_COMBO_STATE.__SUCCESS;
            break;
            
            case __INPUT_COMBO_PHASE_TYPE.__RELEASE:
                var _i = 0;
                repeat(array_length(__held_verbs_array))
                {
                    //Remove any matching held verbs from our tracking array
                    var _verb_name = __held_verbs_array[_i];
                    if (variable_struct_exists(_phase_verbs_struct, _verb_name))
                    {
                        array_delete(__held_verbs_array, _i, 1);
                        variable_struct_remove(__held_verbs_struct, _verb_name);
                    }
                    else
                    {
                        //Otherwise perform the stardard held verb check
                        if (_player_verbs_struct[$ _verb_name].value <= 0) return __INPUT_COMBO_STATE.__FAIL;
                        ++_i;
                    }
                }
                
                //Check that no incorrect verbs are being pressed
                var _i = 0;
                repeat(array_length(global.__input_verb_array))
                {
                    var _verb_name = global.__input_verb_array[_i];
                    
                    if ((_player_verbs_struct[$ _verb_name].value > 0)
                    &&  !variable_struct_exists(__held_verbs_struct, _verb_name)
                    &&  !variable_struct_exists(__pressed_verbs_dict, _verb_name))
                    {
                        return __INPUT_COMBO_STATE.__FAIL;
                    }
                    
                    ++_i;
                }
                
                //Now check to see if all the verbs we want the player to release are no longer held
                var _i = 0;
                repeat(array_length(_phase_verbs_array))
                {
                    var _verb_name = _phase_verbs_array[_i];
                    if (_player_verbs_struct[$ _verb_name].value > 0) return __INPUT_COMBO_STATE.__WAITING;
                    
                    //Also remove this verbs from our retrigger dictionary too for good measure
                    variable_struct_remove(__pressed_verbs_dict, _verb_name);
                    
                    ++_i;
                }
                
                return __INPUT_COMBO_STATE.__SUCCESS;
            break;
            
            default:
                __input_error("Combo phase type \"", _phase_type, "\" not recognised");
            break;
        }
    }
}