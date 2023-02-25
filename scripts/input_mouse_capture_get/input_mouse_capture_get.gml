/// @desc    Returns whether the mouse is being captured in the game window

function input_mouse_capture_get()
{
    static _global = __input_state();
    
    return {
        capture:     _global.__mouse_capture,
        sensitivity: _global.__mouse_capture_sensitivity,
    }
}