/// @desc    Destroys a custom profile created by input_profile_create(). Default profiles defined in INPUT_DEFAULT_PROFILES cannot be destroyed
/// @param   profileName
/// @param   [playerIndex=0]

function input_profile_destroy(_profile_name, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__profile_destroy(_profile_name);
}