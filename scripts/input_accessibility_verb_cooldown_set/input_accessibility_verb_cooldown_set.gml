/// @desc    Sets whether cooldown behaviour is enabled for a verb
/// @param   verb
/// @param   state

function input_accessibility_verb_cooldown_set(_verb_name, _state)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (is_array(_verb_name))
    {
        var _i = 0;
        repeat(array_length(_verb_name))
        {
            input_accessibility_verb_cooldown_set(_verb_name[_i], _state);
            ++_i;
        }
        
        return;
    }
    
    __INPUT_VERIFY_BASIC_VERB_NAME
    
    if (_state)
    {
        _global.__cooldown_dict[$ _verb_name] = true;
    }
    else
    {
        variable_struct_remove(_global.__cooldown_dict, _verb_name);
    }
}