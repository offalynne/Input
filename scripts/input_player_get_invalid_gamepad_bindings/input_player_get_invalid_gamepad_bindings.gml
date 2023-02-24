/// @desc    Returns an array of structs, gamepad bindings that are invalid due to the gamepad lacking certain mapped inputs
/// @param   [playerIndex=0]
/// @param   [profileName]

function input_player_get_invalid_gamepad_bindings(_player_index = 0, _profile_name = undefined)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_PROFILE_NAME
    
    return global.__input_players[_player_index].__get_invalid_gamepad_bindings(_profile_name);
}