/// @param GMconstant
/// @param rawIndex
/// @param rawMappingType
/// @param SDLname

function __input_class_gamepad_mapping(_gm, _raw, _type, _sdl_name) constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE  //Set static __global
    
    gm       = _gm;
    raw      = _raw;
    type     = _type;
    sdl_name = _sdl_name;
    
    invert         = false;
    clamp_negative = false;
    clamp_positive = false;
    reverse        = false;
    limited_range  = false;
    extended_range = false;
    hat_mask       = undefined;
    scale          = 256;
    
    //Hat-on-axis and split axis
    raw_negative = undefined;
    raw_positive = undefined;
     
    //These values are used for the hat-on-axis special case mapping
    //This is by far and away most commonly used for Switch Joycons
    hat_mask_negative = undefined;
    hat_mask_positive = undefined;
    
    //Split axis. This is rare but does come up every now and again
    positive_clamp_negative = false;
    positive_clamp_positive = false;
    negative_clamp_negative = false;
    negative_clamp_positive = false;
    
    held_previous = false;
    value         = 0.0;
    held          = false;
    press         = false;
    release       = false;
    
    __value_previous = undefined;
    __value_delta    = 0.0;
    
    static tick = function(_gamepad, _scan)
    {
        held_previous = held;
        if (__value_previous != undefined) __value_previous = value; //Don't update the previous value until we get our first scanned value
        
        value   = 0.0;
        held    = false;
        press   = false;
        release = false;
        
        if (!_scan) return;
        
        if (INPUT_ALLOW_OUT_OF_FOCUS || __global.__window_focus)
        {        
            switch(type)
            {
                case __INPUT_MAPPING.BUTTON:
                    value = gamepad_button_check(_gamepad, raw);
                break;
                    
                case __INPUT_MAPPING.AXIS:
                    value = gamepad_axis_value(_gamepad, raw);
                break;
                    
                case __INPUT_MAPPING.HAT:
                    value = ((gamepad_hat_value(_gamepad, raw) & hat_mask) > 0);
                break;
                    
                case __INPUT_MAPPING.HAT_TO_AXIS:
                    value = ((gamepad_hat_value( _gamepad, raw_positive) & hat_mask_positive) > 0) - ((gamepad_hat_value(_gamepad, raw_negative) & hat_mask_negative) > 0);
                break;
                    
                case __INPUT_MAPPING.BUTTON_TO_AXIS:
                    var _positive = gamepad_button_check(_gamepad, raw_positive);
                    var _negative = gamepad_button_check(_gamepad, raw_negative);
                    
                    value = _positive - _negative;
                break;
                    
                case __INPUT_MAPPING.SPLIT_AXIS:
                    var _positive = gamepad_axis_value(_gamepad, raw_positive);
                    var _negative = gamepad_axis_value(_gamepad, raw_negative);
                    
                    if (positive_clamp_negative) _positive = clamp(_positive, -1, 0);
                    if (positive_clamp_positive) _positive = clamp(_positive,  0, 1);
                    if (negative_clamp_negative) _negative = clamp(_negative, -1, 0);
                    if (negative_clamp_positive) _negative = clamp(_negative,  0, 1);
                    
                    value = _positive - _negative;
                break;
            }
             
            if (limited_range)  value = 2*value - 1; //Expand 0 -> 1 range to the full -1 -> +1
            if (extended_range) value = 0.5 + 0.5*value; //Reduce -1 -> +1 range to 0 -> 1
            if (reverse)        value = -value;
            if (clamp_negative) value = clamp(value, -1, 0);
            if (clamp_positive) value = clamp(value,  0, 1);
            if (invert)         value = 1 - value;
                  
            value = clamp((256/scale)*value, -1, 1);
            
            if (__value_previous == undefined)
            {
                //Capture the initial value
                __value_previous = value;
            }
            
            __value_delta = value - __value_previous;
            held = (abs(value) > __INPUT_HOLD_THRESHOLD);
        }
        
        if (held_previous != held)
        {
            if (held)
            {
                press = true;
            }
            else
            {
                release = true;
            }
        }
    }
}