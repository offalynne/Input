/// @param [playerIndex]

function input_cursor_prev_x()
{
    var _player_index = ((argument_count > 0) && (argument[0] != undefined))? argument[0] : 0;
    
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " vs. ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    with(global.__input_players[_player_index].cursor)
    {
        if (is_numeric(camera) && (camera >= 0) && (INPUT_MOUSE_MODE == 0))
        {
            return camera_get_view_x(camera) + prev_x;
        }
        else
        {
            return prev_x;
        }
    }
}