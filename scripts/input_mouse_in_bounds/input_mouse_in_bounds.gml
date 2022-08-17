/// @desc    Returns whether the mouse is inside the window bounds

function input_mouse_in_bounds()
{
    if (os_type == os_windows)
    {
        var _mx = display_mouse_get_x() - window_get_x();
        var _my = display_mouse_get_y() - window_get_y();  
    }
    else
    {
        var _mx = device_mouse_raw_x(global.__input_pointer_index);
        var _my = device_mouse_raw_y(global.__input_pointer_index);
    }
    
    return !((_mx < 0) || (_mx >= window_get_width()) || (_my < 0) || (_my >= window_get_height()));
}