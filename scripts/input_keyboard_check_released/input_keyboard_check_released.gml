/// @desc    Checks if the given key is newly deactivated this frame.
/// @param   binding

function input_keyboard_check_released(_binding)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!_global.__keyboard_allowed || _global.__cleared)
    {
        return false;
    }
    
    return keyboard_check_released(_binding);
}
