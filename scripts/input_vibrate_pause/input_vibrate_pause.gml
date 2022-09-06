/// @desc    Immediately pauses vibration events
/// 
/// @param   [state=true]
function input_vibrate_pause(_state = true)
{
    global.__input_vibration_paused = _state;
}