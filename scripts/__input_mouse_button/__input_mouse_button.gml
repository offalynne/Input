function __input_mouse_button()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!_global.__mouse_allowed || _global.__window_focus_block_mouse)
    {
        //Mouse not alllowed
        return mb_none;
    }
    
    if (_global.__pointer_index > 0)
    {
        if (device_mouse_check_button(_global.__pointer_index, mb_left))
        {
            //Touch
            return mb_left;
        }
    }
    else if (INPUT_ON_PC && !INPUT_ON_WEB)
    {
        //Desktop native
        if (mouse_button != mb_none)
        {
            //Mouse
            return mouse_button;
        }

        if (_global.__tap_click)
        {
            //Trackpad
            return mb_left;
        }
    }
    else
    {
        //Web and non-desktop mouse
        if (device_mouse_check_button(0, mb_side2))  return mb_side2;
        if (device_mouse_check_button(0, mb_side1))  return mb_side1;
        if (device_mouse_check_button(0, mb_middle)) return mb_middle;
        if (device_mouse_check_button(0, mb_right))  return mb_right;
        if (device_mouse_check_button(0, mb_left))   return mb_left;
    }
    
    return mb_none;
}
