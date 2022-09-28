/// @desc    Whether to capture the mouse in the game window, and its movement speed for Input's built-in mouse tracking
/// @param   state
/// @param   [sensitivity=1]

function input_mouse_capture_set(_state, _sensitivity = 1)
{
    __input_initialize();
    
    if (!__INPUT_ON_DESKTOP || __INPUT_ON_WEB)
    {
        __input_trace("Mouse capture unsupported for this platform");
        exit;
    }
    
    if (_state && !global.__input_mouse_capture) global.__input_mouse_capture_frame = global.__input_frame;
    
    global.__input_mouse_capture             = _state;
    global.__input_mouse_capture_sensitivity = _sensitivity;
    
    __input_release_multimonitor_cursor();
}