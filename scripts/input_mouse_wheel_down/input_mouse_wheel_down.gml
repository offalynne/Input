/// @desc    Returns whether mouse wheel down is newly activated this frame.

function input_mouse_wheel_down()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if ((!_global.__window_focus && !INPUT_ALLOW_OUT_OF_FOCUS)
    ||  (!_global.__mouse_allowed || _global.__cleared))
    {
        return false;
    }
    
    return mouse_wheel_down();
}
