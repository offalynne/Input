function __input_class_verb() constructor
{
    name = undefined;
    type = undefined;
    
    __inactive       = false;
    __group_inactive = false;
    __consumed       = false;
    
    previous_value = 0.0;
    value          = 0.0;
    raw            = 0.0;
    analogue       = false;
    raw_analogue   = false;
    min_threshold  = undefined;
    max_threshold  = undefined;
    force_value    = undefined;
    force_analogue = undefined;
    
    previous_held = false;
    press         = false;
    held          = false;
    release       = false;
    press_time    = -1;
    held_time     = -1;
    release_time  = -1;
    
    double_press        = false;
    double_held         = false;
    double_release      = false;
    double_press_time   = -1;
    double_held_time    = -1;
    double_release_time = -1;
    
    long_press        = false;
    long_held         = false;
    long_release      = false;
    long_press_time   = -1;
    long_held_time    = -1;
    long_release_time = -1;
    
    static __clear = function()
    {
        previous_value = value;
        value = 0.0;
        raw   = 0.0;
        
        press   = false;
        held    = false;
        release = false;
        
        double_press   = false;
        double_release = false;
        
        long_press   = false;
        long_release = false;
    }
    
    static __update_verb_groups = function(_verb_group_state_dict)
    {
        //Get the groups for this verb
        var _verb_group_array = global.__input_verb_to_groups_dict[$ name];
        
        //If none exist then this verb cannot be made inactive via groups
        if (_verb_group_array == undefined)
        {
            __group_inactive = false;
            return;
        }
        
        //Otherwise iterate over all the groups and check their state
        //If any group is active then the verb is active
        var _i = 0;
        repeat(array_length(_verb_group_array))
        {
            if (_verb_group_state_dict[$ _verb_group_array[_i]])
            {
                __group_inactive = false;
                return;
            }
            
            ++_i;
        }
        
        __group_inactive = true;
        previous_held    = true; //Force the held state on to avoid unwanted early reset of an inactive verb
        __inactive       = true;
    }
    
    static tick = function(_verb_group_state_dict)
    {
        var _time = __input_get_time();
        
        if (value > 0)
        {
            other.__last_input_time = current_time;
            
            held      = true;
            held_time = _time;
        }
        
        if (previous_held != held)
        {
            if (held)
            {
                if (__INPUT_DEBUG && __consumed) __input_trace("Un-consuming verb \"", name, "\"");
                __consumed = false;
                
                if (_time - press_time < INPUT_DOUBLE_DELAY)
                {
                    double_press      = true;
                    double_press_time = _time;
                    
                    double_held      = true;
                    double_held_time = _time;
                }
                
                press      = true;
                press_time = _time;
            }
            else
            {
                release      = true;
                release_time = _time;
                
                if (double_held)
                {
                    double_held = false;
                    
                    double_release      = true;
                    double_release_time = _time;
                }
            }
        }
        
        if (held)
        {
            if (_time - press_time > INPUT_LONG_DELAY)
            {
                if (!long_held)
                {
                    long_press      = true;
                    long_press_time = _time;
                }
                
                long_held      = true;
                long_held_time = _time;
            }
        }
        else
        {
            if (long_held)
            {
                long_release      = true;
                long_release_time = _time;
            }
            
            long_held = false;
        }
        
        previous_held = held;
        
        if (double_held) double_held_time = _time;
        if (long_held) long_held_time = _time;
        
        __update_verb_groups(_verb_group_state_dict);
        __inactive = (__group_inactive || __consumed);
    }
}