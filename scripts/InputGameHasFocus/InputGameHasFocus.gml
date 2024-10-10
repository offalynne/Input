// Feather disable all

/// Returns whether the game is focused.

function InputGameHasFocus()
{
    static _system = __InputSystem();
    return (_system.__windowFocus && !os_is_paused());
}