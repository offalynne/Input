/// @desc    Returns the name of the verb group the verb is in, as defined by INPUT_VERB_GROUPS
///          If the verb is in no verb group, this function returns <undefined>
/// @param   verb

function input_verb_get_group(_verb_name)
{
    __input_initialize();
    __INPUT_VERIFY_BASIC_VERB_NAME
    
    return global.__input_verb_to_group_dict[$ _verb_name];
}