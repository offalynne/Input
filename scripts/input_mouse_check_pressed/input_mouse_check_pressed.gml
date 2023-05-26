/// @desc    Returns whether the given mouse button is newly activated this frame.
/// @param   binding

function input_mouse_check_pressed(_binding)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!_global.__mouse_allowed || _global.__window_focus_block_mouse)
    {
        return (_binding == mb_none);
    }
    
    if not ((_binding == mb_left) || (_binding == mb_any) || (_binding == mb_none))
    {
        //Extended mouse buttons
        return device_mouse_check_button_pressed(0, _binding);
    }
    
    var _left = false;
    if (_global.__mouse_allowed)
    {
        //Mouse and touchpad
        _left = device_mouse_check_button_pressed(0, mb_left) || _global.__tap_click;
    }
    else if (_global.__touch_allowed)
    {
        //Touch
        _left = _global.__pointer_pressed;
    }
    
    switch(_binding)
    {
        case mb_none: return !_left && device_mouse_check_button_pressed(0, mb_none); break;
        case mb_any:  return  _left || device_mouse_check_button_pressed(0, mb_any);  break;
        case mb_left: return  _left;                                                  break;
    }
        
    __input_error("Mouse button out of range (", _binding, ")");
    return false;
}
