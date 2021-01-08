/// @param type
/// @param value
/// @param axisNegative

function __input_class_verb() constructor
{
    consumed = false;
    
    previous_held = false;
    
    press   = false;
    held    = false;
    release = false;
    value   = 0.0;
    raw     = 0.0;
    
    press_time   = -1;
    held_time    = -1;
    release_time = -1;
    
    analogue = false;
    raw_analogue = false;
    
    static tick = function()
    {
        if (value > 0)
        {
            held      = true;
            held_time = INPUT_BUFFERED_REALTIME? current_time : global.__input_frame;
                
            other.last_input_time = current_time;
        }
        
        if (previous_held == held)
        {
            press   = false;
            release = false;
        }
        else
        {
            if (held)
            {
                consumed   = false;
                press      = true;
                release    = false;
                press_time = INPUT_BUFFERED_REALTIME? current_time : global.__input_frame;
            }
            else
            {
                press        = false;
                release      = true;
                release_time = INPUT_BUFFERED_REALTIME? current_time : global.__input_frame;
            }
        }
    }
}