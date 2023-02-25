/// @desc    Returns whether verb cooldowns are allowed across the game

function input_accessibility_global_cooldown_get()
{
    __INPUT_GLOBAL_STATIC_LOCAL
    
    return global.__input_cooldown_state;
}