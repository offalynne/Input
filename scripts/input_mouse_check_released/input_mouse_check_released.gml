/// @desc    Returns whether the given mouse button is newly deactivated this frame.
/// @param   binding

function input_mouse_check_released(_binding)
{    
    if (!global.__input_mouse_allowed_on_platform || global.__input_window_focus_block_mouse)
    {
        return (_binding == mb_none);
    }
    
    if not ((_binding == mb_left) || (_binding == mb_any) || (_binding == mb_none))
    {
        //Extended mouse buttons
        return device_mouse_check_button_released(0, _binding);
    }
    
    var _left = false;
    if (global.__input_pointer_index > 0)
    {
        //Touch
        _left = global.__input_pointer_released;
    }
    else
    {
        //Mouse and touchpad
        _left = device_mouse_check_button_released(0, mb_left) && !global.__input_tap_click;
    }
    
    switch(_binding)
    {
        case mb_none: return !_left && device_mouse_check_button_released(0, mb_none); break;
        case mb_any:  return  _left || device_mouse_check_button_released(0, mb_any);  break;
        case mb_left: return  _left;                                                   break;
    }
        
    __input_error("Mouse button out of range (", _binding, ")");
    return false;
}
