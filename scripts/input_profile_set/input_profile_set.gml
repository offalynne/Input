/// @desc    Sets the currently active profile for the player
/// @param   profileName
/// @param   [playerIndex=0]

function input_profile_set(_profile_name, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__profile_set(_profile_name);
}