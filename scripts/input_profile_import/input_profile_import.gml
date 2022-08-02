/// @desc    Reads a JSON (string or struct) that contains profile data and replaces the given profile's data with it
/// @param   {String, Struct} _json
/// @param   {String} _profile_name
/// @param   {Real} _player_index

function input_profile_import(_json, _profile_name, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__profile_import(_json, _profile_name);
}