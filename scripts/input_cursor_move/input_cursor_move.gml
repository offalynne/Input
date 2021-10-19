/// @param targetX
/// @param targetY
/// @param [maxSpeed]
/// @param [playerIndex]

function input_cursor_move(_target_x, _target_y, _max_speed = -1, _player_index = 0)
{
    if (INPUT_WARNING_DEPRECATED) __input_error("This function has been deprecated\n(Set INPUT_WARNING_DEPRECATED to <false> to ignore this warning)");
    
    if ((_player_index < 0) && (_player_index != all))
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_cursor_move(_target_x, _target_y, _max_speed, _i);
            ++_i;
        }
    }
    else
    {
        with(global.__input_players[_player_index].cursor)
        {
            if (!is_numeric(_max_speed) || (_max_speed < 0))
            {
                x = _target_x;
                y = _target_y;
            }
            else
            {
                var _dx = _target_x - x;
                var _dy = _target_y - y;
                var _d  = sqrt(_dx*_dx + _dy*_dy);
                
                if (_d > 0)
                {
                    _d = min(_d, _max_speed) / _d;
                    x += _d*_dx;
                    y += _d*_dy;
                }
            }
            
            limit();
        }
    }
}