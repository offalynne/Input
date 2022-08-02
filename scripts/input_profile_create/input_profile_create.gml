/// @desc    Creates a custom profile for the player. This profile contains empty bindings for all verbs
/// @param   {String} _profile_name
/// @param   {Real} _player_index

function input_profile_create(_profile_name, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__profile_create(_profile_name);
}