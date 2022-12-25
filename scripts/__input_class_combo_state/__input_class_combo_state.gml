function __input_class_combo_state(_name, _combo_definition_struct) constructor
{
    __name = _name;
    
    __definition_struct = _combo_definition_struct;
    __phase_array = __definition_struct.__phase_array;
    
    __success = false;
    
    __held_verbs_array    = [];
    __held_verbs_struct   = {};
    __pressed_verbs_array = [];
    __pressed_verbs_dict  = {};
    
    __phase = 0;
    __phase_start_time = infinity;
    __initialized = false;
    
    static __reset = function()
    {
        if (__phase != 0)
        {
            array_resize(__held_verbs_array, 0);
            __held_verbs_struct  = {};
            array_resize(__pressed_verbs_array, 0);
            __pressed_verbs_dict = {};
            
            __phase = 0;
            __initialize_phase();
        }
        
        __success = false;
        __phase_start_time = infinity;
    }
    
    static __tick = function(_player_verbs_struct)
    {
        var _phase_count = array_length(__phase_array);
        if (_phase_count <= 0) __input_error("Combo \"", __definition_struct.__name, "\" has no phases\nPlease add phases with either the .press() or .hold_start() method");
        
        if (!__initialized) __initialize_phase();
        
        if (__success)
        {
            //Report success until any of the verbs are released
            if (array_length(__held_verbs_array) <= 0)
            {
                __reset();
                return __INPUT_COMBO_STATE.__FAIL;
            }
            else
            {
                var _i = 0;
                repeat(array_length(__held_verbs_array))
                {
                    if (!_player_verbs_struct[$ __held_verbs_array[_i]].held)
                    {
                        __reset();
                        return __INPUT_COMBO_STATE.__FAIL;
                    }
                    
                    ++_i;
                }
            }
            
            return __INPUT_COMBO_STATE.__SUCCESS;
        }
        else
        {
            var _state = __evaluate_phase(_player_verbs_struct);
            switch(_state)
            {
                case __INPUT_COMBO_STATE.__FAIL:
                    __reset();
                    return __INPUT_COMBO_STATE.__FAIL;
                break;
                
                case __INPUT_COMBO_STATE.__SUCCESS:
                    ++__phase;
                    __phase_start_time = __input_get_time();
                    
                    if (__phase < _phase_count)
                    {
                        __initialize_phase();
                    }
                    else
                    {
                        //Success!
                        __success = true;
                        __phase = _phase_count;
                        
                        return __INPUT_COMBO_STATE.__SUCCESS;
                    }
                break;
            }
        }
        
        return __INPUT_COMBO_STATE.__WAITING;
    }
    
    static __initialize_phase = function()
    {
        __initialized = true;
        
        var _phase      = __phase_array[__phase];
        var _phase_type = _phase.__type;
        
        //For release-type phases, we want to remove verbs from the dictionary that we're using to track which verbs should be held
        if ((_phase_type == __INPUT_COMBO_PHASE_TYPE.__PRESS_OR_RELEASE) || (_phase_type == __INPUT_COMBO_PHASE_TYPE.__RELEASE))
        {
            var _phase_verb = _phase.__verb;
            
            var _i = 0;
            repeat(array_length(__held_verbs_array))
            {
                if (__held_verbs_array[_i] == _phase_verb)
                {
                    array_delete(__held_verbs_array, _i, 1);
                    variable_struct_remove(__held_verbs_struct, _phase_verb);
                }
                else
                {
                    ++_i;
                }
            }
        }
    }
    
    static __capture_all_presses = function(_player_verbs_struct)
    {
        var _basic_verb_array = global.__input_basic_verb_array;
        var _i = 0;
        repeat(array_length(_basic_verb_array))
        {
            var _verb_name = _basic_verb_array[_i];
            if ((_player_verbs_struct[$ _verb_name].press) 
            &&  !variable_struct_exists(__held_verbs_struct, _verb_name)
            &&  !variable_struct_exists(__pressed_verbs_dict, _verb_name))
            {
                array_push(__pressed_verbs_array, _verb_name);
                __pressed_verbs_dict[$ _verb_name] = true;
            }
            
            ++_i;
        }
    }
    
    static __capture_all_holds = function(_player_verbs_struct)
    {
        var _basic_verb_array = global.__input_basic_verb_array;
        var _i = 0;
        repeat(array_length(_basic_verb_array))
        {
            var _verb_name = _basic_verb_array[_i];
            if ((_player_verbs_struct[$ _verb_name].press) 
            &&  !variable_struct_exists(__held_verbs_struct, _verb_name)
            &&  !variable_struct_exists(__pressed_verbs_dict, _verb_name))
            {
                array_push(__held_verbs_array, _verb_name);
                __held_verbs_struct[$ _verb_name] = true;
            }
            
            ++_i;
        }
    }
    
    static __evaluate_phase = function(_player_verbs_struct)
    {
        var _phase         = __phase_array[__phase];
        var _phase_type    = _phase.__type;
        var _phase_verb    = _phase.__verb;
        var _phase_timeout = _phase.__timeout;
        
        if (__input_get_time() - __phase_start_time > _phase_timeout) return __INPUT_COMBO_STATE.__FAIL;
        
        //Check to see if any verbs have been released
        var _i = 0;
        repeat(array_length(__pressed_verbs_array))
        {
            var _verb_name = __pressed_verbs_array[_i];
            if (!_player_verbs_struct[$ _verb_name].held)
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
                if (_player_verbs_struct[$ _phase_verb].press)
                {
                    __capture_all_presses(_player_verbs_struct);
                    return __INPUT_COMBO_STATE.__SUCCESS;
                }
            break;
            
            case __INPUT_COMBO_PHASE_TYPE.__HOLD_START:
                if (_player_verbs_struct[$ _phase_verb].press)
                {
                    __capture_all_holds(_player_verbs_struct);
                    return __INPUT_COMBO_STATE.__SUCCESS;
                }
            break;
            
            case __INPUT_COMBO_PHASE_TYPE.__RELEASE:
                var _verb_struct = _player_verbs_struct[$ _phase_verb];
                if (_verb_struct.release || !_verb_struct.held)
                {
                    return __INPUT_COMBO_STATE.__SUCCESS;
                }
            break;
            
            case __INPUT_COMBO_PHASE_TYPE.__PRESS_OR_RELEASE:
                var _verb_struct = _player_verbs_struct[$ _phase_verb];
                if (_verb_struct.press)
                {
                    __capture_all_presses(_player_verbs_struct);
                    return __INPUT_COMBO_STATE.__SUCCESS;
                }
                else if (_verb_struct.release)
                {
                    return __INPUT_COMBO_STATE.__SUCCESS;
                }
            break;
            
            default:
                __input_error("Combo phase type \"", _phase_type, "\" not recognised");
            break;
        }
        
        //Check for any erroneous releases
        var _i = 0;
        repeat(array_length(__held_verbs_array))
        {
            if (!_player_verbs_struct[$ __held_verbs_array[_i]].held)
            {
                return __INPUT_COMBO_STATE.__FAIL;
            }
            
            ++_i;
        }
        
        //Check for any erroneous holds
        var _basic_verb_array = global.__input_basic_verb_array;
        var _i = 0;
        repeat(array_length(_basic_verb_array))
        {
            var _verb_name = _basic_verb_array[_i];
            if ((_player_verbs_struct[$ _verb_name].held) 
            &&  !variable_struct_exists(__held_verbs_struct, _verb_name)  //Not required to be held
            &&  !variable_struct_exists(__pressed_verbs_dict, _verb_name) //Not pressed in a previous phase
            &&  (_verb_name != _phase_verb))                              //Not the verb we're checking for
            {
                return __INPUT_COMBO_STATE.__FAIL;
            }
            
            ++_i;
        }
        
        return __INPUT_COMBO_STATE.__WAITING;
    }
}