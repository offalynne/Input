// Feather disable all
/// @desc    Destroys a custom profile created by input_profile_create(). Default profiles defined in __input_config_verbs() cannot be destroyed
/// @param   profileName
/// @param   [playerIndex=0]

function input_profile_destroy(_profile_name, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    return _global.__players[_player_index].__profile_destroy(_profile_name);
}
