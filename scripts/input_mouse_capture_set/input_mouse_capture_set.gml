/// @desc    Whether to capture the mouse in the game window, and its movement speed for Input's built-in mouse tracking
/// @param   state
/// @param   [sensitivity=1]

function input_mouse_capture_set(_state, _sensitivity = 1)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    static _monitor_coords       = undefined; 
    static _monitor_update_frame = -infinity;
    
    if (!INPUT_ON_PC || INPUT_ON_WEB)
    {
        if (__INPUT_DEBUG_CAPTURE) __input_trace("Mouse capture unsupported for this platform");
        return;
    }
    
    if (_state) _global.__mouse_capture_frame = _global.__frame;
    
    _global.__mouse_capture             = _state;
    _global.__mouse_capture_sensitivity = _sensitivity;
    _global.__mouse_capture_blocked     = false;
    
    if (!_state || window_get_fullscreen()) return;

    var _window_width  = window_get_width();
    var _window_height = window_get_height();
    var _window_x      = window_get_x();
    var _window_y      = window_get_y();
    
    switch(os_type)
    {
        case os_windows: //Window area intersecting the border on any monitor invalidates mouse capture position
            if (_monitor_update_frame < _global.__frame)
            {
                _monitor_update_frame = _global.__frame;
                _monitor_coords = window_get_visible_rects(_window_x, _window_y, _window_x + _window_width, _window_y + _window_height);
            }
            
            var _i = 0;
            repeat((array_length(_monitor_coords) div 8))
            {
                if  ((_monitor_coords[_i*8 + 2] != 0) //W=0 is identity for "not on this monitor"
                &&   (_monitor_coords[_i*8 + 3] != 0) //H=0 is identity for "not on this monitor"
                && (((_monitor_coords[_i*8 + 2] - _monitor_coords[_i*8])    != _window_width)    //Intersects a horizontal edge
                  || (_monitor_coords[_i*8 + 3] - _monitor_coords[_i*8 + 1] != _window_height))) //Intersects a vertical edge
                {
                    if (__INPUT_DEBUG_CAPTURE) __input_trace("Window exceeds display bounds on monitor ", _i + 1, ", mouse capture blocked");
                    _global.__mouse_capture_blocked = true;
                    return;
                }
        
                ++_i;
            }
        break;
        
        case os_macosx: //Window area bordering or outside the primary monitor invalidates mouse capture position
            if (_monitor_update_frame < _global.__frame)
            {
                _monitor_update_frame = _global.__frame;
                _monitor_coords = window_get_visible_rects(_window_x, _window_y, _window_x + _window_width, _window_y + _window_height);
            }
            
            if (((_monitor_coords[2] - _monitor_coords[0]) != _window_width)   //Intersects a horizontal edge
              || (_monitor_coords[3] - _monitor_coords[1]  != _window_height)) //Intersects a vertical edge
            {
                if (__INPUT_DEBUG_CAPTURE) __input_trace("Window exceeds display bounds on primary monitor, mouse capture blocked");
                _global.__mouse_capture_blocked = true;
                return;
                
            }           
        break;
        
        case os_linux: //No window_get_visible_rect() values but we can test top left and primary monitor intersection
            if (((_window_x < 0) || (_window_y < 0)) //Negative values are always out of bounds
             || ((_window_x < display_get_width())  && (_window_x + _window_width  > display_get_width()))   //Primary horizontal edge
             || ((_window_y < display_get_height()) && (_window_y + _window_height > display_get_height()))) //Primary vertical edge
            {
                if (__INPUT_DEBUG_CAPTURE) __input_trace("Window exceeds display bounds, mouse capture blocked");
                _global.__mouse_capture_blocked = true;
                return;
            }            
        break;
    }
}
