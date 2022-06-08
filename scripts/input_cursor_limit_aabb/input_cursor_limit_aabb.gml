/// @desc    Limits the cursor’s motion inside an axis-aligned bounding box with the given coordinates
/// @param   left
/// @param   top
/// @param   right
/// @param   bottom
/// @param   [playerIndex=0]

function input_cursor_limit_aabb(_l, _t, _r, _b, _player_index = 0)
{
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_cursor_limit_aabb(_l, _t, _r, _b, _p);
            ++_p;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index].__cursor)
    {
        __limit_l = _l;
        __limit_t = _t;
        __limit_r = _r;
        __limit_b = _b;
        
        __limit_x      = undefined;
        __limit_y      = undefined;
        __limit_radius = undefined;
        
        __limit();
    }
}