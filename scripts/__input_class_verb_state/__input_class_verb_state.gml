function __input_class_verb_state() constructor
{
    name = undefined;
    type = undefined;
    __player = undefined;
    
    __inactive       = false;
    __group_inactive = false;
    __consumed       = false;
    
    previous_value = 0.0;
    previous_raw_analogue = false;
    
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
    
    __quick_press      = false;
    __quick_press_time = -1;
    
    //Used for "toggle momentary" accessibility feature 
    __toggle_prev_value = 0.0;
    __toggle_value      = 0.0;
    __toggle_state      = false;
    
    //Used for quick tap checkers
    __raw_history_array = array_create(INPUT_QUICK_BUFFER+1, 0);
    
    //Used for virtual buttons
    __virtual_value     = undefined;
    __virtual_raw_value = undefined;
    __virtual_analogue  = undefined;
    
    
    
    static __clear = function()
    {
        previous_value = value;
        previous_raw_analogue = raw_analogue;
        
        value = 0.0;
        raw   = 0.0;
        
        press   = false;
        held    = false;
        release = false;
        
        double_press   = false;
        double_release = false;
        
        long_press   = false;
        long_release = false;
        
        __quick_press = false;
        
        //Used for "toggle momentary" accessibility feature 
        __toggle_prev_value = __toggle_value;
        __toggle_value = 0.0;
    }
    
    static tick = function(_verb_group_state_dict)
    {
        var _time = __input_get_time();
        var _reset_history_array = false;
        
        __toggle_value = value;
        
        if (global.__input_toggle_momentary_state && (type == __INPUT_VERB_TYPE.__BASIC) && variable_struct_exists(global.__input_toggle_momentary_dict, name))
        {
            //Catch the leading edge to toggle the verb
            if ((__toggle_prev_value < 0.1) && (__toggle_value > 0.1)) __toggle_state = !__toggle_state;
            
            //Overwrite the values we expose to the player with the toggle state
            value = __toggle_state;
            raw   = __toggle_state;
        }
        
        if (global.__input_cooldown_state && (type == __INPUT_VERB_TYPE.__BASIC) && variable_struct_exists(global.__input_cooldown_dict, name))
        {
            if (_time < release_time + (INPUT_TIMER_MILLISECONDS? __INPUT_RATE_LIMIT_DURATION : ((__INPUT_RATE_LIMIT_DURATION/1000)*game_get_speed(gamespeed_fps))))
            {
                value = 0;
                raw   = 0;
            }
        }
        
        if (value > 0)
        {
            __player.__last_input_time = global.__input_current_time;
            
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
        
        var _inactive = (__group_inactive || __consumed);
        if (_inactive && !__inactive)
        {
            //Newly inactive, better reset the raw history array
            _reset_history_array = true;
        }
        else
        {
            //Not inactive, update our raw history array if we're using analogue input
            if (raw_analogue)
            {
                array_insert(__raw_history_array, 0, raw);
                array_pop(__raw_history_array);
                
                //Check for the quick tap only on the frame that we cross the max threshold
                if ((previous_value < max_threshold) && (value >= max_threshold))
                {
                    var _i = 1;
                    repeat(INPUT_QUICK_BUFFER)
                    {
                        //We've performed a quick tap if we've gone from the min to max threshold in INPUT_QUICK_BUFFER frames (or less)
                        if (__raw_history_array[_i] <= min_threshold)
                        {
                            __quick_press      = true;
                            __quick_press_time = _time;
                            break;
                        }
                        
                        ++_i;
                    }
                }
            }
            else if (raw_analogue != previous_raw_analogue)
            {
                //Newly non-analogue, better reset the raw history array
                _reset_history_array = true;
            }
        }
        
        __inactive = _inactive;
        
        if (_reset_history_array)
        {
            __raw_history_array = array_create(INPUT_QUICK_BUFFER+1, 0);
        }
    }
}