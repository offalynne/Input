/// @param axis
/// @param [playerIndex]

function input_axis_threshold_get()
{
    var _axis         = argument[0];
    var _player_index = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : 0;
    
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
    
    with(global.__input_players[_player_index])
    {
        return axis_threshold_get(_axis);
    }
}