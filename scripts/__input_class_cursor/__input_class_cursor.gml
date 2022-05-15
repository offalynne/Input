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
    
    __moved_time  = -infinity;
    __using_mouse = false;
    __speed       = 1;
    __coord_space = INPUT_COORD_SPACE.ROOM;
    
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
        
        if (global.__input_any_mouse_binding_defined && (global.__input_pointer_moved || __using_mouse) && __player.__source_contains(INPUT_MOUSE))
        {
            __using_mouse = true;
            
            switch(__coord_space)
            {
                case INPUT_COORD_SPACE.ROOM:
                    __x = device_mouse_x(global.__input_pointer_index);
                    __y = device_mouse_y(global.__input_pointer_index);
                break;
                
                case INPUT_COORD_SPACE.GUI:
                    __x = device_mouse_x_to_gui(global.__input_pointer_index);
                    __y = device_mouse_y_to_gui(global.__input_pointer_index);
                break;
                
                case INPUT_COORD_SPACE.DISPLAY:
                    __x = device_mouse_raw_x(global.__input_pointer_index);
                    __y = device_mouse_raw_y(global.__input_pointer_index);
                break;
                
                default:
                    __input_error("Invalid mouse coordinate space (", __coord_space, ")\nPlease use values from the INPUT_COORD_SPACE enum");
                break;
            }
        }
        
        //Don't update the cursor if the mouse recently moved or we're rebinding controls
        if (global.__input_cursor_verbs_valid && !global.__input_pointer_moved && (__player.__rebind_state <= 0))
        {
            var _xy = input_xy(INPUT_CURSOR_VERB_LEFT, INPUT_CURSOR_VERB_RIGHT, INPUT_CURSOR_VERB_UP, INPUT_CURSOR_VERB_DOWN, __player.__index);
            if ((_xy.x != 0.0) || (_xy.y != 0.0))
            {
                __using_mouse = false;
                __x += __speed*_xy.x;
                __y += __speed*_xy.y;
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