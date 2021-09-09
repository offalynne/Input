/// @param binding
function input_mouse_check(_binding)
{
    //Disallow mouse input on touch platforms (unless explicitly enabled)
    if ((__INPUT_TOUCH_SUPPORT && !INPUT_TOUCH_MOUSE_ALLOWED) || (os_type == os_xboxone) || (os_type == os_xboxseriesxs))
    {
        return (_binding == mb_none);
    }
    
    //Extended touchpad handling (Windows only)
    if (os_type != os_windows)
    {
        //N.B. Fix *not* needed in UWP
        return (device_mouse_check_button(0, _binding));   
    }
    else
    {
        var _button = device_mouse_check_button(0, _binding);      
        switch (_binding)
        {            
            case mb_any:
            case mb_left:
                return (_button || global.__input_tap_click);
            break;

            case mb_none:
                return (_button && !(global.__input_tap_click));
            break;

            default:
                return _button;
            break;            
        }
    }
    
    __input_error("Mouse button out of range (", _binding, ")");
    return false;
}