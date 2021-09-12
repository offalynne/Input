/// @param [playerIndex]

function input_cursor_y(_player_index = 0)
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
        if (is_numeric(camera) && (camera >= 0) && (INPUT_MOUSE_MODE == 0))
        {
            return camera_get_view_y(camera) + y;
        }
        else
        {
            return y;
        }
    }
}