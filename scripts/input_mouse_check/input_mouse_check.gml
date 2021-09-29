/// @param binding
function input_mouse_check(_binding)
{ 
    if (__INPUT_ON_PS && __INPUT_TOUCH_SUPPORT)
    {
        if (global.__input_pointer_index != undefined)
        {
            var _r = gamepad_button_check(global.__input_pointer_index / 2, gp_select);
            if ((_binding == mb_left) || (_binding == mb_any))
            {
               return _r;
            }
            else if (_binding == mb_none)
            {
               return !_r;
            }
        }
        
        return false;
    }
    
    if (global.__input_mouse_blocked) 
    {
        return (_binding == mb_none);
    }
    
    //Extended touchpad handling (Windows only, *not* UWP)
    if (os_type == os_windows)
    {
        var _button = device_mouse_check_button(0, _binding);      
        switch (_binding)
        {            
            case mb_any:
            case mb_left: return (_button || global.__input_tap_click);    break;
            case mb_none: return (_button && !(global.__input_tap_click)); break;
            default:      return  _button; break;            
        }
    }
    else
    {
        if (__INPUT_TOUCH_SUPPORT)
        {
            var _touch_check = device_mouse_check_button(global.__input_pointer_index, mb_left);
            var _extended_check = (device_mouse_check_button(0, mb_any) && !device_mouse_check_button(0, mb_left));
            
            switch (_binding)
            {
                case mb_left: return   _touch_check; break;
                case mb_any:  return  (_touch_check || _extended_check); break;
                case mb_none: return !(_touch_check || _extended_check); break;
            }
        }

        return (device_mouse_check_button(0, _binding));
    }
    
    __input_error("Mouse button out of range (", _binding, ")");
    return false;
}
