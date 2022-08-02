/// @desc    Outputs a string or struct containing the bindings and axis thresholds for the given profile
/// @param   {String} _profile_name
/// @param   {Real} _player_index
/// @param   {Bool} _output_string
/// @param   {Bool} _prettify

function input_profile_export(_profile_name, _player_index = 0, _output_string = true, _prettify = false)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__profile_export(_profile_name, _output_string, _prettify);
}