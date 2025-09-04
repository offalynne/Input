// Feather disable all

/// @param playerIndex

function __InputCursorClassPlayer(_playerIndex) constructor
{
    static _system = __InputCursorSystem();
    
    __playerIndex = _playerIndex;
    
    __speed = INPUT_CURSOR_DEFAULT_SPEED;
    
    __x     = 0;
    __y     = 0;
    __prevX = 0;
    __prevY = 0;
    
    __elasticX        = undefined;
    __elasticY        = undefined;
    __elasticStrength = 0;
    
    __limitType   = INPUT_CURSOR_LIMIT_NONE;
    __limitX      = undefined;
    __limitY      = undefined;
    __limitRadius = undefined;
    __limitLeft   = undefined;
    __limitTop    = undefined;
    __limitRight  = undefined;
    __limitBottom = undefined;
    __limitMargin = undefined;
    
    static __Update = function()
    {
        __prevX = __x;
        __prevY = __y;
        
        var _nextX = __x;
        var _nextY = __y;
        var _playerIndex = __playerIndex;
        
        if (INPUT_CURSOR_MOUSE_CONTROL && InputPlayerUsingKbm(_playerIndex))
        {
            if (INPUT_CURSOR_PRIMARY_COORD_SPACE == INPUT_CURSOR_ROOM_SPACE)
            {
                _nextX = InputMouseRoomX();
                _nextY = InputMouseRoomY();
            }
            else if (INPUT_CURSOR_PRIMARY_COORD_SPACE == INPUT_CURSOR_GUI_SPACE)
            {
                _nextX = InputMouseGuiX();
                _nextY = InputMouseGuiY();
            }
            else if (INPUT_CURSOR_PRIMARY_COORD_SPACE == INPUT_CURSOR_DEVICE_SPACE)
            {
                _nextX = InputMouseDeviceX();
                _nextY = InputMouseDeviceY();
            }
        }
        else
        {
            var _dX = InputX(INPUT_CURSOR_CLUSTER, _playerIndex);
            var _dY = InputY(INPUT_CURSOR_CLUSTER, _playerIndex);
            
            if (INPUT_CURSOR_EXPONENT != 1)
            {
                var _coeff = power(point_distance(0, 0, _dX, _dY), INPUT_CURSOR_EXPONENT);
                _nextX += __speed*_coeff*_dX;
                _nextY += __speed*_coeff*_dY;
            }
            else
            {
                _nextX += __speed*_dX;
                _nextY += __speed*_dY;
            }
            
            if (__elasticStrength > 0)
            {
                //Scale up movement so that even with elastic mode on the cursor has a full range of motion
                _nextX += (_nextX - __prevX) / __elasticStrength;
                _nextY += (_nextY - __prevY) / __elasticStrength;
                
                //The oldies are usually the goodies
                _nextX = lerp(_nextX, __elasticX, __elasticStrength);
                _nextY = lerp(_nextY, __elasticY, __elasticStrength);
            }
        }
        
        __x = _nextX;
        __y = _nextY;
        
        __Limit();
    }
    
    static __Limit = function()
    {
        var _x = __x;
        var _y = __y;
        
        if (__limitType == INPUT_CURSOR_LIMIT_CIRCLE)
        {
            var _dx = _x - __limitX;
            var _dy = _y - __limitY;
            var _d  = sqrt(_dx*_dx + _dy*_dy);
            
            if ((_d > 0) && (_d > __limitRadius))
            {
                _d = __limitRadius / _d;
                _x = __limitX + _d*_dx;
                _y = __limitY + _d*_dy;
            }
        }
        else if (__limitType == INPUT_CURSOR_LIMIT_AABB)
        {
            _x = clamp(_x, __limitLeft, __limitRight);
            _y = clamp(_y, __limitTop, __limitBottom);
        }
        else if (__limitType == INPUT_CURSOR_LIMIT_BOUNDARY)
        {
            if (INPUT_CURSOR_PRIMARY_COORD_SPACE == INPUT_CURSOR_ROOM_SPACE)
            {
                var _camera = (view_enabled && view_visible[0])? view_camera[0] : undefined;
                if (_camera != undefined)
                {
                    var _l = camera_get_view_x(_camera);
                    var _t = camera_get_view_y(_camera);
                    var _r = _l + camera_get_view_width( _camera)-1;
                    var _b = _t + camera_get_view_height(_camera)-1;
                    
                    var _viewA = camera_get_view_angle(_camera);
                    
                    if (_viewA != 0.0)
                    {
                        var _pivotX = (_l + _r)/2
                        var _pivotY = (_t + _b)/2                            
                        var _cos = dcos(-_viewA);
                        var _sin = dsin(-_viewA);
                        
                        var _rotatedX = (_x - _pivotX)*_cos - (_y - _pivotY)*_sin
                        var _rotatedY = (_x - _pivotX)*_sin + (_y - _pivotY)*_cos
                        
                        _rotatedX = clamp(_rotatedX, _l + __limitMargin - _pivotX, _r - __limitMargin - _pivotX);
                        _rotatedY = clamp(_rotatedY, _t + __limitMargin - _pivotY, _b - __limitMargin - _pivotY);
                        
                        __x =  _rotatedX*_sin + _rotatedY*_cos + _pivotX;
                        __y = -_rotatedX*_sin + _rotatedY*_cos + _pivotY;
                        
                        //No need to apply the rest of the logic
                        return;
                    }
                }
                else
                {
                    //Fall back on the room's dimensions
                    var _l = 0;
                    var _t = 0;
                    var _r = room_width;
                    var _b = room_height;
                }
            }
            else if (INPUT_CURSOR_PRIMARY_COORD_SPACE == INPUT_CURSOR_GUI_SPACE)
            {
                var _l = 0;
                var _t = 0;
                var _r = display_get_gui_width();
                var _b = display_get_gui_height();
            }
            else if (INPUT_CURSOR_PRIMARY_COORD_SPACE == INPUT_CURSOR_DEVICE_SPACE)
            {
                var _l = 0;
                var _t = 0;
                var _r = window_get_width()
                var _b = window_get_height();
            }
            
            _x = clamp(_x, _l + __limitMargin, _r - __limitMargin);
            _y = clamp(_y, _t + __limitMargin, _b - __limitMargin);
        }
        
        __x = _x;
        __y = _y;
    }
}