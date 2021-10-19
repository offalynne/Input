/// @param verb
/// @param binding
/// @param [playerIndex]
/// @param [alternate]

function input_binding_set(_verb, _binding, _player_index = 0, _alternate = 0)
{
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
    
    if (_alternate < 0)
    {
        __input_error("Invalid \"alternate\" argument (", _alternate, ")");
        return undefined;
    }
    
    if (_alternate >= INPUT_MAX_ALTERNATE_BINDINGS)
    {
        __input_error("\"alternate\" argument too large (", _alternate, " must be less than ", INPUT_MAX_ALTERNATE_BINDINGS, ")\nIncrease INPUT_MAX_ALTERNATE_BINDINGS for more alternate binding slots");
        return undefined;
    }
    
    if (!input_value_is_binding(_binding))
    {
        __input_error("Value provided is not a binding");
        return undefined;
    }
    
    with(global.__input_players[_player_index])
    {
        //Ensure that we have the correct config category for this binding for this player
        var _config_category = get_binding_config_category(_binding);
        
        __input_trace("Setting player ", _player_index, " binding for config=", _config_category, ", verb=", _verb, ", alt=", _alternate, " to \"", input_binding_get_name(_binding), "\"");
        set_binding(_config_category, _verb, _alternate, _binding);
    }
}