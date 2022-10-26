/// @desc    Returns whether the mouse is being captured in the game window

function input_mouse_capture_get()
{
    __input_initialize();
    
    return {
        capture:     global.__input_mouse_capture,
        sensitivity: global.__input_mouse_capture_sensitivity,
    }
}