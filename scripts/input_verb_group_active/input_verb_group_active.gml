/// @param verbGroup
/// @param state
/// @param [playerIndex=0]

function input_verb_group_active(_verb_group, _state, _player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (!variable_struct_exists(global.__input_group_to_verbs_dict, _verb_group))
    {
        __input_error("Verb group \"", _verb_group, "\" doesn't exist\nPlease make sure it has been defined in __input_config_verbs()");
    }
    
    global.__input_players[_player_index].__verb_group_active(_verb_group, _state);
}