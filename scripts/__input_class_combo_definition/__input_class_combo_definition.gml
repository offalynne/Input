// Feather disable all

function __input_class_combo_definition(_name, _phase_timeout, _directional) constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE
    
    __name          = _name;
    __phase_timeout = _phase_timeout;
    __directional   = _directional;
    
    __ignore_dict = {};
    __used_dict   = {};
    __phase_array = [];
    
    static ignore = function(_verb_array)
    {
        if (_verb_array == all)
        {
            _verb_array = __global.__basic_verb_array;
        }
        
        var _i = 0;
        repeat(array_length(_verb_array))
        {
            var _verb = _verb_array[_i];
            
            if (not variable_struct_exists(__used_dict, _verb))
            {
                __ignore_dict[$ _verb] = true;
            }
            
            ++_i;
        }
        
        return self;
    }
    
    static __remove_ignored = function(_verb)
    {
        variable_struct_remove(__ignore_dict, _verb);
        __used_dict[$ _verb] = true;
    }
    
    static press = function(_verb)
    {
        __remove_ignored(_verb);
        
        array_push(__phase_array, {
            __type: __INPUT_COMBO_PHASE.__PRESS,
            __verb: _verb,
        });
        
        return self;
    }
    
    static release = function(_verb)
    {
        __remove_ignored(_verb);
        
        array_push(__phase_array, {
            __type: __INPUT_COMBO_PHASE.__RELEASE,
            __verb: _verb,
        });
        
        return self;
    }
    
    static press_or_release = function(_verb)
    {
        __remove_ignored(_verb);
        
        array_push(__phase_array, {
            __type: __INPUT_COMBO_PHASE.__PRESS_OR_RELEASE,
            __verb: _verb,
        });
        
        return self;
    }
    
    static hold = function(_verb)
    {
        __remove_ignored(_verb);
        
        array_push(__phase_array, {
            __type: __INPUT_COMBO_PHASE.__HOLD,
            __verb: _verb,
        });
        
        return self;
    }
    
    static charge = function(_verb, _min_time = INPUT_COMBO_DEFAULT_MIN_CHARGE_TIME)
    {
        __remove_ignored(_verb);
        
        array_push(__phase_array, {
            __type:     __INPUT_COMBO_PHASE.__CHARGE,
            __verb:     _verb,
            __min_time: _min_time,
        });
        
        return self;
    }
}