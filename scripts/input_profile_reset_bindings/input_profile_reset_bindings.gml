/// @desc    Resets all bindings for the profile to those found in __input_config_verbs_and_bindings()
///          This will only work for default profiles
/// @param   profileName
/// @param   [playerIndex=0]

function input_profile_reset_bindings(_profile_name, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    return _global.__players[_player_index].__profile_reset_bindings(_profile_name);
}