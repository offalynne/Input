/// @desc    Sets whether verb cooldowns should be permitted across the game at all
/// @param   {Bool} _state

function input_accessibility_global_cooldown_set(_state)
{
    __input_initialize();
    
    global.__input_cooldown_state = _state;
}