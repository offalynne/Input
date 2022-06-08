/// @desc    Returns whether the profile with the given name exists
/// @param   profileName
/// @param   [playerIndex=0]

function input_profile_exists(_profile_name, _player_index = 0)
{
	__input_initialize();
    
    if (is_string(_player_index) && (_player_index == "default"))
    {
        return global.__input_default_player.__profile_exists(_profile_name);
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__profile_exists(_profile_name);
}