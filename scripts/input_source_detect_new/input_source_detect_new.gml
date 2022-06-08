/// @desc    Returns a source that has presented new input and is unassigned, otherwise <undefined>

function input_source_detect_new()
{
    //Check gamepad input before keyboard input to correctly handle Android duplicating button presses with keyboard presses
    var _g = 0;
    repeat(array_length(INPUT_GAMEPAD))
    {
        if (input_source_detect_input(INPUT_GAMEPAD[_g])) return INPUT_GAMEPAD[_g];
        ++_g;
    }
    
    if (input_source_detect_input(INPUT_KEYBOARD)) return INPUT_KEYBOARD;
    if (input_source_detect_input(INPUT_MOUSE)) return INPUT_MOUSE;
    
    return undefined;
}