/// @param left
/// @param top
/// @param right
/// @param bottom
/// @param [playerIndex]

function input_cursor_limit_box()
{
    var _left         = argument[0];
    var _top          = argument[1];
    var _right        = argument[2];
    var _bottom       = argument[3];
    var _player_index = ((argument_count > 4) && (argument[4] != undefined))? argument[4] : 0;
    
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