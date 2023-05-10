/// @desc    Limits the cursor’s motion inside a circle centred at the given point
/// @param   x
/// @param   y
/// @param   radius
/// @param   [playerIndex=0]

function input_cursor_limit_circle(_x, _y, _radius, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_cursor_limit_circle(_x, _y, _radius, _p);
            ++_p;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(_global.__players[_player_index].__cursor)
    {
        __limit_l = undefined;
        __limit_t = undefined;
        __limit_r = undefined;
        __limit_b = undefined;
        
        __limit_x      = _x;
        __limit_y      = _y;
        __limit_radius = _radius;
        
        __limit_boundary_margin = undefined;
        
        __limit();
    }
}