/// @param verb
/// @param source
/// @param [playerIndex]
/// @param [alternate]

function input_binding_reset(_verb, _source, _player_index = 0, _alternate = 0)
{
    if ((!is_numeric(_source) && !is_string(_source)) || (_source == INPUT_SOURCE.NONE) || (_source == INPUT_SOURCE.GHOST))
    {
        __input_error("Invalid source provided (", _source, ")\nPlease use INPUT_SOURCE.KEYBOARD_AND_MOUSE or INPUT_SOURCE.GAMEPAD");
        return undefined;
    }
    
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
    
    with(global.__input_players[_player_index])
    {
        __reset_binding(convert_source_enum_to_config_name(_source), _verb, _alternate);
    }
}