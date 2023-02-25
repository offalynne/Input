/// @desc    Returns whether cooldown behaviour is enabled for a verb
/// @param   verb

function input_accessibility_verb_cooldown_get(_verb_name)
{
    __INPUT_GLOBAL_STATIC_LOCAL
    __INPUT_VERIFY_BASIC_VERB_NAME
    
    return variable_struct_exists(global.__input_cooldown_dict, _verb_name);
}