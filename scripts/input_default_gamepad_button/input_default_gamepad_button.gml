/// @param button
/// @param verb
/// @param [alternate]

function input_default_gamepad_button(_button, _verb, _alternate = 0)
{
    if (INPUT_WARNING_DEPRECATED) __input_error("This function has been deprecated\n(Set INPUT_WARNING_DEPRECATED to <false> to ignore this warning)");
    
    input_default_binding_set(_verb, input_binding_gamepad_button(_button), _alternate);
}