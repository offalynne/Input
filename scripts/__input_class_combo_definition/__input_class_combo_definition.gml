function __input_class_combo_definition(_name, _default_timeout) constructor
{
    __name            = _name;
    __default_timeout = _default_timeout;
    
    __phase_array = [];
    
    static __ensure_verb_is_basic_or_chord = function(_name)
    {
        if (variable_struct_exists(global.__input_combo_verb_dict, _name))
        {
            __input_error("Combos only accept basic verbs and chords when defining phases. Combo \"", _name, "\" cannot be used");
        }
        
        if (!variable_struct_exists(global.__input_basic_verb_dict, _name) && !variable_struct_exists(global.__input_chord_verb_dict, _name))
        {
            __input_error("Verb \"", _name, "\" not found either as a basic verb or a chord. Please define verbs and chords before combos");
        }
    }
    
    static timeout = function(_time)
    {
        if (array_length(__phase_array))
        {
            __input_error("Cannot change the timeout for previous phase, no phases have been added");
            return;
        }
        
        __phase_array[array_length(__phase_array)-1].__timeout = _time;
    }
    
    static press = function(_verb)
    {
        __ensure_verb_is_basic_or_chord(_verb);
        
        array_push(__phase_array, {
            __type:  __INPUT_COMBO_PHASE_TYPE.__PRESS,
            __timeout: __default_timeout,
            __verb: _verb,
        });
        
        return self;
    }
    
    static release = function(_verb)
    {
        __ensure_verb_is_basic_or_chord(_verb);
        
        array_push(__phase_array, {
            __type:  __INPUT_COMBO_PHASE_TYPE.__RELEASE,
            __timeout: __default_timeout,
            __verb: _verb,
        });
        
        return self;
    }
    
    static press_or_release = function(_verb)
    {
        __ensure_verb_is_basic_or_chord(_verb);
        
        array_push(__phase_array, {
            __type:  __INPUT_COMBO_PHASE_TYPE.__PRESS_OR_RELEASE,
            __timeout: __default_timeout,
            __verb: _verb,
        });
        
        return self;
    }
    
    static hold = function(_verb)
    {
        __ensure_verb_is_basic_or_chord(_verb);
        
        array_push(__phase_array, {
            __type:  __INPUT_COMBO_PHASE_TYPE.__HOLD_START,
            __timeout: __default_timeout,
            __verb: _verb,
        });
        
        return self;
    }
}
