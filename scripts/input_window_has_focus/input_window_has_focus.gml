/// @desc    Returns whether the window is focused on desktop platforms

function input_window_has_focus()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    return (_global.__window_focus && !os_is_paused());
}