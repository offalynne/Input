/// @desc    Sets the state of a verb group, as defined by __input_config_verb_groups(). Verbs inside a deactivated verb group are also deactivated
/// @param   verbGroup
/// @param   state
/// @param   [playerIndex=0]
/// @param   [exclusive=false]

function input_verb_group_active(_verb_group, _state, _player_index = 0, _exclusive = false)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (!variable_struct_exists(_global.__group_to_verbs_dict, _verb_group))
    {
        __input_error("Verb group \"", _verb_group, "\" doesn't exist\nPlease make sure it has been defined in __input_config_verbs()");
    }
    
    _global.__players[_player_index].__verb_group_active(_verb_group, _state, _exclusive);
}