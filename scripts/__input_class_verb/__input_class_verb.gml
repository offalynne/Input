/// @param type
/// @param value
/// @param axisNegative

function __input_class_verb() constructor
{
    consumed     = false;
    value        = 0.0;
    raw          = 0.0;
    analogue     = false;
    raw_analogue = false;
    
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
    
    static clear = function()
    {
        value = 0.0;
        raw   = 0.0;
        
        previous_held = held;
        press         = false;
        held          = false;
        release       = false;
        
        double_press   = false;
        double_release = false;
    }
    
    static tick = function()
    {
        var _time = INPUT_BUFFERED_REALTIME? current_time : global.__input_frame;
        
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
        
        if (double_held) double_held_time = _time;
    }
}