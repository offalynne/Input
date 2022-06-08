/// @desc    Removes any cursor limits you have set using input_cursor_limit_aabb() or input_cursor_limit_circle() 
/// @param   [playerIndex=0]

function input_cursor_limit_remove(_player_index = 0)
{
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_cursor_limit_remove(_p);
            ++_p;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index].__cursor)
    {
        __limit_l = undefined;
        __limit_t = undefined;
        __limit_r = undefined;
        __limit_b = undefined;
        
        __limit_x      = undefined;
        __limit_y      = undefined;
        __limit_radius = undefined;
        
        __limit();
    }
}