/// @desc Vibrates a player's controller for a duration, the units of which are determined by INPUT_TIMER_MILLISECONDS
/// @param   {Real} _left_motor_speed
/// @param   {Real} _right_motor_speed
/// @param   {Real} _duration
/// @param   {Real} _player_index
function input_vibrate(_left_motor_speed, _right_motor_speed, _duration, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__haptic_vibrate(_left_motor_speed, _right_motor_speed, _duration);
}
