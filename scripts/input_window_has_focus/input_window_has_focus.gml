/// @desc    Returns whether the window is focused on desktop platforms

function input_window_has_focus()
{
    return (_global.__window_focus && !os_is_paused());
}