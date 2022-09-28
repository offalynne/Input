/// @desc    Returns whether the given mouse button is newly activated this frame.
/// @param   binding

function input_mouse_check_pressed(_binding)
{    
    if (!global.__input_mouse_allowed_on_platform || global.__input_window_focus_block_mouse || global.__input_cleared)
    {
        return (_binding == mb_none);
    }
    
    //Extended mouse button handling
    if (os_type == os_windows)
    {
        var _left = (device_mouse_check_button_pressed(0, mb_left) || global.__input_tap_click);
        var _any  = (_left || (device_mouse_check_button_pressed(0, mb_any) && !device_mouse_check_button_pressed(0, mb_left)));

        switch (_binding)
        {
            case mb_right:
            case mb_middle:
            case mb_side1:
            case mb_side2: return device_mouse_check_button_pressed(0, _binding); break;
            case mb_any:   return _any;  break;
            case mb_none:  return !_any; break;
            case mb_left:  return _left; break;
        }
    }
    else
    {
        if (__INPUT_TOUCH_SUPPORT)
        {
            //Extended buttons only report on first index
            var _extended_press = (device_mouse_check_button_pressed(0, mb_any) && !device_mouse_check_button_pressed(0, mb_left));
            
            switch (_binding)
            {
                case mb_left: return   global.__input_pointer_pressed; break;
                case mb_any:  return  (global.__input_pointer_pressed || _extended_press); break;
                case mb_none: return !(global.__input_pointer_pressed || _extended_press); break;
            }
        }

        return (device_mouse_check_button_pressed(0, _binding));   
    }

    __input_error("Mouse button out of range (", _binding, ")");
    return false;
}
