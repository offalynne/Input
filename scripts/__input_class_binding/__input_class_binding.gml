// Feather disable all

function __input_class_binding() constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE  //Set static __global
    
    __set_empty();
    
    static __set_empty = function()
    {
        __type          = undefined;
        __value         = undefined;
        __axis_negative = undefined;
        __label         = "empty binding";
        
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

    #endregion
    
    #region Private

    static __source_type_get = function()
    {
        switch(__type)
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
                __input_error("Unhandled binding type \"", __type, "\"");
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
    
    static __export = function()
    {
        var _binding_shell = {};
        
        if (__type                != undefined) _binding_shell.__type                = __type;
        if (__value               != undefined) _binding_shell.__value               = __value;
        if (__axis_negative       != undefined) _binding_shell.__axis_negative       = __axis_negative;
        if (__gamepad_description != undefined) _binding_shell.__gamepad_description = __gamepad_description;
        if (__threshold_min       != undefined) _binding_shell.__threshold_min       = __threshold_min;
        if (__threshold_max       != undefined) _binding_shell.__threshold_max       = __threshold_max;
        
        return _binding_shell;
    }
    
    static __import = function(_binding_shell)
    {
        var _type_var                   = variable_struct_exists(_binding_shell, "type")                ? "type"                : "__type";
        var _value_var                  = variable_struct_exists(_binding_shell, "value")               ? "value"               : "__value";
        var _axis_negative_var          = variable_struct_exists(_binding_shell, "axis_negative")       ? "axis_negative"       : "__axis_negative";
        var _gamepad_description_var    = variable_struct_exists(_binding_shell, "gamepad_description") ? "gamepad_description" : "__gamepad_description";
        var _threshold_min_var          = variable_struct_exists(_binding_shell, "threshold_min")       ? "threshold_min"       : "__threshold_min";
        var _threshold_max_var          = variable_struct_exists(_binding_shell, "threshold_max")       ? "threshold_max"       : "__threshold_max";

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
        
        if (!variable_struct_exists(_binding_shell, _type_var))
        {
            __input_error("Binding \"type\" not found; binding is corrupted");
            return;
        }
        
        var _type = _binding_shell[$ _type_var];
        if (!variable_struct_exists(_binding_shell, _value_var)
        && (_type != __INPUT_BINDING_MOUSE_WHEEL_UP)
        && (_type != __INPUT_BINDING_MOUSE_WHEEL_DOWN)
        && (_type != __INPUT_BINDING_VIRTUAL_BUTTON))
        {
            __input_error("Binding \"value\" not found; binding is corrupted");
            return;
        }
        
        if ((_type == __INPUT_BINDING_GAMEPAD_AXIS) && !variable_struct_exists(_binding_shell, _axis_negative_var))
        {
            __input_error("Binding \"axis_negative\" not found; binding is corrupted");
            return;
        }
        
        var _value = _binding_shell[$ _value_var];
        if ((_type == __INPUT_BINDING_GAMEPAD_AXIS) || (_type == __INPUT_BINDING_GAMEPAD_BUTTON))
        {
            switch(_value)
            {
                case __INPUT_LEGACY_GP_GUIDE:    case __INPUT_LEGACY_GP_ALT_GUIDE:    _value = gp_guide;    __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
                case __INPUT_LEGACY_GP_MISC1:    case __INPUT_LEGACY_GP_ALT_MISC1:    _value = gp_misc1;    __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
                case __INPUT_LEGACY_GP_TOUCHPAD: case __INPUT_LEGACY_GP_ALT_TOUCHPAD: _value = gp_touchpad; __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
                case __INPUT_LEGACY_GP_PADDLE1:  case __INPUT_LEGACY_GP_ALT_PADDLE1:  _value = gp_paddle1;  __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
                case __INPUT_LEGACY_GP_PADDLE2:  case __INPUT_LEGACY_GP_ALT_PADDLE2:  _value = gp_paddle2;  __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
                case __INPUT_LEGACY_GP_PADDLE3:  case __INPUT_LEGACY_GP_ALT_PADDLE3:  _value = gp_paddle3;  __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
                case __INPUT_LEGACY_GP_PADDLE4:  case __INPUT_LEGACY_GP_ALT_PADDLE4:  _value = gp_paddle4;  __input_trace("Warning! Legacy gamepad constant found, updating value (= ", _value, ")"); break;
            }
        }
        
        __type                = _type;
        __value               = _value;
        __axis_negative       = _binding_shell[$ _axis_negative_var         ];
        __gamepad_description = _binding_shell[$ _gamepad_description_var   ];
        __threshold_min       = _binding_shell[$ _threshold_min_var         ];
        __threshold_max       = _binding_shell[$ _threshold_max_var         ];
        
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
        
        __set_android_lowercase(); //This also edits .__value
        __set_label();
    }
    
    static __set_android_lowercase = function()
    {
        //If we're on Android
        if (__INPUT_ON_ANDROID && (__type == __INPUT_BINDING_KEY))
        {
            //Force binding to uppercase
            __value = ord(string_upper(chr(__value)));
            
            //Grab the keyboard character for this key and force it into lowercase
            //If the lowercase and uppercase keys are different then we'll want to check the lowercase key as well
            var _android_lowercase = ord(string_lower(chr(__value)));
            __android_lowercase = (_android_lowercase != __value)? _android_lowercase : undefined;
            
            //Some Android devices and soft keyboards use carriage return for Enter, some use newline
            if ((__value == 10) || (__value == 13))
            {
                __value = 10;
                __android_lowercase = 13;
            }
        }
    }
    
    static __duplicate = function()
    {
        with(new __input_class_binding())
        {
            __type                = other.__type;
            __value               = other.__value;
            __axis_negative       = other.__axis_negative;
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
        var _keycode = (is_string(_key)? ord(string_upper(_key)) : _key);
        
        if (_player_set)
        {
            if (INPUT_MERGE_CONTROL_KEYS)
            {
                //Combine player-bound control keys
                switch(_keycode)
                {
                    case vk_lcontrol: case vk_rcontrol: _keycode = vk_control; break;
                    case vk_lalt:     case vk_ralt:     _keycode = vk_alt;     break;
                    case vk_lshift:   case vk_rshift:   _keycode = vk_shift;   break;
                }
            }
        }
        else
        {
            if (__INPUT_ON_SWITCH || __INPUT_ON_LINUX || __INPUT_ON_MACOS)
            {
                //Fix F11 and F12 constants
                switch(_keycode)
                {
                    case vk_f11: _keycode = 0x80; break;
                    case vk_f12: _keycode = 0x81; break;
                }
            }
            
            if (!__INPUT_KEYBOARD_NORMATIVE)
            {
                //Fix UTF-8 where used
                if      (_keycode == vk_comma    ) { _keycode = 0x2C; }
                else if (_keycode == vk_hyphen   ) { _keycode = 0x2D; }
                else if (_keycode == vk_period   ) { _keycode = 0x2E; }
                else if (_keycode == vk_fslash   ) { _keycode = 0x2F; }
                else if (_keycode == vk_semicolon) { _keycode = 0x3B; }
                else if (_keycode == vk_equals   ) { _keycode = 0x3D; }
                else if (_keycode == vk_lbracket ) { _keycode = 0x5B; }
                else if (_keycode == vk_bslash   ) { _keycode = 0x5C; }
                else if (_keycode == vk_rbracket ) { _keycode = 0x5D; }
                else if (_keycode == vk_backtick ) { _keycode = 0x60; }
            }
        }
        
        __type  = __INPUT_BINDING_KEY;
        __value = _keycode;
        
        __set_android_lowercase(); //This also edits .__value
        __set_label();
        
        //Fix MacOS backtick
        if (__INPUT_ON_MACOS)
        {
            if ((_keycode == vk_backtick) && !is_string(_key))
            {
                __set_label("`");
            }
        }
        
        return self;
    }
    
    static __set_gamepad_axis = function(_axis, _negative)
    {
        __type          = __INPUT_BINDING_GAMEPAD_AXIS;
        __value         = _axis;
        __axis_negative = _negative;
        
        __set_label();
        
        return self;
    }
    
    static __set_gamepad_button = function(_button)
    {
        __type   = __INPUT_BINDING_GAMEPAD_BUTTON;
        __value  = _button;
        
        __set_label();
        
        return self;
    }
    
    static __set_mouse_button = function(_button)
    {
        if (_button == mb_none)
        {
            __input_error("Cannot use mb_none as a mouse button binding\nInstead please use mb_any and then invert the result");
        }
        
        __type  = __INPUT_BINDING_MOUSE_BUTTON;
        __value = _button;
        
        __set_label();
        
        return self;
    }
    
    static __set_mouse_wheel_down = function()
    {
        __type = __INPUT_BINDING_MOUSE_WHEEL_DOWN;
        
        __set_label();
        
        return self;
    }
    
    static __set_mouse_wheel_up = function()
    {
        __type = __INPUT_BINDING_MOUSE_WHEEL_UP;
        
        __set_label();
        
        return self;
    }
    
    static __set_virtual_button = function()
    {
        __type = __INPUT_BINDING_VIRTUAL_BUTTON;
        
        __set_label();
        
        return self;
    }
    
    static __set_label = function(_label)
    {
        if (_label == undefined)
        {
            __label = __input_binding_get_label(__type, __value, __axis_negative);
        }
        else
        {
            __label = _label;
        }
        
        return self;
    }
    
    static __get_source_type = function()
    {
        switch(__type)
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
        
        __input_error("Binding type \"", __type, "\" not recognised");
    }
    
    #endregion
}
