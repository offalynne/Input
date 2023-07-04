function __input_class_verb_state() constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE  //Set static __global
    
    name = undefined;
    type = undefined;
    __player = undefined;
    
    __inactive       = false;
    __group_inactive = false;
    __consumed       = false;
    
    value          = 0.0;
    raw            = 0.0;
    analogue       = false;
    raw_analogue   = false;
    min_threshold  = 0;
    max_threshold  = 1;
    force_value    = undefined;
    force_analogue = undefined;
    
    previous_held = false;
    press         = false;
    held          = false;
    release       = false;
    press_time    = -1;
    held_time     = -1;
    release_time  = -1;
    
    //Used for virtual buttons
    __virtual_value     = undefined;
    __virtual_raw_value = undefined;
    __virtual_analogue  = undefined;
    
    
    
    static __clear = function()
    {
        value = 0.0;
        raw   = 0.0;
        
        press   = false;
        held    = false;
        release = false;
    }
    
    static tick = function(_player, _player_active, _alternate_array)
    {
        __clear();
        
        var _time = __input_get_time();
        
        if (not _player_active)
        {
            var _i = 0;
            repeat(array_length(_alternate_array))
            {
                _alternate_array[_i].__Read(_player, self);
                ++_i;
            }
        }
        
        if (value > 0)
        {
            __player.__last_input_time = __global.__current_time;
            
            held      = true;
            held_time = _time;
        }
        
        if (previous_held != held)
        {
            if (held)
            {
                if (__INPUT_DEBUG && __consumed) __input_trace("Un-consuming verb \"", name, "\"");
                __consumed = false;
                
                press      = true;
                press_time = _time;
            }
            else
            {
                release      = true;
                release_time = _time;
            }
        }
        
        previous_held = held;
        
        __inactive = (__group_inactive || __consumed || !_player_active);
    }
}