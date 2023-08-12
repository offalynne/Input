// Feather disable all
/// @desc    Removes a binding from the player. Be careful with this function!
/// @param   verb
/// @param   [playerIndex=0]
/// @param   [alternate=0]
/// @param   [profileName]

function input_binding_remove(_verb, _player_index = 0, _alternate = 0, _profile_name = undefined)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_ALTERNATE_INDEX
    __INPUT_VERIFY_PROFILE_NAME
    
    _global.__players[_player_index].__binding_remove(_profile_name, _verb, _alternate);
}
