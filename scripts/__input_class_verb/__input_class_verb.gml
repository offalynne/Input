/// @param type
/// @param value
/// @param axisNegative

function __input_class_verb() constructor
{
    name = undefined;
    
    consumed = false;
    
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
    
    static clear = function()
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
    
    static tick = function()
    {
        var _time = __input_get_time();
        
        if (value > 0)
        {
            other.last_input_time = current_time;
            
            held      = true;
            held_time = _time;
        }
        
        if (previous_held != held)
        {
            if (held)
            {
                if (__INPUT_DEBUG && consumed) __input_trace("Un-consuming verb \"", name, "\"");
                consumed = false;
                
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
    }
}