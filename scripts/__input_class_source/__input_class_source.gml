/// @param source
/// @param gamepad

function __input_class_source(_source, _gamepad = undefined) constructor
{
    __source  = _source;
    __gamepad = _gamepad;
    
    switch(__source)
    {
        case INPUT_SOURCE.NONE:         __name = "No source";                   break;
        case INPUT_SOURCE.GHOST:        __name = "ghost";                       break;
        case INPUT_SOURCE.KEYBOARD:     __name = "keyboard";                    break;
        case INPUT_SOURCE.MOUSE:        __name = "mouse";                       break;
        case INPUT_SOURCE.GAMEPAD:      __name = "gamepad " + string(_gamepad); break;
        case INPUT_SOURCE.ALL_GAMEPADS: __name = "all gamepads";                break;
        
        default:
            __input_error("Source \"", __source, "\" not recognised");
        break;
    }
    
    static __is_connected = function()
    {
        switch(__source)
        {
            case INPUT_SOURCE.NONE:         return false;                                 break;
            case INPUT_SOURCE.KEYBOARD:     return true;                                  break;
            case INPUT_SOURCE.MOUSE:        return true;                                  break;
            case INPUT_SOURCE.GHOST:        return true;                                  break;
            case INPUT_SOURCE.GAMEPAD:      return input_gamepad_is_connected(__gamepad); break;
            
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
                __input_error("Source \"", __source, "\" not recognised");
            break;
        }
    }
    
    static __collides_with = function(_source, _gamepad)
    {
        if ((_source.__source == INPUT_SOURCE.NONE) || (_source.__source == INPUT_SOURCE.GHOST)) return false;
        
        switch(_source.__source)
        {
            case INPUT_SOURCE.NONE:
            case INPUT_SOURCE.GHOST:
                return false;
            break;
            
            case INPUT_SOURCE.KEYBOARD:
                if (__source == INPUT_SOURCE.KEYBOARD) return true;
                if (INPUT_KEYBOARD_AND_MOUSE_ALWAYS_PAIRED && (__source == INPUT_SOURCE.MOUSE)) return true;
                return false;
            break;
            
            case INPUT_SOURCE.MOUSE:
                if (__source == INPUT_SOURCE.MOUSE) return true;
                if (INPUT_KEYBOARD_AND_MOUSE_ALWAYS_PAIRED && (__source == INPUT_SOURCE.KEYBOARD)) return true;
                return false;
            break;
            
            case INPUT_SOURCE.GAMEPAD:
                if (__source == INPUT_SOURCE.ALL_GAMEPADS) return true;
                if ((__source == INPUT_SOURCE.GAMEPAD) && (__gamepad != undefined) && (__gamepad == _source.__gamepad)) return true;
                return false;
            break;
            
            case INPUT_SOURCE.ALL_GAMEPADS:
                if (__source == INPUT_SOURCE.ALL_GAMEPADS) return true;
                if ((__source == INPUT_SOURCE.GAMEPAD) && (__gamepad != undefined)) return true;
                return false;
            break;
        }
        
        return false;
    }
}
    
function __input_source_any_input(_source, _gamepad)
{
    switch(_source)
    {
        case INPUT_SOURCE.NONE:
        case INPUT_SOURCE.GHOST:
            return false;
        break;
        
        case INPUT_SOURCE.KEYBOARD:
            return (global.__input_any_keyboard_binding_defined
                 && keyboard_check(vk_anykey)
                 && !__input_key_is_ignored(__input_keyboard_key()));
        break;
        
        case INPUT_SOURCE.MOUSE:
            return (global.__input_mouse_moved || (global.__input_any_mouse_binding_defined && (input_mouse_check(mb_any) || mouse_wheel_up() || mouse_wheel_down())));
        break;
        
        case INPUT_SOURCE.GAMEPAD:
            if (!gamepad_is_connected(_gamepad)) return false;
            
            if (input_gamepad_check(_gamepad, gp_face1)
            ||  input_gamepad_check(_gamepad, gp_face2)
            ||  input_gamepad_check(_gamepad, gp_face3)
            ||  input_gamepad_check(_gamepad, gp_face4)
            ||  input_gamepad_check(_gamepad, gp_padu)
            ||  input_gamepad_check(_gamepad, gp_padd)
            ||  input_gamepad_check(_gamepad, gp_padl)
            ||  input_gamepad_check(_gamepad, gp_padr)
            ||  input_gamepad_check(_gamepad, gp_shoulderl)
            ||  input_gamepad_check(_gamepad, gp_shoulderr)
            ||  input_gamepad_check(_gamepad, gp_start)
            ||  input_gamepad_check(_gamepad, gp_select)
            ||  input_gamepad_check(_gamepad, gp_stickl)
            ||  input_gamepad_check(_gamepad, gp_stickr)
            ||  input_gamepad_check(_gamepad, gp_stickr)
            ||  input_gamepad_check(_gamepad, gp_stickr)
            ||  input_gamepad_check(_gamepad, gp_stickr)
            ||  input_gamepad_check(_gamepad, gp_stickr)
            ||  (abs(input_gamepad_value(_gamepad, gp_shoulderlb)) > INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD)
            ||  (abs(input_gamepad_value(_gamepad, gp_shoulderrb)) > INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD)
            ||  (abs(input_gamepad_value(_gamepad, gp_axislh)) > INPUT_DEFAULT_AXIS_MIN_THRESHOLD)
            ||  (abs(input_gamepad_value(_gamepad, gp_axislv)) > INPUT_DEFAULT_AXIS_MIN_THRESHOLD)
            ||  (abs(input_gamepad_value(_gamepad, gp_axisrh)) > INPUT_DEFAULT_AXIS_MIN_THRESHOLD)
            ||  (abs(input_gamepad_value(_gamepad, gp_axisrv)) > INPUT_DEFAULT_AXIS_MIN_THRESHOLD))
            {
                return true;
            }
            
            if (INPUT_SDL2_ALLOW_EXTENDED)
            {
                if (input_gamepad_check(_gamepad, gp_guide)
                ||  input_gamepad_check(_gamepad, gp_misc1)
                ||  input_gamepad_check(_gamepad, gp_touchpad)
                ||  input_gamepad_check(_gamepad, gp_paddle1)
                ||  input_gamepad_check(_gamepad, gp_paddle2)
                ||  input_gamepad_check(_gamepad, gp_paddle3)
                ||  input_gamepad_check(_gamepad, gp_paddle4))
                {
                    return true;
                }
            }
            
            return false;
        break;
        
        case INPUT_SOURCE.ALL_GAMEPADS:
            var _g = 0;
            repeat(gamepad_get_device_count())
            {
                if (__input_source_any_input(INPUT_SOURCE.GAMEPAD, _g)) return true;
                ++_g;
            }
            
            return false;
        break;
        
        default:
            __input_error("Source \"", _source, "\" not recognised");
        break;
    }
}