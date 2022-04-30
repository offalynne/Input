/// @param profileName
/// @param [playerIndex=0]

function input_player_set_profile(_profile_name, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_PROFILE_NAME
    
    global.__input_players[_player_index].__profile_name = _profile_name;
}