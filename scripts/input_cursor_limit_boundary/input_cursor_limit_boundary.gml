/// @desc    Limits the cursor’s motion inside the visible portion of the game window
/// @param   [margin=0]
/// @param   [playerIndex=0]

function input_cursor_limit_boundary(_margin = 0, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_cursor_limit_boundary(_p);
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
        
        __limit_x      = undefined;
        __limit_y      = undefined;
        __limit_radius = undefined;
        
        __limit_boundary_margin = _margin;
        
        __limit();
    }
}