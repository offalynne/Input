/// @param type
/// @param [value]
/// @param [axisNegative]
/// @param [labelOverride]

function __input_class_binding() constructor
{
    type          = undefined;
    value         = undefined;
    axis_negative = undefined;
    label         = undefined;
    
    if (os_type == os_android)
    {
        //We have an additional field on Android
        //This is used to check for uppercase *and* lowercase letters as Android checks for both individually
        android_lowercase = undefined;
    }
    
    static set_key = function(_key)
    {
        //Fix uses of straight strings instead of ord("A") etc.
        if (is_string(_key)) _key = ord(string_upper(_key));
        
        if (os_type == os_android)
        {
            //Force binding to uppercase
            if (_key >= ord("a")) && (_key <= ord("z")) _key = ord(string_upper(chr(_key)));

            //Grab the keyboard character for this key and force it into lowercase
            //If the lowercase and uppercase keys are different then we'll want to check the lowercase key as well
            var _android_lowercase = ord(string_lower(chr(_key)));
            if (_android_lowercase != _key) android_lowercase = _android_lowercase;
        }
        
        type  = "key";
        value = _key;
        
        set_label();
        
        return self;
    }
    
    static set_gamepad_axis = function(_axis, _negative)
    {
        type          = "gamepad axis";
        value         = _axis;
        axis_negative = _negative;
        
        set_label();
        
        return self;
    }
    
    static set_gamepad_button = function(_button)
    {
        type  = "gamepad button";
        value = _button;
        
        set_label();
        
        return self;
    }
    
    static set_mouse_button = function(_button)
    {
        type  = "mouse button";
        value = _button;
        
        set_label();
        
        return self;
    }
    
    static set_mouse_wheel_down = function()
    {
        type = "mouse wheel down";
        
        set_label();
        
        return self;
    }
    
    static set_mouse_wheel_up = function()
    {
        type = "mouse wheel up";
        
        set_label();
        
        return self;
    }
    
    static set_label = function(_label)
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
}
