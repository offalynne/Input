function __input_class_combo_tracker(_name, _combo_definition_struct) constructor
{
    __name = _name;
    
    __definition_struct = _combo_definition_struct;
    __phase_array = __definition_struct.__phase_array;
    
    if (array_length(__phase_array) <= 0)
    {
        __input_error("Combo \"", __definition_struct.__name, "\" has no phases\nPlease add phases with either the .press() or .hold_start() method");
    }
    
    __phase = 0;
    __held_verbs_array = [];
    __retrigger_verbs_dict = {};
    
    static __reset = function()
    {
        __phase = 0;
        array_resize(__held_verbs_array, 0);
    }
    
    static __tick = function(_player_verbs_struct)
    {
        var _state = __evaluate_phase(_player_verbs_struct, __phase);
        
        switch(_state)
        {
            case __INPUT_COMBO_STATE.__FAIL:
                __reset();
            break;
            
            case __INPUT_COMBO_STATE.__SUCCESS:
                ++__phase;
                if (__phase >= array_length(__phase_array)) __reset();
            break;
        }
        
        return _state;
    }
    
    static __evaluate_phase = function(_player_verbs_struct, _index)
    {
        var _phase              = __phase_array[__phase];
        var _phase_type         = _phase.__type;
        var _phase_verbs_array  = _phase.__verb_array;
        var _phase_verbs_struct = _phase.__verb_struct;
        
        switch(_phase_type)
        {
            case __INPUT_COMBO_PHASE_TYPE.__PRESS:
            case __INPUT_COMBO_PHASE_TYPE.__HOLD_START:
                
                //FIXME - .held and .press won't work here!
                
                //Check that all the verbs we expect to be held from previous phases are indeed being held
                var _i = 0;
                repeat(array_length(__held_verbs_array))
                {
                    if (!_player_verbs_struct[$ _phase_verbs_array[_i]].held) return __INPUT_COMBO_STATE.__FAIL;
                    ++_i;
                }
                
                //Check that no incorrect verbs have been pressed
                var _i = 0;
                repeat(array_length(global.__input_verb_array))
                {
                    var _verb_name = global.__input_verb_array[_i];
                    if (_player_verbs_struct[$ _verb_name].press && !variable_struct_exists(_phase_verbs_struct, _verb_name)) return __INPUT_COMBO_STATE.__FAIL;
                    ++_i;
                }
                
                //Check that all the verbs we expect to be held are indeed being held
                var _i = 0;
                repeat(array_length(_phase_verbs_array))
                {
                    var _verb_name = _phase_verbs_array[_i];
            
                    if (variable_struct_exists(__retrigger_verbs_dict, _verb_name))
                    {
                        if (!_player_verbs_struct[$ _verb_name].held)
                        {
                            return __INPUT_COMBO_STATE.__WAITING;
                        }
                        else
                        {
                            variable_struct_remove(__retrigger_verbs_dict, _verb_name);
                        }
                    }
                    else
                    {
                        if (!_player_verbs_struct[$ _verb_name].held) return __INPUT_COMBO_STATE.__WAITING;
                    }
                    
                    ++_i;
                }
                
                //For every verb that we pressed add it to our retrigger dictionary
                //Additionally, if we're starting a hold, then add the held verbs to our array
                var _i = 0;
                repeat(array_length(_phase_verbs_array))
                {
                    var _verb_name = _phase_verbs_array[_i];
                    __retrigger_verbs_dict[$ _verb_name] = true;
                    
                    if (_phase_type == __INPUT_COMBO_PHASE_TYPE.__HOLD_START) array_push(__held_verbs_array, _verb_name);
                    
                    ++_i;
                }
                
                return __INPUT_COMBO_STATE.__SUCCESS;
            break;
            
            case __INPUT_COMBO_PHASE_TYPE.__RELEASE:
                var _i = 0;
                repeat(array_length(__held_verbs_array))
                {
                    //Remove any matching held verbs from our tracking array
                    if (variable_struct_exists(_phase_verbs_struct, __held_verbs_array[_i]))
                    {
                        array_delete(__held_verbs_array, _i, 1);
                    }
                    else
                    {
                        //Otherwise perform the stardard held verb check
                        if (!_player_verbs_struct[$ _phase_verbs_array[_i]].held) return __INPUT_COMBO_STATE.__FAIL;
                        ++_i;
                    }
                }
                
                //Now check to see if all the verbs we want the player to release are no longer held
                var _i = 0;
                repeat(array_length(_phase_verbs_array))
                {
                    var _verb_name = _phase_verbs_array[_i];
                    if (_player_verbs_struct[$ _verb_name].held) return __INPUT_COMBO_STATE.__WAITING;
                    
                    //Also remove this verbs from our retrigger dictionary too for good measure
                    variable_struct_remove(__retrigger_verbs_dict, _verb_name);
                    
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