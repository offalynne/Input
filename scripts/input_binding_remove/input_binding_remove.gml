/// @param verb
/// @param source
/// @param [playerIndex]
/// @param [alternate]

function input_binding_remove(_verb, _source, _player_index = 0, _alternate = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_ALTERNATE_INDEX
    
    if ((!is_numeric(_source) && !is_string(_source)) || (_source == INPUT_SOURCE.NONE) || (_source == INPUT_SOURCE.GHOST))
    {
        __input_error("Invalid source provided (", _source, ")\nPlease use INPUT_SOURCE.KEYBOARD_AND_MOUSE or INPUT_SOURCE.GAMEPAD");
        return undefined;
    }
    
    with(global.__input_players[_player_index])
    {
        __remove_binding(__get_config_name_from_source(_source), _verb, _alternate);
    }
}