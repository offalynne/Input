function __InputClassBindingKey() : __InputClassBindingCommon() constructor
{
    static __type       = __INPUT_BINDING_TYPE_KEY;
    static __source     = INPUT_KEYBOARD;
    static __sourceType = __INPUT_SOURCE.KEYBOARD;
    
    __androidLowercase = undefined;
    
    static __Set = function(_constant, _negative = false, _playerSet = false)
    {
        //Fix uses of straight strings instead of ord("A")
        if (is_string(_constant)) _constant = ord(string_upper(_constant));
        
        if (_playerSet)
        {
            if (INPUT_MERGE_CONTROL_KEYS)
            {
                switch(_constant)
                {
                    //Combine player-bound control keys
                    case vk_lcontrol: case vk_rcontrol: _constant = vk_control; break;
                    case vk_lalt:     case vk_ralt:     _constant = vk_alt;     break;
                    case vk_lshift:   case vk_rshift:   _constant = vk_shift;   break;
                }
            }
        }
        else
        {
            if (__INPUT_ON_LINUX || __INPUT_ON_MACOS)
            {
                //Fix F11 and F12 constants
                if      (_constant == vk_f11) _constant = 128;
                else if (_constant == vk_f12) _constant = 129;
            }
            
            if (!__INPUT_KEYBOARD_NORMATIVE)
            {
                //Fix UTF-8 where used
                if      (_constant == vk_comma    ) _constant = 44;
                else if (_constant == vk_hyphen   ) _constant = 45;
                else if (_constant == vk_period   ) _constant = 46;
                else if (_constant == vk_fslash   ) _constant = 47;
                else if (_constant == vk_semicolon) _constant = 59;
                else if (_constant == vk_equals   ) _constant = 61;
                else if (_constant == vk_lbracket ) _constant = 91;
                else if (_constant == vk_bslash   ) _constant = 92;
                else if (_constant == vk_rbracket ) _constant = 93;
                else if (_constant == vk_backtick ) _constant = 96;
            }
        }
        
        //If we're on Android
        if (__INPUT_ON_ANDROID)
        {
            //Force binding to uppercase
            _constant = ord(string_upper(chr(_constant)));
            
            //Grab the keyboard character for this key and force it into lowercase
            //If the lowercase and uppercase keys are different then we'll want to check the lowercase key as well
            var _androidLowercase = ord(string_lower(chr(_constant)));
            __androidLowercase = (_androidLowercase != _constant)? _androidLowercase : undefined;
            
            //Some Android devices and soft keyboards use carriage return for Enter, some use newline
            if ((_constant == 10) || (_constant == 13))
            {
                _constant = 10;
                __androidLowercase = 13;
            }
        }
        
        __constant = _constant;
        __RefreshLabel();
    }
    
    static __Read = function(_player, _verbState)
    {
        if (_player.__sourceHasKeyboard)
        {
            if (keyboard_check(__constant))
            {
                with(_verbState)
                {
                    __value        = 1.0;
                    __raw          = 1.0;
                    __analogue     = false;
                    __raw_analogue = false;
                }
                
                return true;
            }
            
            //If we're on Android then check the alternate keyboard key as well
            if (__INPUT_ON_ANDROID)
            {
                if ((__androidLowercase != undefined) && keyboard_check(__androidLowercase))
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
        
        return false;
    }
    
    static __Duplicate = function()
    {
        with(new __InputClassBindingKey())
        {
            __constant         = other.__constant;
            __label            = other.__label;
            __androidLowercase = other.__androidLowercase;
            
            return self;
        }
    }
    
    static __Export = function()
    {
        var _struct = {
            bind: __InputConstantToLabel(__constant, false),
        };
        
        //MacOS likes to give us incorrect keycodes - the keycode is for a letter that's not on the user's keyboard
        if (__INPUT_ON_MACOS)
        {
            if (_struct.bind != __label) _struct.label = __label;
        }
        
        return _struct;
    }
    
    static __Import = function(_struct)
    {
        if (not variable_struct_exists(_struct, "bind"))
        {
            __input_error("Keyboard binding not found");
        }
        
        var _label      = _struct[$ "bind"];
        var _constant   = __InputLabelToConstant(_label);
        
        if (!is_numeric(_constant))
        {
            __input_error("Keyboard binding \"", _label, "\" not supported");
        }
        
        var _sourceType = __InputConstantToSourceType(_constant);
        if (_sourceType != __sourceType)
        {
            __input_error("Binding \"", _label, "\" is not a keyboard binding");
        }
        
        __Set(_constant, false, false);
        
        //MacOS likes to give us incorrect keycodes - the keycode is for a letter that's not on the user's keyboard
        if (__INPUT_ON_MACOS)
        {
            if (variable_struct_exists(_struct, "label")) __ForceLabel(_struct.label);
        }
    }
}