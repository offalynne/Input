/// @desc    Whether to capture the mouse in the game window, and its movement speed for Input's built-in mouse tracking
/// @param   state
/// @param   [sensitivity=1]

function input_mouse_capture_set(_state, _sensitivity = 1)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!__INPUT_ON_DESKTOP || __INPUT_ON_WEB)
    {
        __input_trace("Mouse capture unsupported for this platform");
        return;
    }
    
    if (_state && !_global.__mouse_capture) _global.__mouse_capture_frame = _global.__frame;
    
    _global.__mouse_capture             = _state;
    _global.__mouse_capture_sensitivity = _sensitivity;
    
    __input_release_multimonitor_cursor();
}