/// @param verb
/// @param [source]
/// @param [playerIndex]
/// @param [alternate]

function input_binding_get(_verb, _source = undefined, _player_index = 0, _alternate = 0)
{
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
    
    if (_alternate < 0)
    {
        __input_error("Invalid \"alternate\" argument (", _alternate, ")");
        return undefined;
    }
    
    if (_alternate >= INPUT_MAX_ALTERNATE_BINDINGS)
    {
        __input_error("\"alternate\" argument too large (", _alternate, " vs. ", INPUT_MAX_ALTERNATE_BINDINGS, ")\nIncrease INPUT_MAX_ALTERNATE_BINDINGS for more alternate binding slots");
        return undefined;
    }
    
    with(global.__input_players[_player_index])
    {
        return get_binding(_source, _verb, _alternate);
    }
    
    return undefined;
}