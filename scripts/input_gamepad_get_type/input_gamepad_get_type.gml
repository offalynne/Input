/// @desc    Returns the gamepad type as a string (after SDL remapping)
/// @param   gamepadIndex

function input_gamepad_get_type(_index)
{
    if ((_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(global.__input_gamepads)))
    {
        return "unknown";
    }
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return "unknown";
    return _gamepad.simple_type;
}