function __input_class_verb_state() constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE  //Set static __global
    
    name = undefined;
    type = undefined;
    __player = undefined;
    
    __inactive       = false;
    __group_inactive = false;
    __consumed       = false;
    
    __value        = 0.0;
    __raw          = 0.0;
    __analogue     = false;
    __rawAnalogue  = false;
    __minThreshold = 0;
    __maxThreshold = 1;
    
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
    
    
    
    static __Tick = function(_player, _playerActive, _currentProfileDict, _hasKeyboard, _hasMouse, _hasGamepad, _mixedMode)
    {
        var _time = __input_get_time();
        
        __value        = 0.0;
        __raw          = 0.0;
        __analogue     = false;
        __raw_analogue = false;
        __minThreshold = 0;
        __maxThreshold = 1;
        
        //TODO - Compress virtual and forced values into one set of variables
        //We've had our value set this frame via a virtual button
        if ((__virtual_value != undefined) && (__virtual_raw_value != undefined) && (__virtual_analogue != undefined))
        {
            if (_playerActive)
            {
                __raw          = __virtual_raw_value;
                __value        = __virtual_value;
                __analogue     = __virtual_analogue;
                __raw_analogue = __virtual_analogue;
                __minThreshold = 0;
                __maxThreshold = 1;
            }
                
            __virtual_value     = undefined;
            __virtual_raw_value = undefined;
            __virtual_analogue  = undefined;
        }
            
        //We've had our value set this frame via input_verb_set()
        if ((force_value != undefined) && (force_analogue != undefined))
        {
            if (_playerActive)
            {
                __raw          = force_value;
                __value        = force_value;
                __analogue     = force_analogue;
                __raw_analogue = force_analogue;
                __minThreshold = 0;
                __maxThreshold = 1;
            }
                
            force_value    = undefined;
            force_analogue = undefined;
        }
        
        if (_playerActive && is_struct(_currentProfileDict))
        {
            var _alternateArray = _currentProfileDict[$ name];
            var _alternate = 0;
            repeat(array_length(_alternateArray))
            {
                _alternateArray[_alternate].__Read(_player, self, _hasKeyboard, _hasMouse, _hasGamepad, _mixedMode);
                ++_alternate;
            }
        }
        
        press   = false;
        release = false;
        
        if (__value > 0)
        {
            __player.__last_input_time = __global.__current_time;
            
            held      = true;
            held_time = _time;
        }
        else
        {
            held = false;
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
        
        __inactive = (__group_inactive || __consumed || !_playerActive);
    }
}