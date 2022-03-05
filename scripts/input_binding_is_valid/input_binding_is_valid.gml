/// @param binding
/// @param [playerIndex]

function input_binding_is_valid(_binding, _player_index = 0)
{
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return false;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return false;
    }
    
    if (_binding == undefined)
    {
        //Invalid if, for example, there is no binding set for the source specified when getting a binding
        return false;
    }
    else
    {
        if (!input_value_is_binding(_binding))
        {
            __input_error("Value provided is not a binding");
            return false;
        }
    }

    var _type  = _binding.type;
    var _value = _binding.value;
    
    //Gamepad-specific validations
    if (string_count("gamepad", _type))
    {
        var _gamepad_index = global.__input_players[_player_index].gamepad;
        if (_gamepad_index < 0)
        {
            //No gamepad assigned to the player
            return false;
        }

        var _gamepad = global.__input_gamepads[_gamepad_index];
        if (!is_struct(_gamepad) || (_gamepad.mapping_gm_to_raw[$ _value] == undefined))
        {
            //Value not found in the mapping for the player's gamepad
            return false;
        }
         
        //Get raw value from mapping
        var _mapping = _gamepad.mapping_gm_to_raw[$ _value];
        var _raw = ((_mapping.raw == undefined) ? _mapping.raw_negative : _mapping.raw);
        if (_raw == undefined)
        {
            //Raw value invalid
            return false;
        }
        
        if (_gamepad.xinput && ((_raw == 4106) || (_raw == 4107))
        && ((_type = "gamepad button") || (_type == "gamepad axis")))
        {
            //Except XInput trigger values from range checks
            return true;
        }
        
        if (_raw == 0)
        {
            var _hat_mask = ((_mapping.hat_mask == undefined) ? _mapping.hat_mask_negative : _mapping.hat_mask);        
            if (_hat_mask != undefined)
            {
                //Validate hat mappings
                return ((_hat_mask == 1) || (_hat_mask == 2) || (_hat_mask == 4) || (_hat_mask == 8));
            }
        }
    }

    switch(_type)
    {            
        case "gamepad button": //Validate button range
            return (_raw < gamepad_button_count(_gamepad_index));
        break;

        case "gamepad axis": //Validate axis range
            return (_raw < gamepad_axis_count(_gamepad_index));
        break;
            
        case "key":
            if (!global.__input_keyboard_allowed)
            {
                //Invalid per platform or configuration
                return false;
            }
            
            if (os_type == os_android)
            {
                if (((_value >= 16) && (_value <= 19))
                ||  ((_value >= 96) && (_value <= 122)))
                {
                    //Command keys that overlap alpha don't register on Android, are invalid binds
                    return false;
                }
                
                var _lowercase = _binding.android_lowercase;
                if ((_lowercase != undefined) && !__input_key_is_ignored(_lowercase)
                &&  (_lowercase >= __INPUT_KEYCODE_MIN) && (_lowercase <= __INPUT_KEYCODE_MAX))
                {
                    //Lowercase key binding is valid
                    return true;
                }
            }

            //Uppercase key binding
            return (!__input_key_is_ignored(_value) && (_value >= __INPUT_KEYCODE_MIN) && (_value <= __INPUT_KEYCODE_MAX));
        break;

        case "mouse button":
            if (!global.__input_mouse_allowed)
            {
                //Invalid per platform or configuration
                return false;
            }

            switch(_value)
            {
                case mb_left: //Invalid on Xbox
                    return !__INPUT_ON_XDK;
                break;
                
                case mb_right: //Invalid on Xbox, Playstation, native Android or iOS
                    return !(__INPUT_ON_XDK || __INPUT_ON_PS || (!__INPUT_ON_WEB && ((os_type == os_ios) || (os_type == os_android))));
                break;
                
                case mb_middle: //Invalid on console, Android or iOS
                    return !(__INPUT_ON_CONSOLE || (os_type == os_ios) || (os_type == os_android));
                break;
                
                case mb_side1:
                case mb_side2: //Invalid on console, OperaGX, mobile, UWP, Firefox or Mac browsers
                    return !(__INPUT_ON_CONSOLE || __INPUT_ON_OPERAGX || __INPUT_ON_MOBILE || (os_type == os_uwp) || (os_browser == browser_firefox) || (__INPUT_ON_WEB && (os_type == os_macosx)))
                break;
                
                default:
                    return false;
                break;
            }
        break;

        case "mouse wheel up":
        case "mouse wheel down":
            if (!global.__input_mouse_allowed)
            {
                //Invalid per platform or configuration
                return false;
            }
            
            //Invalid on console or native mobile
            return !(__INPUT_ON_CONSOLE || (!__INPUT_ON_WEB && __INPUT_ON_MOBILE));        
        break;
        
        default:
            return false;
        break;
    }
    
    __input_error("Binding validity unhandled");
}
