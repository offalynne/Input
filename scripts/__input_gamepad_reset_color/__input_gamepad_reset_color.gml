// Feather disable all
function __input_gamepad_reset_color(_gamepad_index)
{ 
    __INPUT_GLOBAL_STATIC_LOCAL
    
    if (_gamepad_index < 0) return;
    
    with(_global.__gamepads[_gamepad_index])
    {
        __color_set(undefined);
    }
}
