/// @desc    Returns the name of the verb group the verb is in, as defined by __input_config_verb_groups()
///          If the verb is in no verb group, this function returns <undefined>
/// @param   verb

function input_verb_get_group(_verb_name)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_BASIC_VERB_NAME
    
    return _global.__verb_to_group_dict[$ _verb_name];
}