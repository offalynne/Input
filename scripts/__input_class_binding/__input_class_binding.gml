#macro __INPUT_BINDING_NULL  (new __input_class_binding())

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
    android_lowercase = undefined;
    
    static __duplicate = function()
    {
        var _new = new __input_class_binding();
        _new.type              = type;
        _new.value             = value;
        _new.axis_negative     = axis_negative;
        _new.label             = label;
        _new.android_lowercase = android_lowercase;
        
        return _new;
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
            if (_android_lowercase != _key) android_lowercase = _android_lowercase;
            
            //Some Android devices and soft keyboards use carriage return for Enter, some use newline
            if ((_key == 10) || (_key == 13))
            {
                _key = 10;
                android_lowercase = 13;
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
    
    static __set_gamepad = function(_gamepad)
    {
        if (input_gamepad_is_connected(_gamepad))
        {
            __gamepad_index = _gamepad;
            __gamepad_description = gamepad_get_description(_gamepad);
        }
        
        return self;
    }
    
    static __get_source = function()
    {
        switch(type)
        {
            case __INPUT_BINDING_KEY:              return __INPUT_SOURCE.KEYBOARD; break;
            case __INPUT_BINDING_MOUSE_BUTTON:     return __INPUT_SOURCE.MOUSE;    break;
            case __INPUT_BINDING_MOUSE_WHEEL_UP:   return __INPUT_SOURCE.MOUSE;    break;
            case __INPUT_BINDING_MOUSE_WHEEL_DOWN: return __INPUT_SOURCE.MOUSE;    break;
            case __INPUT_BINDING_GAMEPAD_BUTTON:   return __INPUT_SOURCE.GAMEPAD;  break;
            case __INPUT_BINDING_GAMEPAD_AXIS:     return __INPUT_SOURCE.GAMEPAD;  break;
            case undefined:                        return undefined;             break;
        }
        
        __input_error("Binding type \"", type, "\" not recognised");
    }
    
    static __get_automatic_profile_name = function()
    {
        switch(type)
        {
            case __INPUT_BINDING_KEY:              return INPUT_AUTO_PROFILE_FOR_KEYBOARD; break;
            case __INPUT_BINDING_MOUSE_BUTTON:     return INPUT_AUTO_PROFILE_FOR_MOUSE;    break;
            case __INPUT_BINDING_MOUSE_WHEEL_UP:   return INPUT_AUTO_PROFILE_FOR_MOUSE;    break;
            case __INPUT_BINDING_MOUSE_WHEEL_DOWN: return INPUT_AUTO_PROFILE_FOR_MOUSE;    break;
            case __INPUT_BINDING_GAMEPAD_BUTTON:   return INPUT_AUTO_PROFILE_FOR_GAMEPAD;  break;
            case __INPUT_BINDING_GAMEPAD_AXIS:     return INPUT_AUTO_PROFILE_FOR_GAMEPAD;  break;
            case undefined:                        return undefined;                       break;
        }
        
        __input_error("Binding type \"", type, "\" not recognised");
    }
}
