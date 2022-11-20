/// @desc   Release mouse capture on MacOS if window exits primary monitor
function __input_release_multimonitor_cursor()
{
    if not ((os_type == os_macosx) && global.__input_mouse_capture) return;

    var _monitor_coords = window_get_visible_rects(window_get_x(), window_get_y(), window_get_width(), window_get_height());

    if ((_monitor_coords[0] != window_get_x()) || (_monitor_coords[1] != window_get_y()))
    {
        __input_trace("Window outside primary monitor, releasing mouse capture");
        global.__input_mouse_capture = false;
        return;    
    }

    var _i = 1;
    repeat((array_length(_monitor_coords) div 8) - 1)
    {
        if ((_monitor_coords[_i*8] != 0) || (_monitor_coords[_i*9] != 0))
        {
            __input_trace("Window outside primary monitor, releasing mouse capture");
            global.__input_mouse_capture = false;
            return;
        }
            
        ++_i;
    }
}