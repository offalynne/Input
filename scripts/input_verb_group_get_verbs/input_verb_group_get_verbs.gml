// Feather disable all

/// @desc    Returns an array of verbs in the given group
/// @param   verbGroup

function input_verb_group_get_verbs(_verb_group)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!variable_struct_exists(_global.__group_to_verbs_dict, _verb_group))
    {
        __input_error("Verb group \"", _verb_group, "\" doesn't exist\nPlease make sure it has been defined in __input_config_verbs()");
    }
    
    return _global.__group_to_verbs_dict[$ _verb_group];
}
