/// @desc    Returns the state of a verb group, as defined by INPUT_VERB_GROUPS
/// @param   verbGroup
/// @param   [playerIndex=0]

function input_verb_group_is_active(_verb_group, _player_index = 0)
{
    __input_initialize();
    
    if (!variable_struct_exists(global.__input_group_to_verbs_dict, _verb_group))
    {
        __input_error("Verb group \"", _verb_group, "\" doesn't exist\nPlease make sure it has been defined in __input_config_verbs()");
    }
    
    return global.__input_players[_player_index].__verb_group_is_active(_verb_group);
}