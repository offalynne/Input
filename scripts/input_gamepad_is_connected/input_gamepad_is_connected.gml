/// @desc    Returns whether the given (non-blocked) gamepad is connected
/// @param   gamepadIndex

function input_gamepad_is_connected(_index)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!_global.__gamepad_allowed
    ||  (_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepads)))
    {
        return false;
    }
    
    if (!is_struct(_global.__gamepads[_index])) return false;
    
    return gamepad_is_connected(_index);
}