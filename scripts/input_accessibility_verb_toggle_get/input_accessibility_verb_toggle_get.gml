/// @desc    Returns whether momentary toggle behaviour is enabled for a verb
/// @param   verb

function input_accessibility_verb_toggle_get(_verb_name)
{
    __input_initialize();
    __INPUT_VERIFY_BASIC_VERB_NAME
    
    return variable_struct_exists(global.__input_toggle_momentary_dict, _verb_name);
}