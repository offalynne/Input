// Feather disable all
/// @desc    Returns whether momentary toggles are allowed across the game

function input_accessibility_global_toggle_get()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    return _global.__toggle_momentary_state;
}
