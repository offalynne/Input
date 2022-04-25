function __input_class_combo_definition(_name, _phase_timeout) constructor
{
    __name          = _name;
    __phase_timeout = _phase_timeout;
    
    __phase_array = [];
    
    static __ensure_verb_is_basic_or_chord = function(_name)
    {
        if (variable_struct_exists(global.__input_combo_dict, _name))
        {
            __input_error("Combos only accept basic verbs and chords when defining phases. Combo \"", _name, "\" cannot be used");
        }
        
        if (!variable_struct_exists(global.__input_verb_dict, _name) && !variable_struct_exists(global.__input_chord_dict, _name))
        {
            __input_error("Verb \"", _name, "\" not found either as a basic verb or a chord. Please define verbs and chords before combos");
        }
    }
    
    static press = function()
    {
        var _verb_array = array_create(argument_count);
        var _verb_struct = {};
        
        var _i = 0;
        repeat(array_length(_verb_array))
        {
            var _verb_name = argument[_i];
            __ensure_verb_is_basic_or_chord(_verb_name);
            
            _verb_array[@ _i] = _verb_name;
            _verb_struct[$ _verb_name] = _i;
            
            ++_i;
        }
        
        array_push(__phase_array, {
            __type:  __INPUT_COMBO_PHASE_TYPE.__PRESS,
            __verb_array: _verb_array,
            __verb_struct: _verb_struct,
        });
        
        return self;
    }
    
    static release = function()
    {
        var _verb_array = array_create(argument_count);
        var _verb_struct = {};
        
        var _i = 0;
        repeat(array_length(_verb_array))
        {
            var _verb_name = argument[_i];
            __ensure_verb_is_basic_or_chord(_verb_name);
            
            _verb_array[@ _i] = _verb_name;
            _verb_struct[$ _verb_name] = _i;
            
            ++_i;
        }
        
        array_push(__phase_array, {
            __type:  __INPUT_COMBO_PHASE_TYPE.__RELEASE,
            __verb_array: _verb_array,
            __verb_struct: _verb_struct,
        });
        
        return self;
    }
    
    static press_or_release = function()
    {
        var _verb_array = array_create(argument_count);
        var _verb_struct = {};
        
        var _i = 0;
        repeat(array_length(_verb_array))
        {
            var _verb_name = argument[_i];
            __ensure_verb_is_basic_or_chord(_verb_name);
            
            _verb_array[@ _i] = _verb_name;
            _verb_struct[$ _verb_name] = _i;
            
            ++_i;
        }
        
        array_push(__phase_array, {
            __type:  __INPUT_COMBO_PHASE_TYPE.__PRESS_OR_RELEASE,
            __verb_array: _verb_array,
            __verb_struct: _verb_struct,
        });
        
        return self;
    }
    
    static hold = function()
    {
        var _verb_array = array_create(argument_count);
        var _verb_struct = {};
        
        var _i = 0;
        repeat(array_length(_verb_array))
        {
            var _verb_name = argument[_i];
            __ensure_verb_is_basic_or_chord(_verb_name);
            
            _verb_array[@ _i] = _verb_name;
            _verb_struct[$ _verb_name] = _i;
            
            ++_i;
        }
        
        array_push(__phase_array, {
            __type:  __INPUT_COMBO_PHASE_TYPE.__HOLD_START,
            __verb_array: _verb_array,
            __verb_struct: _verb_struct,
        });
        
        return self;
    }
}
