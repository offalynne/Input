/// @desc Vibrates a player's controller using animation curve channels for a time, the units of which are determined by INPUT_TIMER_MILLISECONDS
/// @param   animationCurve
/// @param   time
/// @param   [playerIndex=0]
function input_player_vibrate_curve(_curve, _time, _player_index = 0)
{	
	__INPUT_VERIFY_PLAYER_INDEX
	
	global.__input_players[_player_index].__haptic_vibrate_curve(_curve, _time);
}