/// @param state
/// @param [sensitivity=1]

function input_mouse_capture_set(_state, _sensitivity = 1)
{
    __input_initialize();
    
    if (_state && !global.__input_mouse_capture) global.__input_mouse_capture_frame = global.__input_frame;
    
    global.__input_mouse_capture             = _state;
    global.__input_mouse_capture_sensitivity = _sensitivity;
}