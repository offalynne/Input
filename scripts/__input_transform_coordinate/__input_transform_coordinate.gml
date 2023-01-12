/// @param x
/// @param y
/// @param inputSystem
/// @param outputSystem
/// @param [camera]

function __input_transform_coordinate(_x, _y, _inputSystem, _outputSystem, _camera = undefined)
{
    static _result = {};
    
    static _windowW  = undefined;
    static _windowH  = undefined;
    static _appSurfL = undefined;
    static _appSurfT = undefined;
    static _appSurfW = undefined;
    static _appSurfH = undefined;
    static _recacheTime = -infinity;
    
    if (current_time > _recacheTime)
    {
        _recacheTime = infinity;
        
        var _array = application_get_position();
        _appSurfL = _array[0];
        _appSurfT = _array[1];
        _appSurfW = _array[2] - _appSurfL;
        _appSurfH = _array[3] - _appSurfT;
    }
    
    if ((_windowW != window_get_width()) || (_windowH != window_get_height()))
    {
        _windowW = window_get_width();
        _windowH = window_get_height();
        
        //Recache application surface position after 200ms
        _recacheTime = current_time + 200;
    }
    
    switch(_inputSystem)
    {
        case 0:
            if (_outputSystem != 0)
            {
                _camera = _camera ?? camera_get_active();
                if (_camera < 0) _camera = view_camera[0];
                
                if (camera_get_view_angle(_camera) == 0)
                {
                    _x = (_x - camera_get_view_x(_camera)) / camera_get_view_width( _camera);
                    _y = (_y - camera_get_view_y(_camera)) / camera_get_view_height(_camera);
                }
                else
                {
                    var _viewW  = camera_get_view_width( _camera);
                    var _viewH  = camera_get_view_height(_camera);
                    var _viewCX = camera_get_view_x(_camera) + _viewW/2;
                    var _viewCY = camera_get_view_y(_camera) + _viewH/2;
                    
                    var _angle = camera_get_view_angle(_camera);
                    var _sin = dsin(-_angle);
                    var _cos = dcos(-_angle);
                    
                    var _x0 = _x - _viewCX;
                    var _y0 = _y - _viewCY;
                    _x = ((_x0*_cos - _y0*_sin) + _viewCX) / _viewW;
                    _y = ((_x0*_sin + _y0*_cos) + _viewCY) / _viewH;
                }
                
                if (_outputSystem == 1)
                {
                    _x *= display_get_gui_width();
                    _y *= display_get_gui_height();
                }
                else if (_outputSystem == 2)
                {
                    _x = _appSurfW*_x + _appSurfL;
                    _y = _appSurfH*_y + _appSurfT;
                }
                else
                {
                    show_error("Unhandled output coordinate system (" + string(_outputSystem) + ")\n ", true);
                }
            }
        break;
        
        case 1:
            if (_outputSystem != 1)
            {
                _x /= display_get_gui_width();
                _y /= display_get_gui_height();
                
                if (_outputSystem == 0)
                {
                    _camera = _camera ?? camera_get_active();
                    if (_camera < 0) _camera = view_camera[0];
                    
                    if (camera_get_view_angle(_camera) == 0)
                    {
                        _x = camera_get_view_width( _camera)*_x + camera_get_view_x(_camera);
                        _y = camera_get_view_height(_camera)*_y + camera_get_view_y(_camera);
                    }
                    else
                    {
                        var _viewW  = camera_get_view_width( _camera);
                        var _viewH  = camera_get_view_height(_camera);
                        var _viewCX = camera_get_view_x(_camera) + _viewW/2;
                        var _viewCY = camera_get_view_y(_camera) + _viewH/2;
                        
                        var _angle = camera_get_view_angle(_camera);
                        var _sin = dsin(_angle);
                        var _cos = dcos(_angle);
                        
                        var _x0 = _x*_viewW - _viewCX;
                        var _y0 = _y*_viewH - _viewCY;
                        _x = (_x0*_cos - _y0*_sin) + _viewCX;
                        _y = (_x0*_sin + _y0*_cos) + _viewCY;
                    }
                }
                else if (_outputSystem == 2)
                {
                    _x = _appSurfW*_x + _appSurfL;
                    _y = _appSurfH*_y + _appSurfT;
                }
                else
                {
                    show_error("Unhandled output coordinate system (" + string(_outputSystem) + ")\n ", true);
                }
            }
        break;
        
        case 2:
            if (_outputSystem != 2)
            {
                _x = (_x - _appSurfL) / _appSurfW;
                _y = (_y - _appSurfT) / _appSurfH;
                
                if (_outputSystem == 1)
                {
                    _x *= display_get_gui_width();
                    _y *= display_get_gui_height();
                }
                else if (_outputSystem == 0)
                {
                    _camera = _camera ?? camera_get_active();
                    if (_camera < 0) _camera = view_camera[0];
                    
                    if (camera_get_view_angle(_camera) == 0)
                    {
                        _x = camera_get_view_width( _camera)*_x + camera_get_view_x(_camera);
                        _y = camera_get_view_height(_camera)*_y + camera_get_view_y(_camera);
                    }
                    else
                    {
                        var _viewW  = camera_get_view_width( _camera);
                        var _viewH  = camera_get_view_height(_camera);
                        var _viewCX = camera_get_view_x(_camera) + _viewW/2;
                        var _viewCY = camera_get_view_y(_camera) + _viewH/2;
                        
                        var _angle = camera_get_view_angle(_camera);
                        var _sin = dsin(_angle);
                        var _cos = dcos(_angle);
                        
                        var _x0 = _x*_viewW - _viewCX;
                        var _y0 = _y*_viewH - _viewCY;
                        _x = (_x0*_cos - _y0*_sin) + _viewCX;
                        _y = (_x0*_sin + _y0*_cos) + _viewCY;
                    }
                }
                else
                {
                    show_error("Unhandled output coordinate system (" + string(_outputSystem) + ")\n ", true);
                }
            }
        break;
        
        default:
            show_error("Unhandled input coordinate system (" + string(_inputSystem) + ")\n ", true);
        break;
    }
    
    _result.x = _x;
    _result.y = _y;
    return _result;
}