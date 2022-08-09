function input_vibrate_curve(_curve, _time, _player_index = 0)
{
	__INPUT_VERIFY_PLAYER_INDEX
	
	global.__input_players[_player_index].__haptic_vibrate_curve(_curve, _time);
}