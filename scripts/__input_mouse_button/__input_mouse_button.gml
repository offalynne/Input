function __input_mouse_button()
{
    if (!global.__input_mouse_allowed_on_platform || global.__input_window_focus_block_mouse)
    {
        return mb_none;
    }
    
    //Built-in variable where it reports correctly
    if (__INPUT_ON_DESKTOP && !__INPUT_ON_WEB)
    {
        return (mouse_button ? mouse_button : global.__input_tap_click);
    }
    else
    {
        //Extended mouse buttons (first device index only)
        var _i = mb_side2;
        repeat(mb_side2 - mb_left)
        {
            if (device_mouse_check_button(0, _i))
            {
                return _i;
            }
            
            --_i;
        }
        
        //Active pointer index
        return (device_mouse_check_button(global.__input_pointer_index, mb_left) ? mb_left : mb_none);
    }
}
