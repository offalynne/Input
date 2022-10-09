function __input_mouse_button()
{
    var _touch_button = (device_mouse_check_button(global.__input_pointer_index, mb_left) ? mb_left : mb_none);
    
    if (!global.__input_mouse_allowed_on_platform || global.__input_window_focus_block_mouse)
    {
        //Mouse not alllowed
        return mb_none;
    }
    
    if (__INPUT_ON_DESKTOP && !__INPUT_ON_WEB)
    {
        if ((global.__input_pointer_index > 0))
        {
            //Touch
            return _touch_button;
        }
        else
        {
            if (mouse_button != mb_none)
            {
                //Mouse
                return mouse_button;
            }
            
            if (global.__input_tap_click)
            {
                //Trackpad
                return (? mb_left : mb_none);
            }
        }
    }
    else
    {
        var _i = mb_side2;
        repeat(mb_side2 - mb_left)
        {
            if (device_mouse_check_button(0, _i))
            {
                //Extended mouse buttons (first index only)
                return _i;
            }
            
            --_i;
        }
        
        //Active pointer index
        return _touch_button;
    }
}
