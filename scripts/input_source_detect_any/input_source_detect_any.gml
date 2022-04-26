function input_source_detect_any()
{
    //Check gamepad input before keyboard input to correctly handle Android duplicating button presses with keyboard presses
    var _g = 0;
    repeat(gamepad_get_device_count())
    {
        if (input_source_detect(INPUT_SOURCE.GAMEPAD, _g)) return new __input_class_source(INPUT_SOURCE.GAMEPAD, _g);
        ++_g;
    }
    
    if (input_source_detect(INPUT_SOURCE.KEYBOARD)) return new __input_class_source(INPUT_SOURCE.KEYBOARD);
    if (input_source_detect(INPUT_SOURCE.MOUSE)) return new __input_class_source(INPUT_SOURCE.MOUSE);
    
    return new __input_class_source(INPUT_SOURCE.NONE);
}