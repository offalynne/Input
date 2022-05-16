function __input_class_binding() constructor
{
    type          = undefined;
    value         = undefined;
    axis_negative = undefined;
    label         = undefined;
    
    __gamepad_index       = undefined;
    __gamepad_description = undefined;
    
    //We have an additional field on Android
    //This is used to check for uppercase *and* lowercase letters as Android checks for both individually
    __android_lowercase = undefined;
    
    //Accessibility features
    __threshold_min = undefined;
    __threshold_max = undefined;
    
    
    
    #region Public
    
    static gamepad = function(_gamepad)
    {
        if (input_gamepad_is_connected(_gamepad))
        {
            __gamepad_index = _gamepad;
            __gamepad_description = gamepad_get_description(_gamepad);
        }
        
        return self;
    }
    
    /// @param min
    /// @param max
    static threshold_set = function(_min, _max)
    {
        __threshold_min = _min
        __threshold_max = _max;
        return self;
    }
    
    static threshold_get = function()
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
        if (__android_lowercase   != undefined) _binding_shell.android_lowercase   = __android_lowercase;
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
        
        if (_binding_shell[$ "type"               ] != undefined) type                  = _binding_shell.type;
        if (_binding_shell[$ "value"              ] != undefined) value                 = _binding_shell.value;
        if (_binding_shell[$ "axis_negative"      ] != undefined) axis_negative         = _binding_shell.axis_negative;
        if (_binding_shell[$ "gamepad_description"] != undefined) __gamepad_description = _binding_shell.gamepad_description;
        if (_binding_shell[$ "android_lowercase"  ] != undefined) __android_lowercase   = _binding_shell.android_lowercase;
        if (_binding_shell[$ "threshold_min"      ] != undefined) __threshold_min       = _binding_shell.threshold_min;
        if (_binding_shell[$ "threshold_max"      ] != undefined) __threshold_max       = _binding_shell.threshold_max;
        
        //If we have a gamepad description then try to match that to a connected gamepad
        if (__gamepad_description != undefined)
        {
            var _g = 0;
            repeat(array_length(global.__input_gamepads))
            {
                var _gamepad = global.__input_gamepads[_g];
                
                if (_gamepad.description == __gamepad_description)
                {
                    __gamepad_index = _g;
                    break;
                }
                
                ++_g;
            }
        }
        
        __set_label();
    }
    
    static __duplicate = function()
    {
        with(new __input_class_binding())
        {
            type                  = other.type;
            value                 = other.value;
            axis_negative         = other.axis_negative;
            label                 = other.label;
            __gamepad_index       = other.__gamepad_index;
            __gamepad_description = other.__gamepad_description;
            __android_lowercase   = other.__android_lowercase;
            __threshold_min       = other.__threshold_min;
            __threshold_max       = other.__threshold_max;
            return self;
        }
    }
    
    static __set_key = function(_key, _player_set)
    {
        //Fix uses of straight strings instead of ord("A")
        if (is_string(_key)) _key = ord(string_upper(_key));
        
        //Fix UTF-8 where used
        if (!__INPUT_KEYBOARD_NORMATIVE && !_player_set)
        {
            if      (_key == vk_comma    )  { _key = 44; }
            else if (_key == vk_hyphen   )  { _key = 45; }
            else if (_key == vk_period   )  { _key = 46; }
            else if (_key == vk_fslash   )  { _key = 47; }
            else if (_key == vk_semicolon)  { _key = 59; }
            else if (_key == vk_equals   )  { _key = 61; }
            else if (_key == vk_lbracket )  { _key = 91; }
            else if (_key == vk_bslash   )  { _key = 92; }
            else if (_key == vk_rbracket )  { _key = 93; }
            else if (_key == vk_backtick )  { _key = 96; }
        }
                
        if (os_type == os_android)
        {
            //Force binding to uppercase
            _key = ord(string_upper(chr(_key)));

            //Grab the keyboard character for this key and force it into lowercase
            //If the lowercase and uppercase keys are different then we'll want to check the lowercase key as well
            var _android_lowercase = ord(string_lower(chr(_key)));
            if (_android_lowercase != _key) __android_lowercase = _android_lowercase;
            
            //Some Android devices and soft keyboards use carriage return for Enter, some use newline
            if ((_key == 10) || (_key == 13))
            {
                _key = 10;
                __android_lowercase = 13;
            }
        }
        
        type  = __INPUT_BINDING_KEY;
        value = _key;
        
        __set_label();
        
        return self;
    }
    
    static __set_gamepad_axis = function(_axis, _negative)
    {
        type          = __INPUT_BINDING_GAMEPAD_AXIS;
        value         = _axis;
        axis_negative = _negative;
        
        __set_label();
        
        return self;
    }
    
    static __set_gamepad_button = function(_button)
    {
        type   = __INPUT_BINDING_GAMEPAD_BUTTON;
        value  = _button;
        
        __set_label();
        
        return self;
    }
    
    static __set_mouse_button = function(_button)
    {
        type  = __INPUT_BINDING_MOUSE_BUTTON;
        value = _button;
        
        __set_label();
        
        return self;
    }
    
    static __set_mouse_wheel_down = function()
    {
        type = __INPUT_BINDING_MOUSE_WHEEL_DOWN;
        
        __set_label();
        
        return self;
    }
    
    static __set_mouse_wheel_up = function()
    {
        type = __INPUT_BINDING_MOUSE_WHEEL_UP;
        
        __set_label();
        
        return self;
    }
    
    static __set_label = function(_label)
    {
        if (_label == undefined)
        {
            label = __input_binding_get_label(type, value, axis_negative)
        }
        else
        {
            label = _label;
        }
        
        return self;
    }
    
    static __get_source_type = function()
    {
        switch(type)
        {
            case __INPUT_BINDING_KEY:              return __INPUT_SOURCE.KEYBOARD; break;
            case __INPUT_BINDING_MOUSE_BUTTON:     return __INPUT_SOURCE.MOUSE;    break;
            case __INPUT_BINDING_MOUSE_WHEEL_UP:   return __INPUT_SOURCE.MOUSE;    break;
            case __INPUT_BINDING_MOUSE_WHEEL_DOWN: return __INPUT_SOURCE.MOUSE;    break;
            case __INPUT_BINDING_GAMEPAD_BUTTON:   return __INPUT_SOURCE.GAMEPAD;  break;
            case __INPUT_BINDING_GAMEPAD_AXIS:     return __INPUT_SOURCE.GAMEPAD;  break;
            case undefined:                        return undefined;               break;
        }
        
        __input_error("Binding type \"", type, "\" not recognised");
    }
    
    #endregion
}
