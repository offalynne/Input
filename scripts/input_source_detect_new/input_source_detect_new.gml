/// @desc    Returns a source that has presented new input and is unassigned, otherwise <undefined>

function input_source_detect_new()
{
    //Check gamepad input before keyboard input to correctly handle Android duplicating button presses with keyboard presses
    var _gamepad_count = array_length(INPUT_GAMEPAD);
    var _sort_order = 1;
    var _g = 0;
    
    if (!__INPUT_ON_WEB && ((os_type == os_macosx)
    || (!global.__input_using_steamworks && (os_type == os_windows))
    || ( global.__input_using_steamworks && (os_type == os_linux))))
    {
        //Search last-to-first on platforms with low-index virtual controllers (Steam Input, ViGEm)
        //We want real devices to take priority over virtual ones where possible to avoid thrashing
        _sort_order = -1;
        _g = _gamepad_count - 1;
    }
    
    repeat(_gamepad_count)
    {
        if (input_source_detect_input(INPUT_GAMEPAD[_g])) return INPUT_GAMEPAD[_g];
        _g += _sort_order;
    }
    
    if (input_source_detect_input(INPUT_KEYBOARD)) return INPUT_KEYBOARD;
    if (input_source_detect_input(__INPUT_TOUCH_PRIMARY? INPUT_TOUCH : INPUT_MOUSE)) return __INPUT_TOUCH_PRIMARY? INPUT_TOUCH : INPUT_MOUSE;
    
    return undefined;
}