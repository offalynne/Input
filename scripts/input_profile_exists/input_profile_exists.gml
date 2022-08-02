/// @desc    Returns whether the profile with the given name exists
/// @param   {String} _profile_name
/// @param   {Real} _player_index

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