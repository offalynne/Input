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
    
    moved_time = __input_get_time();
    
    tick = function(_rebind_state)
    {
        prev_x = x;
        prev_y = y;
        
        if (global.__input_mouse_valid && (other.source == INPUT_SOURCE.KEYBOARD_AND_MOUSE) && (global.__input_mouse_moved || global.__input_cursor_using_mouse))
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
                var _player_verbs_struct = other.verbs;
                
                var _verb_u = variable_struct_get(_player_verbs_struct, global.__input_cursor_verb_u);
                var _verb_d = variable_struct_get(_player_verbs_struct, global.__input_cursor_verb_d);
                var _verb_l = variable_struct_get(_player_verbs_struct, global.__input_cursor_verb_l);
                var _verb_r = variable_struct_get(_player_verbs_struct, global.__input_cursor_verb_r);
                
                if (is_struct(_verb_u)
                &&  is_struct(_verb_d)
                &&  is_struct(_verb_l)
                &&  is_struct(_verb_r))
                {
                    var _value_u = _verb_u.consumed? 0.0 : _verb_u.raw;
                    var _value_d = _verb_d.consumed? 0.0 : _verb_d.raw;
                    var _value_l = _verb_l.consumed? 0.0 : _verb_l.raw;
                    var _value_r = _verb_r.consumed? 0.0 : _verb_r.raw;
                    
                    if (((_value_u > 0.0) && !_verb_u.raw_analogue)
                    ||  ((_value_d > 0.0) && !_verb_d.raw_analogue)
                    ||  ((_value_l > 0.0) && !_verb_l.raw_analogue)
                    ||  ((_value_r > 0.0) && !_verb_r.raw_analogue))
                    {
                        if (_verb_u.raw_analogue) _value_u = 0.0;
                        if (_verb_d.raw_analogue) _value_d = 0.0;
                        if (_verb_l.raw_analogue) _value_l = 0.0;
                        if (_verb_r.raw_analogue) _value_r = 0.0;
                    }
                    
                    var _dx = _value_r - _value_l;
                    var _dy = _value_d - _value_u;
                    
                    var _d = sqrt(_dx*_dx + _dy*_dy);
                    if (_d > 0)
                    {
                        global.__input_cursor_using_mouse = false;
                        _d = (global.__input_cursor_speed/_d) * clamp((_d - INPUT_DEFAULT_MIN_THRESHOLD) / (INPUT_DEFAULT_MAX_THRESHOLD - INPUT_DEFAULT_MIN_THRESHOLD), 0.0, 1.0);
                        x += _d*_dx;
                        y += _d*_dy;
                    }
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
