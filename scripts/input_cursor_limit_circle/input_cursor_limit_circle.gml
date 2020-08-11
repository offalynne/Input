/// @param centerX
/// @param centerY
/// @param radius
/// @param [playerIndex]

function input_cursor_limit_circle()
{
    var _centre_x     = argument[0];
    var _centre_y     = argument[1];
    var _radius       = argument[2];
    var _player_index = ((argument_count > 3) && (argument[3] != undefined))? argument[3] : 0;
    
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
        limit_l = undefined;
        limit_t = undefined;
        limit_r = undefined;
        limit_b = undefined;
        
        limit_x = _centre_x;
        limit_y = _centre_y;
        limit_radius = _radius;
        
        limit();
    }
}