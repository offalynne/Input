/// @desc    Sets whether momentary toggles should be permitted across the game at all
/// @param   state

function input_accessibility_global_toggle_set(_state)
{
    __INPUT_GLOBAL_STATIC
    
    global.__input_toggle_momentary_state = _state;
}