/// @desc    Returns the analogue value of the given input (after applying SDL axis remapping)
/// @param   gamepadIndex
/// @param   GMconstant

function input_gamepad_value(_index, _gm)
{
    if ((_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(global.__input_gamepads)))
    {
        return 0.0;
    }
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.get_value(_gm);
}