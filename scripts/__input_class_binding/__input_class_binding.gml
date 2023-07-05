function __input_class_binding() constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE  //Set static __global
    
    __set_empty();
    
    static __set_empty = function()
    {
        type          = undefined;
        value         = undefined;
        axis_negative = undefined;
        __label       = "empty binding";
        
        __gamepad_index       = undefined;
        __gamepad_description = undefined;
        
        //We have an additional field on Android
        //This is used to check for uppercase *and* lowercase letters as Android checks for both individually
        __android_lowercase = undefined;
        
        //Accessibility features
        __threshold_min = undefined;
        __threshold_max = undefined;
        
        return self;
    }
    
    
    
    #region Public
    
    static toString = function()
    {
        var _string = __label;
        
        if (__gamepad_index != undefined)
        {
            if (__gamepad_description != undefined)
            {
                _string += ", gamepad=" + string(__gamepad_index) + " \"" + __gamepad_description + "\"";
            }
            else
            {
                _string += ", gamepad=" + string(__gamepad_index);
            }
        }
        else if (__gamepad_description != undefined)
        {
            _string += ", gamepad=\"" + __gamepad_description + "\"";
        }
        
        if ((__threshold_min != undefined) || (__threshold_max != undefined))
        {
            _string += ", threshold=" + __threshold_min + "->" + string(__threshold_max);
        }
        
        return _string;
    }
    
    static __source_type_get = function()
    {
        switch(type)
        {
            case __INPUT_BINDING_TYPE_KEY:     return INPUT_KEYBOARD; break;
            case __INPUT_BINDING_TYPE_MOUSE:   return INPUT_MOUSE;    break;
            case __INPUT_BINDING_TYPE_GAMEPAD: return INPUT_GAMEPAD;  break;
            
            case undefined:
                __input_trace("Warning! Binding type has not been defined");
                return undefined;
            break;
            
            default:
                __input_error("Unhandled binding type \"", type, "\"");
            break;
        }
    }
    
    static __gamepad_set = function(_gamepad)
    {
        if (input_gamepad_is_connected(_gamepad))
        {
            __gamepad_index = _gamepad;
            __gamepad_description = gamepad_get_description(_gamepad);
        }
        
        return self;
    }
    
    static __gamepad_get = function()
    {
        return __gamepad_index;
    }
    
    /// @param min
    /// @param max
    static __threshold_set = function(_min, _max)
    {
        __threshold_min = _min
        __threshold_max = _max;
        return self;
    }
    
    static __threshold_get = function()
    {
        return {
            mini: __threshold_min,
            maxi: __threshold_max,
        };
    }
    
    #endregion
    
    
    
    #region Private
    
    static __export = function()
    {
        var _binding_shell = {};
        
        if (type                  != undefined) _binding_shell.type                = type;
        if (value                 != undefined) _binding_shell.value               = value;
        if (axis_negative         != undefined) _binding_shell.axis_negative       = axis_negative;
        if (__gamepad_description != undefined) _binding_shell.gamepad_description = __gamepad_description;
        if (__threshold_min       != undefined) _binding_shell.threshold_min       = __threshold_min;
        if (__threshold_max       != undefined) _binding_shell.threshold_max       = __threshold_max;
        
        return _binding_shell;
    }
    
    static __import = function(_binding_shell)
    {
        if (!is_struct(_binding_shell))
        {
            __input_trace("Warning! Could not import binding, clearing this binding (typeof=", typeof(_binding_shell), ")");
            _binding_shell = {};
        }
        
        if (variable_struct_names_count(_binding_shell) <= 0)
        {
            __set_empty();
            return;
        }
        
        if (!variable_struct_exists(_binding_shell, "type"))
        {
            __input_error("Binding \"type\" not found; binding is corrupted");
            return;
        }
        
        if (!variable_struct_exists(_binding_shell, "value")
        && (_binding_shell.type != __INPUT_BINDING_TYPE_MOUSE))
        {
            __input_error("Binding \"value\" not found; binding is corrupted");
            return;
        }
        
        if ((_binding_shell.type == __INPUT_BINDING_TYPE_GAMEPAD) && !variable_struct_exists(_binding_shell, "axis_negative"))
        {
            __input_error("Binding \"axis_negative\" not found; binding is corrupted");
            return;
        }
        
        var _value = _binding_shell[$ "value"];
        if (_binding_shell.type == __INPUT_BINDING_TYPE_GAMEPAD)
        {
            switch(_value)
            {
                case __INPUT_LEGACY_GP_GUIDE:    _value = gp_guide;    __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
                case __INPUT_LEGACY_GP_MISC1:    _value = gp_misc1;    __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
                case __INPUT_LEGACY_GP_TOUCHPAD: _value = gp_touchpad; __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
                case __INPUT_LEGACY_GP_PADDLE1:  _value = gp_paddle1;  __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
                case __INPUT_LEGACY_GP_PADDLE2:  _value = gp_paddle2;  __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
                case __INPUT_LEGACY_GP_PADDLE3:  _value = gp_paddle3;  __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
                case __INPUT_LEGACY_GP_PADDLE4:  _value = gp_paddle4;  __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
            }
        }
        
        type                  = _binding_shell.type;
        value                 = _value;
        axis_negative         = _binding_shell[$ "axis_negative"      ];
        __gamepad_description = _binding_shell[$ "gamepad_description"];
        __threshold_min       = _binding_shell[$ "threshold_min"      ];
        __threshold_max       = _binding_shell[$ "threshold_max"      ];
        
        //If we have a gamepad description then try to match that to a connected gamepad
        if (__gamepad_description != undefined)
        {
            var _g = 0;
            repeat(array_length(__global.__gamepads))
            {
                var _gamepad = __global.__gamepads[_g];
                
                if (is_struct(_gamepad) && (_gamepad.description == __gamepad_description))
                {
                    __gamepad_index = _g;
                    break;
                }
                
                ++_g;
            }
        }
        
        __set_android_lowercase(); //This also edits .value
        __set_label();
    }
    
    #endregion
}
