// Feather disable all
/// @desc    Returns an array of structs, gamepad bindings that are invalid due to the gamepad lacking certain mapped inputs
/// @param   [playerIndex=0]
/// @param   [profileName]

function input_player_get_invalid_gamepad_bindings(_player_index = 0, _profile_name = undefined)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_PROFILE_NAME
    
    return _global.__players[_player_index].__get_invalid_gamepad_bindings(_profile_name);
}
