function __InputClassBindingGamepad() : __InputClassBindingCommon() constructor
{
    static __type       = __INPUT_BINDING_TYPE_GAMEPAD;
    static __source     = INPUT_GAMEPAD;
    static __sourceType = __INPUT_SOURCE.GAMEPAD;
    
    __negative      = false;
    __gamepadStruct = undefined;
    
    static __Set = function(_constant, _negative = false, _playerSet = false)
    {
        __constant = _constant;
        __negative = _negative;
        __RefreshLabel();
    }
    
    static __Read = function(_player, _verbState)
    {
        if (__gamepadStruct == undefined)
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
            __ReadInner(_verbState, __gamepadStruct);
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
        if (input_gamepad_is_connected(_gamepad) || (_gamepad == undefined)) __gamepadStruct = _gamepad;
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
    
    static __Duplicate = function()
    {
        with(new __InputClassBindingMouse())
        {
            __constant            = other.__constant;
            __label               = other.__label;
            __gamepad_index       = other.__gamepad_index;
            __gamepad_description = other.__gamepad_description;
            
            return self;
        }
    }
    
    static __Export = function()
    {
        var _struct = {
            bind: __InputConstantToLabel(__constant),
        };
        
        if (__gamepadStruct != undefined) _struct.gamepad = __gamepadStruct.description;
        
        return _struct;
    }
    
    static __Import = function(_struct)
    {
        if (not variable_struct_exists(_struct, "bind"))
        {
            __input_error("Gamepad binding not found");
        }
        
        var _label    = _struct[$ "bind"];
        var _constant = __InputLabelToConstant(_label);
        
        if (!is_numeric(_constant))
        {
            __input_error("Gamepad binding \"", _label, "\" not supported");
        }
        
        var _sourceType = __InputConstantToSourceType(_constant);
        if (_sourceType != __sourceType)
        {
            __input_error("Binding \"", _label, "\" is not a gamepad binding");
        }
        
        __Set(_constant, false, false);
        
        //If we have a gamepad description then try to match that to a connected gamepad
        var _found = false;
        var _incomingDescription = _struct[$ "gamepad"];
        
        if (_incomingDescription != undefined)
        {
            var _g = 0;
            repeat(array_length(__global.__gamepads))
            {
                var _gamepad = __global.__gamepads[_g];
                if (is_struct(_gamepad) && (_gamepad.description == _incomingDescription))
                {
                    __SetGamepad(_gamepad);
                    break;
                }
                    
                ++_g;
            }
        }
        
        if (not _found) __SetGamepad(undefined);
    }
}