// Feather disable all
function __input_class_cursor() constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE  //Set static __global
    
    __player = undefined;
    
    __prev_x = 0;
    __prev_y = 0;
    __x = 0;
    __y = 0;
    
    //Limit cursor to AABB
    __limit_l = undefined;
    __limit_t = undefined;
    __limit_r = undefined;
    __limit_b = undefined;
    
    //Limit cursor to circle
    __limit_x      = undefined;
    __limit_y      = undefined;
    __limit_radius = undefined;
    
    //Limit to viewpoint
    __limit_boundary_margin = undefined;
    
    __elastic_x        = undefined;
    __elastic_y        = undefined;
    __elastic_strength = 0;
    
    //Translation
    __translation_active     = false;
    __translation_start_x    = undefined;
    __translation_start_y    = undefined;
    __translation_start_time = undefined;
    __translation_end_x      = undefined;
    __translation_end_y      = undefined;
    __translation_end_time   = undefined;
    
    __moved_time  = -infinity;
    __using_mouse = false;
    __speed       = INPUT_CURSOR_START_SPEED;
    __coord_space = INPUT_COORD_SPACE.ROOM;
    
    static __set = function(_x, _y, _relative)
    {
        if (_relative)
        {
            __x += _x;
            __y += _y;
            __prev_x += _x;
            __prev_y += _y;
        }
        else
        {
            __x = _x;
            __y = _y;
            __prev_x = _x;
            __prev_y = _y;
        }
    }
    
    static __translate = function(_x, _y, _duration, _relative)
    {
        __translation_start_x = __x;
        __translation_start_y = __y;
        
        if (_relative)
        {
            __translation_end_x = (__translation_start_x == undefined)? undefined : __translation_start_x + _x;
            __translation_end_y = (__translation_start_y == undefined)? undefined : __translation_start_y + _y;
        }
        else
        {
            __translation_end_x = _x;
            __translation_end_y = _y;
        }
        
        __translation_active     = true;
        __translation_start_time = __input_get_time();
        __translation_end_time   = __translation_start_time + _duration;
    }
    
    static __tick = function()
    {
        __prev_x = __x;
        __prev_y = __y;
        
        var _y_inverted    = __player.__cursor_inverted? -1 : 1;
        var _can_use_mouse = (__global.__game_input_allowed && __player.__mouse_enabled && __player.__source_contains(INPUT_MOUSE)); //Automatically remapped to INPUT_TOUCH where appropriate
        
        //Mouse and touch
        if ((__global.__pointer_moved || __using_mouse) && _can_use_mouse && __global.__mouse_allowed)
        {
            __using_mouse = true;
                
            if (__global.__mouse_capture)
            {
                __x += __global.__pointer_dx[__coord_space];
                __y += __global.__pointer_dy[__coord_space]*_y_inverted;
            }
            else
            {
                __x = __global.__pointer_x[__coord_space];
                __y = __global.__pointer_y[__coord_space];
            }
        }
        
        //Don't update the cursor if the mouse recently moved or we're rebinding controls
        if (__global.__game_input_allowed
        &&  __global.__cursor_verbs_valid
        && (!__global.__pointer_moved || !_can_use_mouse) 
        && (__player.__rebind_state <= 0))
        {
            //Gyro
            if (__player.__gyro_enabled)
            {
                var _motion_data = __player.__motion_data_get();                
                if (is_struct(_motion_data))
                {
                    var _gyro_value_x = undefined;
                    switch(__player.__gyro_axis_x)
                    {
                        case INPUT_GYRO.AXIS_PITCH: _gyro_value_x = _motion_data.angular_velocity_x; break;
                        case INPUT_GYRO.AXIS_YAW:   _gyro_value_x = _motion_data.angular_velocity_y; break;
                        case INPUT_GYRO.AXIS_ROLL:  _gyro_value_x = _motion_data.angular_velocity_z; break;
                    }

                    var _gyro_value_y = undefined;
                    switch(__player.__gyro_axis_y)
                    {
                        case INPUT_GYRO.AXIS_PITCH: _gyro_value_y = _motion_data.angular_velocity_x; break;
                        case INPUT_GYRO.AXIS_YAW:   _gyro_value_y = _motion_data.angular_velocity_y; break;
                        case INPUT_GYRO.AXIS_ROLL:  _gyro_value_y = _motion_data.angular_velocity_z; break;
                    }

                    var _dts = delta_time/1000000;
                
                    //Resolution of 0.1
                    if (_gyro_value_x != undefined) __x +=  round((_gyro_value_x * _dts * __player.__gyro_screen_width  * __player.__gyro_sensitivity_x * 10)) / 10;
                    if (_gyro_value_y != undefined) __y += (round((_gyro_value_y * _dts * __player.__gyro_screen_height * __player.__gyro_sensitivity_y * 10)) / 10)*_y_inverted;
                }
            }

            //Cursor bindings
            var _xy = input_xy(INPUT_CURSOR_VERB_LEFT, INPUT_CURSOR_VERB_RIGHT, INPUT_CURSOR_VERB_UP, INPUT_CURSOR_VERB_DOWN, __player.__index);
            if ((_xy.x != 0.0) || (_xy.y != 0.0))
            {
                __using_mouse = false;
                
                if (INPUT_CURSOR_EXPONENT != 1)
                {
                    var _coeff = power(point_distance(0, 0, _xy.x, _xy.y), INPUT_CURSOR_EXPONENT);
                    __x += __speed*_coeff*_xy.x;
                    __y += __speed*_coeff*_xy.y*_y_inverted;
                }
                else
                {
                    __x += __speed*_xy.x;
                    __y += __speed*_xy.y*_y_inverted;
                }
            }
        }
        
        if ((__elastic_strength > 0) && !__using_mouse)
        {
            //Scale up movement so that even with elastic mode on the cursor has a full range of motion
            __x += (__x - __prev_x) / __elastic_strength;
            __y += (__y - __prev_y) / __elastic_strength;
            
            //The oldies are usually the goodies
            __x = lerp(__x, __elastic_x, __elastic_strength);
            __y = lerp(__y, __elastic_y, __elastic_strength);
        }
        
        if (__translation_active)
        {
            var _t = clamp((__input_get_time() - __translation_start_time) / (__translation_end_time - __translation_start_time), 0, 1);
            
            if (__translation_end_x != undefined) __x = lerp(__translation_start_x, __translation_end_x, _t);
            if (__translation_end_y != undefined) __y = lerp(__translation_start_y, __translation_end_y, _t);
            
            if (_t >= 1)
            {
                __translation_active = false;
                __translation_end_x  = undefined;
                __translation_end_y  = undefined;
            }
        }
        
        if ((__x != __prev_x) || (__y != __prev_y)) __moved_time = __input_get_time();
        
        __limit();
    }
    
    static __limit = function()
    {
        if ((__limit_l != undefined)
        &&  (__limit_t != undefined)
        &&  (__limit_r != undefined)
        &&  (__limit_b != undefined))
        {
            __x = clamp(__x, __limit_l, __limit_r);
            __y = clamp(__y, __limit_t, __limit_b);
        }
        else if ((__limit_x      != undefined)
             &&  (__limit_y      != undefined)
             &&  (__limit_radius != undefined))
        {
            var _dx = __x - __limit_x;
            var _dy = __y - __limit_y;
            var _d  = sqrt(_dx*_dx + _dy*_dy);
            
            if ((_d > 0) && (_d > __limit_radius))
            {
                _d = __limit_radius / _d;
                __x = __limit_x + _d*_dx;
                __y = __limit_y + _d*_dy;
            }
        }
        else if (__limit_boundary_margin != undefined)
        {
            var _clamped = false;
            switch(__coord_space)
            {
                case INPUT_COORD_SPACE.ROOM:
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
                            
                            var _rotatedX = (__x-_pivotX)*_cos - (__y-_pivotY)*_sin
                            var _rotatedY = (__x-_pivotX)*_sin + (__y-_pivotY)*_cos
                            
                            _rotatedX = clamp(_rotatedX, _l + __limit_boundary_margin - _pivotX, _r - __limit_boundary_margin - _pivotX);
                            _rotatedY = clamp(_rotatedY, _t + __limit_boundary_margin - _pivotY, _b - __limit_boundary_margin - _pivotY);
                            
                            __x =  _rotatedX*_sin + _rotatedY*_cos + _pivotX;
                            __y = -_rotatedX*_sin + _rotatedY*_cos + _pivotY;
                            
                            _clamped = true;
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
                break;
                
                case INPUT_COORD_SPACE.GUI:
                    var _l = 0;
                    var _t = 0;
                    var _r = display_get_gui_width();
                    var _b = display_get_gui_height();
                break;
                
                case INPUT_COORD_SPACE.DEVICE:
                    var _l = 0;
                    var _t = 0;
                    var _r = window_get_width()
                    var _b = window_get_height();
                break;
            }
            
            if (!_clamped)
            {
                __x = clamp(__x, _l + __limit_boundary_margin, _r - __limit_boundary_margin);
                __y = clamp(__y, _t + __limit_boundary_margin, _b - __limit_boundary_margin);
            }
        }
    }
}
