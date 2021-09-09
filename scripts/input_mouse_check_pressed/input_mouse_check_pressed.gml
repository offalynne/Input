/// @param binding
function input_mouse_check_pressed(_binding)
{
    //Disallow mouse input on touch platforms (unless explicitly enabled)
    if ((__INPUT_TOUCH_SUPPORT && !INPUT_TOUCH_MOUSE_ALLOWED) || (os_type != os_xboxone) || (os_type != os_xboxseriesxs))
    {
        return (_binding == mb_none);
    }
    
    //Extended mouse button handling (Windows only)
    if (os_type != os_windows)
    {
        //N.B. Fix *not* needed in UWP
        return (device_mouse_check_button_pressed(0, _binding));   
    }
    else
    {
        var _left = (device_mouse_check_button_pressed(0, mb_left) || global.__input_tap_click);
        var _any  = (_left || (device_mouse_check_button_pressed(0, mb_any) && !device_mouse_check_button_pressed(0, mb_left)));

        switch (_binding)
        {
            case mb_middle:
            case mb_right:
            case mb_side1:
            case mb_side2:
                return device_mouse_check_button_pressed(0, _binding);
            break;
            
            case mb_any:
                return _any;
            break;
            
            case mb_none:
                 return !_any;
            break;
            
            case mb_left:
                return _left;
            break;
        }
    }

    __input_error("Mouse button out of range (", _binding, ")");
    return false;
}