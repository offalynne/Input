/// @desc    Sets whether momentary toggles should be permitted across the game at all
/// @param   state

function input_accessibility_global_toggle_set(_state)
{
    __INPUT_GLOBAL_STATIC_LOCAL
    __INPUT_GLOBAL_STATIC_LOCAL
    
    _global.__toggle_momentary_state = _state;
}