/// @param verbGroup

function input_verb_group_is_active(_verb_group)
{
    __input_initialize();
    
    if (!variable_struct_exists(global.__input_verb_group_state_dict, _verb_group))
    {
        __input_error("Verb group \"", _verb_group, "\" doesn't exist\nPlease make sure it has been defined in __input_config_verbs()");
    }
    
    return global.__input_verb_group_state_dict[$ _verb_group];
}