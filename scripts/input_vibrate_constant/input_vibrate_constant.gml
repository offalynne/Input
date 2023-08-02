// Feather disable all
/// @desc    Vibrates a player's gampead at a constant strength for the given duration
///          Units for the vibration duration are determined by INPUT_TIMER_MILLISECONDS
/// 
/// @param   strength
/// @param   pan
/// @param   duration
/// @param   [playerIndex=0]
/// @param   [force=false]

function input_vibrate_constant(_strength, _pan, _duration, _player_index = 0, _force = false)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    _strength = clamp(_strength, 0, 1);
    _pan      = clamp(_pan, -1, 1);
    _duration = max(_duration, 0);
    
    _global.__players[_player_index].__vibration_add_event(new __input_class_vibration_constant(_strength, _pan, _duration, _force));
}
