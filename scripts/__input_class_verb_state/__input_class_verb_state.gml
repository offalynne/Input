// Feather disable all
function __input_class_verb_state() constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE  //Set static __global
    
    __name = undefined;
    __type = undefined;
    __player = undefined;
    
    __inactive       = false;
    __group_inactive = false;
    __consumed       = false;
    
    __previous_value = 0.0;
    __previous_raw_analogue = false;
    
    __value          = 0.0;
    __raw            = 0.0;
    __max_value    = 0.0;
    
    __analogue       = false;
    __raw_analogue   = false;
    __min_threshold  = 0;
    __max_threshold  = 1;
    __force_value    = undefined;
    __force_analogue = undefined;
    
    __previous_held = false;
    __press         = false;
    __held          = false;
    __release       = false;
    __press_time    = -1;
    __held_time     = -1;
    __release_time  = -1;
    
    __double_press        = false;
    __double_held         = false;
    __double_release      = false;
    __double_press_time   = -1;
    __double_held_time    = -1;
    __double_release_time = -1;
    
    __long_press        = false;
    __long_held         = false;
    __long_release      = false;
    __long_press_time   = -1;
    __long_held_time    = -1;
    __long_release_time = -1;
    
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
        __previous_value = __value;
        __previous_raw_analogue = __raw_analogue;
        
        __value = 0.0;
        __raw   = 0.0;
        
        __press   = false;
        __held    = false;
        __release = false;
        
        __double_press   = false;
        __double_release = false;
        
        __long_press   = false;
        __long_release = false;
        
        __quick_press = false;
        
        //Used for "toggle momentary" accessibility feature 
        __toggle_prev_value = __toggle_value;
        __toggle_value = 0.0;
    }
    
    static __tick = function(_verb_group_state_dict, _player_active)
    {
        var _time = __input_get_time();
        var _reset_history_array = false;
        
        __toggle_value = __value;
        
        if (__global.__toggle_momentary_state && (__type == __INPUT_VERB_TYPE.__BASIC) && variable_struct_exists(__global.__toggle_momentary_dict, __name))
        {
            //Catch the leading edge to toggle the verb
            if ((__toggle_prev_value < 0.1) && (__toggle_value > 0.1)) __toggle_state = !__toggle_state;
            
            //Overwrite the values we expose to the player with the toggle state
            __value = __toggle_state;
            __raw   = __toggle_state;
        }
        
        if (__global.__cooldown_state && (__type == __INPUT_VERB_TYPE.__BASIC) && variable_struct_exists(__global.__cooldown_dict, __name))
        {
            if (_time < __release_time + (INPUT_TIMER_MILLISECONDS? __INPUT_RATE_LIMIT_DURATION : ((__INPUT_RATE_LIMIT_DURATION/1000)*game_get_speed(gamespeed_fps))))
            {
                __value = 0;
                __raw   = 0;
            }
        }
        
        if (__value > 0)
        {
            if (__previous_value < __value)
            {
                __player.__last_input_time = __global.__current_time;
            }
            
            __held      = true;
            __held_time = _time;
            
            //Update the max value
            __max_value = max(__max_value, __value);
        }
        
        if (__previous_held != __held)
        {
            if (__held)
            {
                if (__INPUT_DEBUG && __consumed) __input_trace("Un-consuming verb \"", __name, "\"");
                __consumed = false;
                
                if (_time - __press_time < INPUT_DOUBLE_DELAY)
                {
                    __double_press      = true;
                    __double_press_time = _time;
                    
                    __double_held      = true;
                    __double_held_time = _time;
                }
                
                __press      = true;
                __press_time = _time;
            }
            else
            {
                __release      = true;
                __release_time = _time;
                
                //Reset the max value
                __max_value = 0;
                
                if (__double_held)
                {
                    __double_held = false;
                    
                    __double_release      = true;
                    __double_release_time = _time;
                }
            }
        }
        
        if (__held)
        {
            if (_time - __press_time > INPUT_LONG_DELAY)
            {
                if (!__long_held)
                {
                    __long_press      = true;
                    __long_press_time = _time;
                }
                
                __long_held      = true;
                __long_held_time = _time;
            }
        }
        else
        {
            if (__long_held)
            {
                __long_release      = true;
                __long_release_time = _time;
            }
            
            __long_held = false;
        }
        
        __previous_held = __held;
        
        if (__double_held) __double_held_time = _time;
        if (__long_held) __long_held_time = _time;
        
        var _inactive = (__group_inactive || __consumed || !_player_active);
        if (_inactive && !__inactive)
        {
            //Newly inactive, better reset the raw history array
            _reset_history_array = true;
        }
        else
        {
            //Not inactive, update our raw history array if we're using analogue input
            if (__raw_analogue)
            {
                array_insert(__raw_history_array, 0, __raw);
                array_pop(__raw_history_array);
                
                //Check for the quick tap only on the frame that we cross the max threshold
                if ((__previous_value < __max_threshold) && (__value >= __max_threshold))
                {
                    var _i = 1;
                    repeat(INPUT_QUICK_BUFFER)
                    {
                        //We've performed a quick tap if we've gone from the min to max threshold in INPUT_QUICK_BUFFER frames (or less)
                        if (__raw_history_array[_i] <= __min_threshold)
                        {
                            __quick_press      = true;
                            __quick_press_time = _time;
                            break;
                        }
                        
                        ++_i;
                    }
                }
            }
            else if (__raw_analogue != __previous_raw_analogue)
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
