function __InputClassBindingKey() constructor
{
    static __type   = "keyboard";
    static __source = INPUT_KEYBOARD;
    
    __key = undefined;
    __androidLowercase = undefined;
    
    static __Set = function(_constant, _negative = false, _playerSet = false)
    {
        //Fix uses of straight strings instead of ord("A")
        if (is_string(_key)) _key = ord(string_upper(_key));
        
        if (_playerSet)
        {
            if (INPUT_MERGE_CONTROL_KEYS)
            {
                switch(_key)
                {
                    //Combine player-bound control keys
                    case vk_lcontrol: case vk_rcontrol: _key = vk_control; break;
                    case vk_lalt:     case vk_ralt:     _key = vk_alt;     break;
                    case vk_lshift:   case vk_rshift:   _key = vk_shift;   break;
                }
            }
        }
        else
        {
            if (__INPUT_ON_SWITCH || __INPUT_ON_LINUX || __INPUT_ON_MACOS)
            {
                //Fix F11 and F12 constants
                if      (_key == vk_f11) _key = 128;
                else if (_key == vk_f12) _key = 129;
            }
            
            if (!__INPUT_KEYBOARD_NORMATIVE)
            {
                //Fix UTF-8 where used
                if      (_key == vk_comma    ) _key = 44;
                else if (_key == vk_hyphen   ) _key = 45;
                else if (_key == vk_period   ) _key = 46;
                else if (_key == vk_fslash   ) _key = 47;
                else if (_key == vk_semicolon) _key = 59;
                else if (_key == vk_equals   ) _key = 61;
                else if (_key == vk_lbracket ) _key = 91;
                else if (_key == vk_bslash   ) _key = 92;
                else if (_key == vk_rbracket ) _key = 93;
                else if (_key == vk_backtick ) _key = 96;
            }
        }
        
        //If we're on Android
        if (__INPUT_ON_ANDROID)
        {
            //Force binding to uppercase
            _key = ord(string_upper(chr(_key)));
            
            //Grab the keyboard character for this key and force it into lowercase
            //If the lowercase and uppercase keys are different then we'll want to check the lowercase key as well
            var _androidLowercase = ord(string_lower(chr(_key)));
            __androidLowercase = (_androidLowercase != _key)? _androidLowercase : undefined;
            
            //Some Android devices and soft keyboards use carriage return for Enter, some use newline
            if ((_key == 10) || (_key == 13))
            {
                _key = 10;
                __androidLowercase = 13;
            }
        }
        
        __key = _key;
    }
    
    static __Read = function(_player, _verbState)
    {
        if (_player.__sourceHasKeyboard)
        {
            if (keyboard_check(__key))
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
}