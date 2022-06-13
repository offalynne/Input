/// @desc    Automatically assigns a profile to the player based on what sources they have been assigned
///          This is based on INPUT_AUTO_PROFILE_FOR_KEYBOARD etc. in __input_config_profiles_and_bindings()
/// @param   [playerIndex=0]

function input_profile_auto(_player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__profile_set_auto();
}