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
    
    __moved_time = -1;
    
    static __set = function(_x, _y)
    {
        __x = _x;
        __y = _y;
        __prev_x = __x;
        __prev_y = __y;
    }
    
    static __tick = function()
    {
        __prev_x = __x;
        __prev_y = __y;
        
        if (global.__input_mouse_default_defined && (global.__input_mouse_moved || global.__input_cursor_using_mouse))
        {
            global.__input_cursor_using_mouse = true;
            __x = global.__input_mouse_x;
            __y = global.__input_mouse_y;
        }
        
        //Don't update the cursor if the mouse recently moved or we're rebinding controls
        if (global.__input_cursor_verbs_valid && !global.__input_mouse_moved && (__player.__rebind_state <= 0))
        {
            var _xy = input_xy(INPUT_CURSOR_VERB_LEFT, INPUT_CURSOR_VERB_RIGHT, INPUT_CURSOR_VERB_UP, INPUT_CURSOR_VERB_DOWN, other);
            if ((_xy.x != 0.0) || (_xy.y != 0.0))
            {
                global.__input_cursor_using_mouse = false;
                __x += global.__input_cursor_speed*_xy.x;
                __y += global.__input_cursor_speed*_xy.y;
            }
        }
        
        if ((__x != __prev_x) || (__y != __prev_y)) __moved_time = __input_get_time();
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
                 x = __limit_x + _d*_dx;
                 y = __limit_y + _d*_dy;
            }
        }
    }
}