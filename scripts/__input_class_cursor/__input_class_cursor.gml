function __input_class_cursor() constructor
{
    prev_x = 0;
    prev_y = 0;
    x = 0;
    y = 0;
    
    camera = undefined;
    
    limit_l = undefined;
    limit_t = undefined;
    limit_r = undefined;
    limit_b = undefined;
    
    limit_x = undefined;
    limit_y = undefined;
    limit_radius = undefined;
    
    moved_time = -1;
    
    tick = function(_rebind_state)
    {
        prev_x = x;
        prev_y = y;
        
        if (global.__input_mouse_default_defined && (other.source == INPUT_SOURCE.KEYBOARD_AND_MOUSE) && (global.__input_mouse_moved || global.__input_cursor_using_mouse))
        {
            global.__input_cursor_using_mouse = true;
            x = global.__input_mouse_x;
            y = global.__input_mouse_y;
        }
        
        //Don't update the cursor if the mouse recently moved or we're rebinding controls
        if (!global.__input_mouse_moved && (_rebind_state <= 0))
        {
            if ((global.__input_cursor_verb_u != undefined)
            &&  (global.__input_cursor_verb_d != undefined)
            &&  (global.__input_cursor_verb_l != undefined)
            &&  (global.__input_cursor_verb_r != undefined))
            {
                var _xy = input_xy(global.__input_cursor_verb_l, global.__input_cursor_verb_r, global.__input_cursor_verb_u, global.__input_cursor_verb_d, other);
                if ((_xy.x != 0.0) || (_xy.y != 0.0))
                {
                    global.__input_cursor_using_mouse = false;
                    x += global.__input_cursor_speed*_xy.x;
                    y += global.__input_cursor_speed*_xy.y;
                }
            }
        }
        
        if ((x != prev_x) || (y != prev_y)) moved_time = __input_get_time();
    }
    
    limit = function()
    {
        if ((limit_l != undefined)
        &&  (limit_t != undefined)
        &&  (limit_r != undefined)
        &&  (limit_b != undefined))
        {
            x = clamp(x, limit_l, limit_r);
            y = clamp(y, limit_t, limit_b);
        }
        else if ((limit_x != undefined) && (limit_y != undefined) && (limit_radius != undefined))
        {
            var _dx = x - limit_x;
            var _dy = y - limit_y;
            var _d  = sqrt(_dx*_dx + _dy*_dy);
            
            if ((_d > 0) && (_d > limit_radius))
            {
                _d = limit_radius / _d;
                 x = limit_x + _d*_dx;
                 y = limit_y + _d*_dy;
            }
        }
    }
}
