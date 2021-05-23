/// @param binding
function input_mouse_check_released(_binding)
{
    //Extended mouse button handling (Windows only)
    if (os_type != os_windows)
    {
        return (_binding < mb_back && device_mouse_check_button_released(0, _binding));   
    }
    else
    {
        //Check each since left/any/none will misreport touchscreen and touchpad taps as releases
        var _left    = (device_mouse_check_button_released(0, mb_left) && !global.__input_tap_click);
        var _middle  = device_mouse_check_button_released(0, mb_middle);
        var _right   = device_mouse_check_button_released(0, mb_right);
        
        
        var _back    = (global.__input_mouse_back_last    && !global.__input_mouse_back);
        var _forward = (global.__input_mouse_forward_last && !global.__input_mouse_forward);
        
        switch (_binding)
        {            
            case mb_any:
                return (_left || _right || _middle || _back || _forward);
            break;

            case mb_left:    return _left;    break;
            case mb_right:   return _right;   break;
            case mb_middle:  return _middle;  break;
            case mb_back:    return _back;    break;
            case mb_forward: return _forward; break;
            
            
            case mb_none:
                return !(_left || _right || _middle || _back || _forward);
            break;
        }
    }
    
    __input_error("Mouse button out of range (", _binding, ")");
    return false;
}