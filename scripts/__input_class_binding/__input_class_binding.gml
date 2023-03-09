function __input_class_binding() constructor
{
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
            case __INPUT_BINDING_KEY:              return INPUT_KEYBOARD; break;
            case __INPUT_BINDING_MOUSE_BUTTON:     return INPUT_MOUSE;    break;
            case __INPUT_BINDING_MOUSE_WHEEL_UP:   return INPUT_MOUSE;    break;
            case __INPUT_BINDING_MOUSE_WHEEL_DOWN: return INPUT_MOUSE;    break;
            case __INPUT_BINDING_VIRTUAL_BUTTON:   return INPUT_TOUCH;    break;
            case __INPUT_BINDING_GAMEPAD_BUTTON:   return INPUT_GAMEPAD;  break;
            case __INPUT_BINDING_GAMEPAD_AXIS:     return INPUT_GAMEPAD;  break;
            
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
        && (_binding_shell.type != __INPUT_BINDING_MOUSE_WHEEL_UP)
        && (_binding_shell.type != __INPUT_BINDING_MOUSE_WHEEL_DOWN)
        && (_binding_shell.type != __INPUT_BINDING_VIRTUAL_BUTTON))
        {
            __input_error("Binding \"value\" not found; binding is corrupted");
            return;
        }
        
        if ((_binding_shell.type == __INPUT_BINDING_GAMEPAD_AXIS) && !variable_struct_exists(_binding_shell, "axis_negative"))
        {
            __input_error("Binding \"axis_negative\" not found; binding is corrupted");
            return;
        }
        
        var _value = _binding_shell[$ "value"];
        if ((_binding_shell.type == __INPUT_BINDING_GAMEPAD_AXIS) || (_binding_shell.type == __INPUT_BINDING_GAMEPAD_BUTTON))
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
            repeat(array_length(global.__input_gamepads))
            {
                var _gamepad = global.__input_gamepads[_g];
                
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
    
    static __set_android_lowercase = function()
    {
        //If we're on Android
        if ((os_type == os_android) && (type == __INPUT_BINDING_KEY))
        {
            //Force binding to uppercase
            value = ord(string_upper(chr(value)));
            
            //Grab the keyboard character for this key and force it into lowercase
            //If the lowercase and uppercase keys are different then we'll want to check the lowercase key as well
            var _android_lowercase = ord(string_lower(chr(value)));
            __android_lowercase = (_android_lowercase != value)? _android_lowercase : undefined;
            
            //Some Android devices and soft keyboards use carriage return for Enter, some use newline
            if ((value == 10) || (value == 13))
            {
                value = 10;
                __android_lowercase = 13;
            }
        }
    }
    
    static __duplicate = function()
    {
        with(new __input_class_binding())
        {
            type                  = other.type;
            value                 = other.value;
            axis_negative         = other.axis_negative;
            __label               = other.__label;
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
        
        if (_player_set)
        {
            if (INPUT_MERGE_CONTROL_KEYS)
            {
                switch (_key)
                {
                    //Combine player-bound control keys
                    case vk_lcontrol: case vk_rcontrol:  _key = vk_control; break;
                    case vk_lalt:     case vk_ralt:      _key = vk_alt;     break;
                    case vk_lshift:   case vk_rshift:    _key = vk_shift;   break;
                }
            }
        }
        else
        {
            if ((os_type == os_switch) || (os_type == os_linux) || (os_type == os_macosx))
            {
                //Fix F11 and F12 constants
                if      (_key == vk_f11)  _key = 128;
                else if (_key == vk_f12)  _key = 129;
            }
            
            if (!__INPUT_KEYBOARD_NORMATIVE)
            {
                //Fix UTF-8 where used
                if      (_key == vk_comma    )  _key = 44;
                else if (_key == vk_hyphen   )  _key = 45;
                else if (_key == vk_period   )  _key = 46;
                else if (_key == vk_fslash   )  _key = 47;
                else if (_key == vk_semicolon)  _key = 59;
                else if (_key == vk_equals   )  _key = 61;
                else if (_key == vk_lbracket )  _key = 91;
                else if (_key == vk_bslash   )  _key = 92;
                else if (_key == vk_rbracket )  _key = 93;
                else if (_key == vk_backtick )  _key = 96;
            }
        }
        
        type  = __INPUT_BINDING_KEY;
        value = _key;
        
        __set_android_lowercase(); //This also edits .value
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
        if (_button == mb_none)
        {
            __input_error("Cannot use mb_none as a mouse button binding\nInstead please use mb_any and then invert the result");
        }
        
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
    
    static __set_virtual_button = function()
    {
        type = __INPUT_BINDING_VIRTUAL_BUTTON;
        
        __set_label();
        
        return self;
    }
    
    static __set_label = function(_label)
    {
        if (_label == undefined)
        {
            __label = __input_binding_get_label(type, value, axis_negative)
        }
        else
        {
            __label = _label;
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
            case __INPUT_BINDING_VIRTUAL_BUTTON:   return __INPUT_SOURCE.TOUCH;    break;
            case __INPUT_BINDING_GAMEPAD_BUTTON:   return __INPUT_SOURCE.GAMEPAD;  break;
            case __INPUT_BINDING_GAMEPAD_AXIS:     return __INPUT_SOURCE.GAMEPAD;  break;
            case undefined:                        return undefined;               break;
        }
        
        __input_error("Binding type \"", type, "\" not recognised");
    }
    
    #endregion
}
