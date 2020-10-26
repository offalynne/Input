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
}