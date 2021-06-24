/// @param binding
function input_mouse_check_pressed(_binding)
{
    //Extended mouse button handling (Windows only)
    if (os_type != os_windows)
    {
        return (device_mouse_check_button_pressed(0, _binding));   
    }
    else
    {
        var _left = (device_mouse_check_button_pressed(0, mb_left) || global.__input_tap_click);
        var _any  = ( _left ||
                     device_mouse_check_button_pressed(0, mb_middle) ||
                     device_mouse_check_button_pressed(0, mb_right)  ||
                     device_mouse_check_button_pressed(0, mb_side1)  ||
                     device_mouse_check_button_pressed(0, mb_side2));

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