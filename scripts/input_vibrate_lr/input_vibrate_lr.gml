/// @desc Does a vibration for number of frames, different for left and right motor
/// @param   {Real} _lstrength 0-1
/// @param   {Real} _rstrength 0-1
/// @param   {Real} _time in frames
/// @param   {Real} _player_index
function input_vibrate_lr(_lstrength, _rstrength, _time, _player_index = 0)
{
	__INPUT_VERIFY_PLAYER_INDEX
	
	global.__input_players[_player_index].__haptic_vibrate(_lstrength, _rstrength, _time);
}