/// @desc    Returns whether the given mouse button is newly deactivated this frame.
/// @param   binding

function input_mouse_check_released(_binding)
{    
    if (!global.__input_mouse_allowed_on_platform || global.__input_cleared)
    {
        return false;
    }
    
    var _released_button = device_mouse_check_button_released(0, _binding);    
    if ((os_type == os_windows) && _released_button)
    {
        //Windows uses the touch as well, test physical mouse first 
        return true;
    }
    
    if (__INPUT_TOUCH_SUPPORT)
    {
        //Extended buttons only report on first index
        var _extended_release = (device_mouse_check_button_released(0, mb_any) && !device_mouse_check_button_released(0, mb_left));
            
        switch (_binding)
        {
            case mb_left: return   global.__input_pointer_released; break;
            case mb_any:  return  (global.__input_pointer_released || _extended_release); break;
            case mb_none: return !(global.__input_pointer_released || _extended_release); break;
        }
    }

    return _released_button;
}
