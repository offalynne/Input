function input_source_detect_any()
{
    //Check gamepad input before keyboard input to correctly handle Android duplicating button presses with keyboard presses
    if (global.__input_gamepad_default_defined)
    {
        var _g = 0;
        repeat(gamepad_get_device_count())
        {
            if (input_source_detect(INPUT_SOURCE.GAMEPAD, _g))
            {
                return { source : INPUT_SOURCE.GAMEPAD, gamepad : _g };
            }
                    
            ++_g;
        }
    }
    
    if (global.__input_keyboard_default_defined || global.__input_mouse_default_defined)
    {
        if (input_source_detect(INPUT_SOURCE.KEYBOARD_AND_MOUSE))
        {
            return { source : INPUT_SOURCE.KEYBOARD_AND_MOUSE, gamepad : undefined };
        }
    }
    
    return { source: INPUT_SOURCE.NONE, gamepad : INPUT_NO_GAMEPAD };
}