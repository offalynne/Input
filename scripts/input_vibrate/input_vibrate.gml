/// @desc Does a vibration for number of frames
/// @param   {Real} _strength 0-1
/// @param   {Real} _time in frames
/// @param   {Real} _player_index
function input_vibrate(_strength, _time, _player_index = 0)
{
	input_vibrate_lr(_strength, _strength, _time, _player_index);
}