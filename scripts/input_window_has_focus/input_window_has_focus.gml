// Feather disable all
/// @desc    Returns whether the window is focused on desktop platforms

function input_window_has_focus()
{
    static __warned = false;
    if not (__warned)
    {
        __warned = true;
        __input_trace("Warning! input_window_has_focus() has been deprecated. Please use input_game_has_focus()");
    }
    
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    return (_global.__window_focus && !os_is_paused());
}
