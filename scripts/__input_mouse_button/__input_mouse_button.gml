function __input_mouse_button()
{    
    //Built-in variable `mouse_button` reports correctly on desktop-native
    if (__INPUT_ON_DESKTOP && (!__INPUT_ON_WEB))
    {
        return (mouse_button ? mouse_button : global.__input_tap_click);
    }
    else
    {
        //Mouse buttons always report correctly on first index via `device_...` functions
        var _i = 5;
        repeat(_i)
        {
            if device_mouse_check_button(0, _i) return _i;
            _i--;
        }
    
        return global.__input_tap_click;
    }
}
