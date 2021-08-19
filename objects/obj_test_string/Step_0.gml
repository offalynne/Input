input_tick();

if (input_mouse_check_pressed(mb_any))
{
    var _x = device_mouse_x(0);
    if (device_mouse_y(0) < 300)
    {
        if (_x < (room_width/2))
        {
            keyboard_virtual_show(kbv_type_default, kbv_returnkey_default, kbv_autocapitalize_none, false);
        }
        else
        {
            keyboard_virtual_hide();
        }
    }
    else
    {
        switch(_x == 0 ? 0 : _x div (room_width/3))
        {
            case 0: input_string_set(long_string);  break;
            case 1: input_string_set();             break;            
            case 2: input_string_async_get("test"); break;            
        }
    }
}