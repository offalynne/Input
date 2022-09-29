function __input_class_cursor() constructor
{
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
            __prev_x = __x;
            __prev_y = __y;
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
        
        var _can_use_mouse = __player.__source_contains(INPUT_MOUSE);
        
        if ((global.__input_pointer_moved || __using_mouse) && _can_use_mouse)
        {
            __using_mouse = true;
                
            if (global.__input_mouse_capture)
            {
                __x += global.__input_pointer_dx[__coord_space];
                __y += global.__input_pointer_dy[__coord_space];
            }
            else
            {
                __x = global.__input_pointer_x[__coord_space];
                __y = global.__input_pointer_y[__coord_space];
            }
        }
        
        //Don't update the cursor if the mouse recently moved or we're rebinding controls
        if (global.__input_cursor_verbs_valid && (!global.__input_pointer_moved || !_can_use_mouse) && (__player.__rebind_state <= 0))
        {
            var _xy = input_xy(INPUT_CURSOR_VERB_LEFT, INPUT_CURSOR_VERB_RIGHT, INPUT_CURSOR_VERB_UP, INPUT_CURSOR_VERB_DOWN, __player.__index);
            if ((_xy.x != 0.0) || (_xy.y != 0.0))
            {
                __using_mouse = false;
                
                if (INPUT_CURSOR_EXPONENT != 1)
                {
                    var _coeff = power(point_distance(0, 0, _xy.x, _xy.y), INPUT_CURSOR_EXPONENT);
                    __x += __speed*_coeff*_xy.x;
                    __y += __speed*_coeff*_xy.y;
                }
                else
                {
                    __x += __speed*_xy.x;
                    __y += __speed*_xy.y;
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
    }
}