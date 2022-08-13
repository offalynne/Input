/// @desc Vibrates a player's controller using animation curve channels for a duration, the units of which are determined by INPUT_TIMER_MILLISECONDS
///       Curves are evaluated if they contain one channel or individual channels per INPUT_VIBRATION_CHANNEL_LEFT and INPUT_VIBRATION_CHANNEL_RIGHT
/// @param   {Asset.GMAnimCurve} _animation_curve
/// @param   {Real} _duration
/// @param   {Real} _player_index
function input_vibrate_curve(_animation_curve, _duration, _player_index = 0)
{ 
    if (!is_real(_animation_curve) || !is_struct(animcurve_get(_animation_curve)))
    {
        __input_error("Vibration curve set to an illegal value (typeof=", typeof(_animation_curve), ")");
    }
    
    __INPUT_VERIFY_PLAYER_INDEX

    global.__input_players[_player_index].__haptic_vibrate_curve(_animation_curve, _duration);
}
