// Feather disable all
/// @desc Detect change in window
function __input_window_changed()
{
    static _fullscreen_last    = window_get_fullscreen();
    static _window_x_last      = window_get_x();
    static _window_y_last      = window_get_y();
    static _window_width_last  = window_get_width();
    static _window_height_last = window_get_height();
    
    var _fullscreen    = window_get_fullscreen();
    var _window_x      = window_get_x();
    var _window_y      = window_get_y();
    var _window_width  = window_get_width();
    var _window_height = window_get_height();
    
    if (_fullscreen && !_fullscreen_last)
    {
        _window_x_last      = _window_x;
        _window_y_last      = _window_y;
        _window_width_last  = _window_width;
        _window_height_last = _window_height;
        
        return false;
    }
    
    _fullscreen_last = _fullscreen;
    
    if ((_window_width  == _window_width_last)
    &&  (_window_height == _window_height_last)
    &&  (_window_x      == _window_x_last)
    &&  (_window_y      == _window_y_last))
    {
        return false;
    }
    
    _window_x_last      = _window_x;
    _window_y_last      = _window_y;
    _window_width_last  = _window_width;
    _window_height_last = _window_height;
    
    return true;
}
