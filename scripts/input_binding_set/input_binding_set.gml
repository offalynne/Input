/// @param verb
/// @param binding
/// @param [playerIndex]
/// @param [alternate]

function input_binding_set(_verb_name, _binding, _player_index = 0, _alternate = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_ALTERNATE_INDEX
    __INPUT_VERIFY_BASIC_VERB_NAME
    
    if (!input_value_is_binding(_binding))
    {
        __input_error("Value provided is not a binding");
        return undefined;
    }
    
    global.__input_players[_player_index].__set_binding(_verb_name, _alternate, _binding);
}