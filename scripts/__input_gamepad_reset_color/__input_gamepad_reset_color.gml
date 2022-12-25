function __input_gamepad_reset_color(_gamepad_index)
{    
    if (_gamepad_index < 0) return;
    
    with (global.__input_gamepads[_gamepad_index])
    {
        __color_set(undefined);
    }
}