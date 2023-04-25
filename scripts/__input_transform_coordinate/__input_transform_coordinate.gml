/// @param x
/// @param y
/// @param inputSystem
/// @param outputSystem
/// @param [camera]

//Precache the app surface draw parameters
__input_transform_coordinate(0, 0, 2, 2, undefined);

function __input_transform_coordinate(_x, _y, _input_system, _output_system, _camera = undefined)
{
    static _result = {
        x: 0,
        y: 0,
    };
    
    //Build out lots of cached values
    //We use these to detect changes that might trigger a recalculation of application_get_position()
    //Doing all this work is faster than calling application_get_position() all the time
    static _windowW      = undefined;
    static _windowH      = undefined;
    static _appSurfW     = undefined;
    static _appSurfH     = undefined;
    static _appSurfDrawL = undefined;
    static _appSurfDrawT = undefined;
    static _appSurfDrawW = undefined;
    static _appSurfDrawH = undefined;
    static _recacheTime  = -infinity;
    
    if (_input_system != _output_system) //Only do MATHS if the output system is different
    {
        //Unpack the camera's properties if we're working in room-space at any point
        if ((_input_system == 0) || (_output_system == 0))
        {
            //If we have no defined camera then try to use view 0's camera
            if ((_camera == undefined) && view_enabled && view_visible[0]) _camera = view_camera[0];
            
            if (_camera != undefined)
            {
                var _viewX = camera_get_view_x(     _camera);
                var _viewY = camera_get_view_y(     _camera);
                var _viewW = camera_get_view_width( _camera);
                var _viewH = camera_get_view_height(_camera);
                var _viewA = camera_get_view_angle( _camera);
            }
            else
            {
                //Fall back on the room's dimensions
                var _viewX = 0;
                var _viewY = 0;
                var _viewW = room_width;
                var _viewH = room_height;
                var _viewA = 0;
            }
        }
        
        //Only update the cached app surface draw parameters if we're going to need them
        if ((_input_system == 2) || (_output_system == 2))
        {
            //Detect changes in application surface size
            if ((_appSurfW != surface_get_width(application_surface))
            ||  (_appSurfH != surface_get_height(application_surface)))
            {
                _appSurfW = surface_get_width(application_surface);
                _appSurfH = surface_get_height(application_surface);
            
                //Recache application surface position immediately in this situation
                _recacheTime = -infinity;
            }
            
            if (current_time > _recacheTime)
            {
                _recacheTime = infinity;
                
                var _array = application_get_position();
                _appSurfDrawL = _array[0];
                _appSurfDrawT = _array[1];
                _appSurfDrawW = _array[2] - _appSurfDrawL;
                _appSurfDrawH = _array[3] - _appSurfDrawT;
            }
            
            //Detect changes in window size
            if ((_windowW != window_get_width())
            ||  (_windowH != window_get_height()))
            {
                _windowW = window_get_width();
                _windowH = window_get_height();
                
                //Recache application surface position after 200ms to give GM time to do whatever it does
                _recacheTime = current_time + 200;
            }
        }
        
        if (_input_system == 0) //Input coordinate system is room-space
        {
            if (_viewA == 0) //Skip expensive rotation step if we can
            {
                //Reduce x/y to normalised values in the viewport
                _x = (_x - _viewX) / _viewW;
                _y = (_y - _viewY) / _viewH;
            }
            else
            {
                //Perform a rotation, eventually ending up with normalised values as above
                _viewX += _viewW/2;
                _viewY += _viewH/2;
                
                var _sin = dsin(-_viewA);
                var _cos = dcos(-_viewA);
                
                var _x0 = _x - _viewX;
                var _y0 = _y - _viewY;
                _x = ((_x0*_cos - _y0*_sin) + _viewX) / _viewW;
                _y = ((_x0*_sin + _y0*_cos) + _viewY) / _viewH;
            }
            
            if (_output_system == 1)
            {
                //If we're outputting to GUI-space then simply multiply up by the GUI size
                _x *= display_get_gui_width();
                _y *= display_get_gui_height();
            }
            else if (_output_system == 2)
            {
                //If we're outputting to device-space then perform a transform using the cached app surface draw parameters
                _x = _appSurfDrawW*_x + _appSurfDrawL;
                _y = _appSurfDrawH*_y + _appSurfDrawT;
            }
            else
            {
                __input_error("Unhandled output coordinate system (", _output_system, ")");
            }
        }
        else if (_input_system == 1) //Input coordinate system is GUI-space
        {
            //Reduce x/y to normalised values in GUI-space
            _x /= display_get_gui_width();
            _y /= display_get_gui_height();
            
            if (_output_system == 0)
            {
                if (_viewA == 0) //Skip expensive rotation step if we can
                {
                    //Expand room-space x/y from normalised values in the viewport
                    _x = _viewW*_x + _viewX;
                    _y = _viewH*_y + _viewY;
                }
                else
                {
                    //Perform a rotation, eventually ending up with room-space coordinates as above
                    _viewX += _viewW/2;
                    _viewY += _viewH/2;
                    
                    var _sin = dsin(_viewA);
                    var _cos = dcos(_viewA);
                    
                    var _x0 = _x*_viewW - _viewX;
                    var _y0 = _y*_viewH - _viewY;
                    _x = (_x0*_cos - _y0*_sin) + _viewX;
                    _y = (_x0*_sin + _y0*_cos) + _viewY;
                }
            }
            else if (_output_system == 2)
            {
                //If we're outputting to device-space then perform a transform using the cached app surface draw parameters
                _x = _appSurfDrawW*_x + _appSurfDrawL;
                _y = _appSurfDrawH*_y + _appSurfDrawT;
            }
            else
            {
                __input_error("Unhandled output coordinate system (", _output_system, ")");
            }
        }
        else if (_input_system == 2) //Input coordinate system is device-space
        {
            _x = (_x - _appSurfDrawL) / _appSurfDrawW;
            _y = (_y - _appSurfDrawT) / _appSurfDrawH;
            
            if (_output_system == 1)
            {
                //Reduce x/y to normalised values in GUI-space
                _x *= display_get_gui_width();
                _y *= display_get_gui_height();
            }
            else if (_output_system == 0)
            {
                if (_viewA == 0) //Skip expensive rotation step if we can
                {
                    //Expand room-space x/y from normalised values in the viewport
                    _x = _viewW*_x + _viewX;
                    _y = _viewH*_y + _viewY;
                }
                else
                {
                    //Perform a rotation, eventually ending up with room-space coordinates as above
                    _viewX += _viewW/2;
                    _viewY += _viewH/2;
                    
                    var _sin = dsin(_viewA);
                    var _cos = dcos(_viewA);
                    
                    var _x0 = _x*_viewW - _viewX;
                    var _y0 = _y*_viewH - _viewY;
                    _x = (_x0*_cos - _y0*_sin) + _viewX;
                    _y = (_x0*_sin + _y0*_cos) + _viewY;
                }
            }
            else
            {
                __input_error("Unhandled output coordinate system (", _output_system, ")");
            }
        }
        else
        {
            __input_error("Unhandled input coordinate system (", _input_system, ")");
        }
    }
    
    //Set values and return!
    _result.x = _x;
    _result.y = _y;
    return _result;
}