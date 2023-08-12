// Feather disable all
/// @desc    Creates a custom profile for the player. This profile contains empty bindings for all verbs
/// @param   profileName
/// @param   [playerIndex=0]

function input_profile_create(_profile_name, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    return _global.__players[_player_index].__profile_create(_profile_name);
}
