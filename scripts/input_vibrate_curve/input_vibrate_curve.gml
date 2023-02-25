/// @desc    Vibrates a player's gamepad using an animation curve to control the strength
///          Units for the vibration duration are determined by INPUT_TIMER_MILLISECONDS
///          If the curve has one channel, that channel controls both left and right motors
///          If the curve has two (or more) channels then the first two channels from left
///          and right motos respectively
/// 
/// @param   strength
/// @param   curve
/// @param   pan
/// @param   duration
/// @param   [playedIndex=0]
/// @param   [force=false]

function input_vibrate_curve(_strength, _curve, _pan, _duration, _player_index = 0, _force = false)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    _strength = clamp(_strength, 0, 1);
    if (!animcurve_exists(_curve)) __input_error("Animation curve doesn't exist (", _curve, ")");
    _pan      = clamp(_pan, -1, 1);
    _duration = max(_duration, 0);
    
    _global.__players[_player_index].__vibration_add_event(new __input_class_vibration_curve(_strength, animcurve_get(_curve), _pan, _duration, _force));
}
