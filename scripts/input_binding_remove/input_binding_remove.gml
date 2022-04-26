/// @param verb
/// @param source
/// @param [playerIndex]
/// @param [alternate]

function input_binding_remove(_verb, _source, _player_index = 0, _alternate = 0)
{
    if (INPUT_WARNING_DEPRECATED) __input_error("This function has been deprecated\n(Set INPUT_WARNING_DEPRECATED to <false> to ignore this warning)");
    
    return input_binding_reset(_verb, _source, _player_index, _alternate);
}
