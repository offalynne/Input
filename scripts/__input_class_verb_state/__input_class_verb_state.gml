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
    
    
    
    static __Tick = function(_player, _playerActive, _currentProfileDict, _hasKeyboard, _hasMouse, _hasGamepad, _mixedMode)
    {
        var _time = __input_get_time();
        
        value         = 0.0;
        raw           = 0.0;
        analogue      = false;
        raw_analogue  = false;
        min_threshold = 0;
        max_threshold = 1;
        
        //TODO - Compress virtual and forced values into one set of variables
        //We've had our value set this frame via a virtual button
        if ((__virtual_value != undefined) && (__virtual_raw_value != undefined) && (__virtual_analogue != undefined))
        {
            if (_playerActive)
            {
                raw   = __virtual_raw_value;
                value = __virtual_value;
                
                analogue     = __virtual_analogue;
                raw_analogue = __virtual_analogue;
                
                min_threshold = 0;
                max_threshold = 1;
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
                raw   = force_value;
                value = force_value;
                
                analogue     = force_analogue;
                raw_analogue = force_analogue;
                
                min_threshold = 0;
                max_threshold = 1;
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
        
        if (value > 0)
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