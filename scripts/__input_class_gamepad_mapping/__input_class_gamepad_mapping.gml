// Feather disable all
/// @param GMconstant
/// @param rawIndex
/// @param rawMappingType
/// @param SDLname

function __input_class_gamepad_mapping(_gm, _raw, _type, _sdl_name) constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE  //Set static __global
    
    __gm       = _gm;
    __raw      = _raw;
    __type     = _type;
    __sdl_name = _sdl_name;
    
    __invert         = false;
    __clamp_negative = false;
    __clamp_positive = false;
    __reverse        = false;
    __limited_range  = false;
    __extended_range = false;
    __hat_mask       = undefined;
    __scale          = 1;
    
    //Hat-on-axis and split axis
    __raw_negative = undefined;
    __raw_positive = undefined;
     
    //These values are used for the hat-on-axis special case mapping
    //This is by far and away most commonly used for Switch Joycons
    __hat_mask_negative = undefined;
    __hat_mask_positive = undefined;
    
    //Split axis. This is rare but does come up every now and again
    __positive_clamp_negative = false;
    __positive_clamp_positive = false;
    __negative_clamp_negative = false;
    __negative_clamp_positive = false;
    
    __held_previous = false;
    __value         = 0.0;
    __held          = false;
    __press         = false;
    __release       = false;
    
    __value_previous = undefined;
    __value_delta    = 0.0;
    
    static __tick = function(_gamepad, _scan)
    {
        __held_previous = __held;
        if (__value_previous != undefined) __value_previous = __value; //Don't update the previous value until we get our first scanned value
        
        __value   = 0.0;
        __held    = false;
        __press   = false;
        __release = false;
        
        if (!_scan) return;
        
        if (__global.__game_input_allowed || (__global.__allow_gamepad_tester && __global.__gamepad_tester_data.__enabled && is_debug_overlay_open()))
        {        
            switch(__type)
            {
                case __INPUT_MAPPING.BUTTON:
                    __value = gamepad_button_check(_gamepad, __raw);
                break;
                    
                case __INPUT_MAPPING.AXIS:
                    __value = gamepad_axis_value(_gamepad, __raw);
                break;
                    
                case __INPUT_MAPPING.HAT:
                    __value = ((gamepad_hat_value(_gamepad, __raw) & __hat_mask) > 0);
                break;
                    
                case __INPUT_MAPPING.HAT_TO_AXIS:
                    __value = ((gamepad_hat_value( _gamepad, __raw_positive) & __hat_mask_positive) > 0) - ((gamepad_hat_value(_gamepad, __raw_negative) & __hat_mask_negative) > 0);
                break;
                    
                case __INPUT_MAPPING.BUTTON_TO_AXIS:
                    var _positive = gamepad_button_check(_gamepad, __raw_positive);
                    var _negative = gamepad_button_check(_gamepad, __raw_negative);
                    
                    __value = _positive - _negative;
                break;
                    
                case __INPUT_MAPPING.SPLIT_AXIS:
                    var _positive = gamepad_axis_value(_gamepad, __raw_positive);
                    var _negative = gamepad_axis_value(_gamepad, __raw_negative);
                    
                    if (__positive_clamp_negative) _positive = clamp(_positive, -1, 0);
                    if (__positive_clamp_positive) _positive = clamp(_positive,  0, 1);
                    if (__negative_clamp_negative) _negative = clamp(_negative, -1, 0);
                    if (__negative_clamp_positive) _negative = clamp(_negative,  0, 1);
                    
                    __value = _positive - _negative;
                break;
            }
             
            if (__limited_range)  __value = 2*__value - 1; //Expand 0 -> 1 range to the full -1 -> +1
            if (__extended_range) __value = 0.5 + 0.5*__value; //Reduce -1 -> +1 range to 0 -> 1
            if (__reverse)        __value = -__value;
            if (__clamp_negative) __value = clamp(__value, -1, 0);
            if (__clamp_positive) __value = clamp(__value,  0, 1);
            if (__invert)         __value = 1 - __value;
                  
            __value = clamp(__scale*__value, -1, 1);
            
            if (__value_previous == undefined)
            {
                //Capture the initial value
                __value_previous = __value;
            }
            
            __value_delta = __value - __value_previous;
            __held = (abs(__value) > __INPUT_HOLD_THRESHOLD);
        }
        
        if (__held_previous != __held)
        {
            if (__held)
            {
                __press = true;
            }
            else
            {
                __release = true;
            }
        }
    }
    
    static __calibrate = function(_success)
    {
        if ((__type != __INPUT_MAPPING.BUTTON) || __input_axis_is_directional(__gm))
        {
            __value   = 0.0;
            __held    = false;
            __press   = false;
            __release = false;

            if (_success || ((__value_delta != 0.0) && (abs(__value_delta) != 0.5) && (abs(__value_delta) != 1.0)))
            {                
                __value_previous = 0.0;
                __value_delta    = 0.0;
                
                return true;
            }
                
            __value_delta = 0.0;
        }
                    
        return false;
    }
}
