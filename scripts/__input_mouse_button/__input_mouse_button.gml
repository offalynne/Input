function __input_mouse_button()
{
    if (!global.__input_mouse_allowed_on_platform || global.__input_window_focus_block_mouse)
    {
        //Mouse not alllowed
        return mb_none;
    }
    
    if (global.__input_pointer_index > 0)
    {
        if (device_mouse_check_button(global.__input_pointer_index, mb_left))
        {
            //Touch
            return mb_left;
        }
    }
    else if (__INPUT_ON_DESKTOP && !__INPUT_ON_WEB)
    {
        //Desktop native
        if (mouse_button != mb_none)
        {
            //Mouse
            return mouse_button;
        }

        if (global.__input_tap_click)
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
