/// @param axis
/// @param min
/// @param max
/// @param [playerIndex]

function input_axis_threshold_set()
{
    var _axis         = argument[0];
    var _min          = argument[1];
    var _max          = argument[2];
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
    
    with(global.__input_players[_player_index])
    {
        return axis_threshold_set(_axis, _min, _max);
    }
}