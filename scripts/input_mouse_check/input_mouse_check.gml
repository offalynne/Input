/// @desc    Returns whether the given mouse button is currently activated.
/// @param   binding

function input_mouse_check(_binding)
{ 
    if (!global.__input_mouse_allowed_on_platform || global.__input_window_focus_block_mouse)
    {
        return (_binding == mb_none);
    }
    
    if not ((_binding == mb_left) || (_binding == mb_any) || (_binding == mb_none))
    {
        //Extended mouse buttons
        return device_mouse_check_button(0, _binding);
    }
    
    var _left = false;
    if (global.__input_pointer_index > 0)
    {
        //Touch
        _left = device_mouse_check_button(global.__input_pointer_index, mb_left);
    }
    else
    {
        //Mouse and touchpad
        _left = device_mouse_check_button(0, mb_left) || global.__input_tap_click;
    }
    
    switch(_binding)
    {
        case mb_none: return !_left && device_mouse_check_button(0, mb_none); break;
        case mb_any:  return  _left || device_mouse_check_button(0, mb_any);  break;
        case mb_left: return  _left;                                          break;
    }
        
    __input_error("Mouse button out of range (", _binding, ")");
    return false;
}
