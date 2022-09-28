/// @desc    Returns whether the given (non-blocked) gamepad is connected
/// @param   gamepadIndex

function input_gamepad_is_connected(_index)
{
    if ((_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(global.__input_gamepads)))
    {
        return false;
    }
    
    if (!is_struct(global.__input_gamepads[_index])) return false;
    
    return gamepad_is_connected(_index);
}