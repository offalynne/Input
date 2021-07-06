/// @param binding
function input_mouse_check_button(_binding)
{
    //Extended touchpad handling (Windows only)
    if (os_type != os_windows)
    {
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