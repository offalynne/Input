/// @param source
/// @param gamepad

function __input_class_source(_source, _gamepad = undefined) constructor
{
    source  = _source;
    gamepad = _gamepad;
    
    switch(source)
    {
        case INPUT_SOURCE.NONE:         name = "none";                  break;
        case INPUT_SOURCE.KEYBOARD:     name = __INPUT_CONFIG_KEYBOARD; break;
        case INPUT_SOURCE.MOUSE:        name = __INPUT_CONFIG_MOUSE;    break;
        case INPUT_SOURCE.GAMEPAD:      name = __INPUT_CONFIG_GAMEPAD;  break;
        case INPUT_SOURCE.ALL_GAMEPADS: name = "all gamepads";          break;
        case INPUT_SOURCE.GHOST:        name = "ghost";                 break;
        
        default:
            __input_error("Source \"", _source, "\" not recognised");
        break;
    }
    
    static __is_connected = function()
    {
        switch(source)
        {
            case INPUT_SOURCE.NONE:         return false;                               break;
            case INPUT_SOURCE.KEYBOARD:     return true;                                break;
            case INPUT_SOURCE.MOUSE:        return true;                                break;
            case INPUT_SOURCE.GHOST:        return true;                                break;
            case INPUT_SOURCE.GAMEPAD:      return input_gamepad_is_connected(gamepad); break;
            
            case INPUT_SOURCE.ALL_GAMEPADS:
                var _i = 0;
                repeat(gamepad_get_device_count())
                {
                    if (input_gamepad_is_connected(_i)) return true;
                    ++_i;
                }
                
                return false;
            break;
            
            default:
                __input_error("Source \"", source, "\" not recognised");
            break;
        }
    }
    
    static __collides_with = function(_source, _gamepad)
    {
        if ((_source == INPUT_SOURCE.NONE) || (_source == INPUT_SOURCE.GHOST)) return false;
        
        switch(_source)
        {
            case INPUT_SOURCE.NONE:
            case INPUT_SOURCE.GHOST:
                return false;
            break;
            
            case INPUT_SOURCE.KEYBOARD:
                if (source == INPUT_SOURCE.KEYBOARD) return true;
                if (INPUT_KEYBOARD_AND_MOUSE_ALWAYS_PAIRED && (source == INPUT_SOURCE.MOUSE)) return true;
                return false;
            break;
            
            case INPUT_SOURCE.MOUSE:
                if (source == INPUT_SOURCE.MOUSE) return true;
                if (INPUT_KEYBOARD_AND_MOUSE_ALWAYS_PAIRED && (source == INPUT_SOURCE.KEYBOARD)) return true;
                return false;
            break;
            
            case INPUT_SOURCE.GAMEPAD:
                if (source == INPUT_SOURCE.ALL_GAMEPADS) return true;
                if ((source == INPUT_SOURCE.GAMEPAD) && (gamepad != undefined) && (gamepad == _gamepad)) return true;
                return false;
            break;
            
            case INPUT_SOURCE.ALL_GAMEPADS:
                if (source == INPUT_SOURCE.ALL_GAMEPADS) return true;
                if ((source == INPUT_SOURCE.GAMEPAD) && (gamepad != undefined)) return true;
                return false;
            break;
        }
        
        return false;
    }
    
    static __get_config_name = function(_gamepad)
    {
        //Use the joycon config if the player is using a joycon at the moment
        if (source == INPUT_SOURCE.GAMEPAD)
        {
            var _gamepad_struct = global.__input_gamepads[gamepad];
            if (is_struct(_gamepad_struct) && ((_gamepad_struct.raw_type == "SwitchJoyConLeft") || (_gamepad_struct.raw_type == "SwitchJoyConRight")))
            {
                return __INPUT_CONFIG_JOYCON;
            }
        }
        else if (source == INPUT_SOURCE.ALL_GAMEPADS)
        {
            return __INPUT_CONFIG_GAMEPAD;
        }
        
        return name;
    }
}