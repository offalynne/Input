// Feather disable all
/// @desc    Returns whether the given (non-blocked) gamepad is connected
/// @param   gamepadIndex

function input_gamepad_is_connected(_index)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if ((_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepad_connections_internal)))
    {
        return false;
    }
    
    return _global.__gamepad_connections_internal[_index];
}