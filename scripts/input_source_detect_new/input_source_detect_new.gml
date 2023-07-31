// Feather disable all
/// @desc    Returns a source that has presented new input and is unassigned, otherwise <undefined>

function input_source_detect_new()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    //Check gamepad input before keyboard input to correctly handle Android duplicating button presses with keyboard presses
    var _gamepad_count = array_length(INPUT_GAMEPAD);
    var _sort_order = 1;
    var _g = 0;
    
    if (!INPUT_ON_WEB && (__INPUT_ON_MACOS || (!_global.__using_steamworks && __INPUT_ON_WINDOWS) || (_global.__using_steamworks && __INPUT_ON_LINUX)))
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
    if (input_source_detect_input(INPUT_MOUSE))    return INPUT_MOUSE;
    if (input_source_detect_input(INPUT_TOUCH))    return INPUT_TOUCH;
    
    return undefined;
}
