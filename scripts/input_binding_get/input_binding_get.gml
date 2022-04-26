/// @param verb
/// @param [source]
/// @param [playerIndex]
/// @param [alternate]

function input_binding_get(_verb_name, _source = undefined, _player_index = 0, _alternate = 0)
{
	__input_initialize();
    __INPUT_VERIFY_ALTERNATE_INDEX
    __INPUT_VERIFY_BASIC_VERB_NAME
    
    if (is_string(_player_index))
    {
        if (_player_index == "default")
        {
            if (_source == undefined) __input_error("Source must be specified when getting a binding from the default player");
            
            with(global.__input_default_player)
            {
                return __get_binding(__get_config_name_from_source(_source), _verb_name, _alternate).__duplicate();
            }
        }
        else
        {
            __input_error("Player \"", _player_index, "\" not supported");
        }
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index])
    {
        return __get_binding(__get_config_name_from_source(_source), _verb_name, _alternate);
    }
    
    return undefined;
}