/// @desc Vibrates a player's controller for a duration, the units of which are determined by INPUT_TIMER_MILLISECONDS
/// @param   leftMotorSpeed
/// @param   rightMotorSpeed
/// @param   time
/// @param   [playerIndex=0]
function input_vibrate(_left_motor_speed, _right_motor_speed, _duration, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__haptic_vibrate(_left_motor_speed, _right_motor_speed, _duration);
}
