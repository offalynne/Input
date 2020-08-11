/// @param [playerIndex]

function input_player_connected()
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
    
    var _source = input_player_source_get(_player_index);
    if (_source == INPUT_SOURCE.NONE) return false;
    if (_source == INPUT_SOURCE.GAMEPAD) return gamepad_is_connected(input_player_gamepad_get(_player_index));
    return true;
}