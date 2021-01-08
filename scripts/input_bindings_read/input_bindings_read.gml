/// @param string
/// @param [playerIndex]

function input_bindings_read()
{
    var _string       = argument[0];
    var _player_index = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : all;
    
    if ((_player_index < 0) && (_player_index != all))
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " vs. ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    var _config = json_parse(_string);
    
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            global.__input_players[_i].config = _config[_i];
            ++_i;
        }
    }
    else
    {
        global.__input_players[_player_index].config = _config;
    }
}