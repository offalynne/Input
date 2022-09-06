/// @desc    Vibrates a player's gampead with a series of pulses over the given duration
///          Units for the vibration duration are determined by INPUT_TIMER_MILLISECONDS
///          
/// @param   strength
/// @param   pan
/// @param   repeats
/// @param   duration
/// @param   [playerIndex=0]

function input_vibrate_pulse(_strength, _pan, _repeats, _duration, _player_index = 0)
{
    if (global.__input_vibration_paused)
    {
        __input_trace("New pulse vibration ignored: vibration is paused")
        exit;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    _strength = clamp(_strength, 0, 1);
    _pan      = clamp(_pan, -1, 1);
    _repeats  = max(_repeats, 0);
    _duration = max(_duration, 0);
    
    array_push(global.__input_players[_player_index].__vibration_event_array, new __input_class_vibration_pulse(_strength, _pan, _repeats, _duration));
}
