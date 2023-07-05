function __InputClassBindingGamepad() : __InputClassBindingCommon() constructor
{
    static __source     = INPUT_GAMEPAD;
    static __sourceType = __INPUT_SOURCE.GAMEPAD;
    
    __absConstant = undefined;
    __negative    = false;
    __gamepad     = undefined;
    
    static __Set = function(_constant, _playerSet = false)
    {
        if (!INPUT_SDL2_ALLOW_EXTENDED 
        && ((_constant >= gp_guide) && (_constant <= gp_paddle4)))
        {
            __input_error("Extended gamepad binding not permitted\nSet INPUT_SDL2_ALLOW_EXTENDED to <true> to allow binding of extended buttons.");
        }
        else if (__INPUT_ON_PS && (_constant == gp_touchpad))
        {
            _constant = gp_select;
        }
        
        __constant = _constant;
        
        __absConstant = abs(_constant);
        __negative    = (_constant < 0);
        
        __RefreshLabel();
        
        return self;
    }
    
    static __Read = function(_player, _verbState, hasKeyboard, _hasMouse, _hasGamepad, _mixedMode)
    {
        if (_hasGamepad)
        {
            if ((__gamepad == undefined) || _mixedMode)
            {
                var _sourceArray = _player.__source_array;
                var _i = 0;
                repeat(array_length(_sourceArray))
                {
                    var _sourceStruct = _sourceArray[_i];
                    var _gamepad = _sourceStruct.__gamepad;
                    
                    if (_gamepad != undefined)
                    {
                        var _gamepadStruct = __global.__gamepads[_gamepad]
                        if (is_struct(_gamepadStruct)) __ReadInner(_player, _verbState, _gamepadStruct);
                    }
                    
                    ++_i;
                }
            }
            else
            {
                var _gamepadStruct = __global.__gamepads[__gamepad];
                if (is_struct(_gamepadStruct)) __ReadInner(_player, _verbState, _gamepadStruct);
            }
        }
        
        return false;
    }
    
    static __ReadInner = function(_player, _verbState, _gamepadStruct)
    {
        if (_gamepadStruct.is_axis(__absConstant))
        {
            //Grab the raw value directly from the gamepad
            //We keep a hold of this value for use in 2D checkers
            var _foundRaw = _gamepadStruct.get_value(__absConstant);
            
            var _thresholdStruct = _player.__axis_threshold_get(__absConstant);
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
        if (input_gamepad_is_connected(_gamepad) || (_gamepad == undefined)) __gamepad = _gamepad;
        return self;
    }
    
    static toString = function()
    {
        if (__gamepad != undefined)
        {
            return __label + ", gamepad=" + string(__gamepad) + " \"" + input_gamepad_get_description(__gamepad) + "\"";
        }
        
        return __label;
    }
    
    static __Duplicate = function()
    {
        with(new __InputClassBindingGamepad())
        {
            __constant    = other.__constant;
            __label       = other.__label;
            __absConstant = other.__absConstant;
            __negative    = other.__negative;
            __gamepad     = other.__gamepad;
            
            return self;
        }
    }
    
    static __Export = function()
    {
        var _struct = {
            bind: __InputConstantToLabel(__constant),
        };
        
        if (__gamepad != undefined)
        {
            var _gamepadStruct = __global.gamepads[__gamepad];
            if (is_struct(_gamepadStruct)) _struct.gamepad = _gamepadStruct.description;
        }
        
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
        
        __Set(_constant, false);
        
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
                    __SetGamepad(_g);
                    break;
                }
                    
                ++_g;
            }
        }
        
        if (not _found) __SetGamepad(undefined);
    }
}