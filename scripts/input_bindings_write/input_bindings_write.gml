/// @param [playerIndex]

function input_bindings_write()
{
    var _player_index = ((argument_count > 0) && (argument[0] != undefined))? argument[0] : all;
    
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
    
    var _config = undefined;
    
    if (_player_index == all)
    {
        var _config = array_create(INPUT_MAX_PLAYERS, undefined);
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            _config[@ _i] = global.__input_players[_i].config;
            ++_i;
        }
    }
    else
    {
        _config = global.__input_players[_player_index].config;
    }
    
    return json_stringify(_config);
}