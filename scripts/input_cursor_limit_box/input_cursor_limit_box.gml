/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [playerIndex]

function input_cursor_limit_box(_left, _top, _right, _bottom, _player_index = 0)
{
    if (INPUT_WARNING_DEPRECATED) __input_error("This function has been deprecated\n(Set INPUT_WARNING_DEPRECATED to <false> to ignore this warning)");
    
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    with(global.__input_players[_player_index].cursor)
    {
        limit_l = _left;
        limit_t = _top;
        limit_r = _right;
        limit_b = _bottom;
        
        limit_x = undefined;
        limit_y = undefined;
        limit_radius = undefined;
        
        limit();
    }
}