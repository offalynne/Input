/// @desc    Sets whether verb cooldowns should be permitted across the game at all
/// @param   state

function input_accessibility_global_cooldown_set(_state)
{
    __INPUT_GLOBAL_STATIC_LOCAL
    
    global.__input_cooldown_state = _state;
}