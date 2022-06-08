/// @desc    Returns whether momentary toggles are allowed across the game

function input_accessibility_global_toggle_get()
{
    __input_initialize();
    
    return global.__input_toggle_momentary_state;
}