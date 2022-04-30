function input_source_detect_any()
{
    //Check gamepad input before keyboard input to correctly handle Android duplicating button presses with keyboard presses
    var _g = 0;
    repeat(gamepad_get_device_count())
    {
        if (input_source_detect(INPUT_GAMEPAD[_g])) return INPUT_GAMEPAD[_g];
        ++_g;
    }
    
    if (input_source_detect(INPUT_KEYBOARD)) return INPUT_KEYBOARD;
    if (input_source_detect(INPUT_MOUSE)) return INPUT_MOUSE;
    
    return INPUT_NONE;
}