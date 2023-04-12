/// @desc    Whether to capture the mouse in the game window, and its movement speed for Input's built-in mouse tracking
/// @param   state
/// @param   [sensitivity=1]

function input_mouse_capture_set(_state, _sensitivity = 1)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!__INPUT_ON_DESKTOP || __INPUT_ON_WEB)
    {
        __input_trace("Mouse capture unsupported for this platform");
        return;
    }
    
    if (_state && !_global.__mouse_capture) _global.__mouse_capture_frame = _global.__frame;
    
    _global.__mouse_capture             = _state;
    _global.__mouse_capture_sensitivity = _sensitivity;
    
    if (window_get_fullscreen()) return;

    var _window_width  = window_get_width();
    var _window_height = window_get_height();
    var _window_x      = window_get_x();
    var _window_y      = window_get_y();
    
    switch(os_type)
    {
        case os_windows: //Window area exceeding the border on any monitor invalidates mouse capture position
            var _i = 0;
            var _monitor_coords = window_get_visible_rects(_window_x, _window_y, _window_x + _window_width, _window_y + _window_height);
            repeat((array_length(_monitor_coords) div 8))
            {
                if  ((_monitor_coords[_i*8 + 2] != 0) //W=0 is identity for "not on this monitor"
                &&   (_monitor_coords[_i*8 + 3] != 0) //H=0 is identity for "not on this monitor"
                && (((_monitor_coords[_i*8 + 2] - _monitor_coords[_i*8])    != _window_width)    //Intersects a horizontal edge
                  || (_monitor_coords[_i*8 + 3] - _monitor_coords[_i*8 + 1] != _window_height))) //Intersects a vertical edge
                {
                    __input_trace("Window exceeds display bounds on monitor ", _i + 1, ", mouse capture not enabled");
                    _global.__mouse_capture = false;
                    return;
                }
        
                ++_i;
            }
        break;
        
        case os_macosx: //Any change of active monitor invalidates mouse capture position
            var _monitor_coords = window_get_visible_rects(_window_x, _window_y, _window_x + _window_width, _window_y + _window_height);
            if ((_monitor_coords[0] != _window_x) || (_monitor_coords[1] != _window_y))
            {
                __input_trace("Window origin is outside primary monitor, mouse capture not enabled");
                _global.__mouse_capture = false;
                return;
            }
        
            var _i = 1;
            repeat((array_length(_monitor_coords) div 8) - 1)
            {
                if ((_monitor_coords[_i*8 + 2] != 0) || (_monitor_coords[_i*8 + 3] != 0))
                {
                    __input_trace("Window bounds occupy area outside primary monitor, mouse capture not enabled");
                    _global.__mouse_capture = false;
                    return;
                }            
                ++_i;
            }
        break;
        
        case os_linux: //No window_get_visible_rect() values but we can still test top left and primary monitor edges
            if (((_window_x < 0) || (_window_y < 0)) //Negative values are always out of bounds
             || ((_window_x < display_get_width())  && (_window_x + _window_width  > display_get_width()))   //Primary horizontal edge
             || ((_window_y < display_get_height()) && (_window_y + _window_height > display_get_height()))) //Primary vertical edge
            {
                __input_trace("Window exceeds display bounds, mouse capture not enabled");
                _global.__mouse_capture = false;
                return;
            }            
        break;
    }
}
