/// @param axis
/// @param negative
/// @param verb
/// @param [alternate]

function input_default_joycon_axis(_axis, _negative, _verb, _alternate = 0)
{
    if (INPUT_WARNING_DEPRECATED) __input_error("This function has been deprecated\n(Set INPUT_WARNING_DEPRECATED to <false> to ignore this warning)");
    
    input_binding_set_default(_verb, input_binding_joycon_axis(_axis, _negative), _alternate);
}