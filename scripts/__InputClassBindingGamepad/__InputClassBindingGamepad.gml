function __InputClassBindingGamepad() : __InputClassBindingCommon() constructor
{
    static __type   = __INPUT_BINDING_GAMEPAD_AXIS;
    static __source = INPUT_GAMEPAD;
    
    __negative = false;
    __gamepad  = undefined;
    
    static __Set = function(_constant, _negative = false, _playerSet = false)
    {
        __constant = _constant;
        __negative = _negative;
        __SetLabel(__constant);
    }
    
    static __Read = function(_player, _verbState)
    {
        if (__gamepad == undefined)
        {
            var _sourceArray = _player.__source_array;
            var _i = 0;
            repeat(array_length(_sourceArray))
            {
                var _gamepadStruct = _sourceArray[_i].__gamepad;
                if (_gamepadStruct != undefined) __ReadInner(_verbState, _gamepadStruct);
                ++_i;
            }
        }
        else
        {
            __ReadInner(_verbState, __gamepad);
        }
        
        return false;
    }
    
    static __ReadInner = function(_verbState, _gamepadStruct)
    {
        if (_gamepadStruct.is_axis(__constant))
        {
            //Grab the raw value directly from the gamepad
            //We keep a hold of this value for use in 2D checkers
            var _foundRaw = _gamepadStruct.get_value(__constant);
            
            var _thresholdStruct = __axis_threshold_get(__constant);
            var _bindingThresholdMin = _thresholdStruct.mini;
            var _bindingThresholdMax = _thresholdStruct.maxi;
            
            //Correct the raw value's sign if needed
            if (__negative) _foundRaw = -_foundRaw;
            
            //The return value from this binding needs to be corrected using the thresholds previously defined
            var _foundValue = clamp((_foundRaw - _bindingThresholdMin) / (_bindingThresholdMax - _bindingThresholdMin), 0, 1);
            
            //If this binding is returning a value bigger than whatever we found before, let it override the old value
            //This is useful for situations where both the left + right analogue sticks are bound to movement
            with(_verbState)
            {
                if (_foundRaw > __raw)
                {
                    __raw          = _foundRaw;
                    __rawAnalogue  = true;
                    __minThreshold = _bindingThresholdMin;
                    __maxThreshold = _bindingThresholdMax;
                }
                
                if (_foundValue > __value)
                {
                    __value    = _foundValue;
                    __analogue = true;
                }
            }
        }
        else
        {
            if (_gamepadStruct.get_held(__constant))
            {
                with(_verbState)
                {
                    __value       = 1.0;
                    __raw         = 1.0;
                    __analogue    = false;
                    __rawAnalogue = false;
                }
                
                return true;
            }
        }
    }
    
    static __SetGamepad = function(_gamepad)
    {
        if (input_gamepad_is_connected(_gamepad)) __gamepad = _gamepad;
        return self;
    }
    
    static toString = function()
    {
        if (__gamepad_index != undefined)
        {
            if (__gamepad_description != undefined)
            {
                return __label + ", gamepad=" + string(__gamepad_index) + " \"" + __gamepad_description + "\"";
            }
            else
            {
                return __label + ", gamepad=" + string(__gamepad_index);
            }
        }
        else if (__gamepad_description != undefined)
        {
            return __label + ", gamepad=\"" + __gamepad_description + "\"";
        }
        
        return __label;
    }
    
    static __SetLabel = function(_label)
    {
        if (_label == undefined)
        {
            __label = __input_binding_get_label(__type, __constant, __negative);
        }
        else
        {
            __label = _label;
        }
        
        return self;
    }
}