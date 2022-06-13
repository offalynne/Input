/// @desc    Returns whether verb cooldowns are allowed across the game

function input_accessibility_global_cooldown_get()
{
    __input_initialize();
    
    return global.__input_cooldown_state;
}