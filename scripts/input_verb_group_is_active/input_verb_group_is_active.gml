// Feather disable all
/// @desc    Returns the state of a verb group, as defined by __input_config_verb_groups()
/// @param   verbGroup
/// @param   [playerIndex=0]

function input_verb_group_is_active(_verb_group, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!variable_struct_exists(_global.__group_to_verbs_dict, _verb_group))
    {
        __input_error("Verb group \"", _verb_group, "\" doesn't exist\nPlease make sure it has been defined in __input_config_verb_groups()");
    }
    
    return _global.__players[_player_index].__verb_group_is_active(_verb_group);
}
