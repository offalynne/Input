/// @desc    Returns whether momentary toggles are allowed across the game

function input_accessibility_global_toggle_get()
{
    static _global = _input_state();
    
    return global.__input_toggle_momentary_state;
}