/// @desc    Checks if the given button/axis is currently activated on the given gamepad
/// @param   gamepadIndex
/// @param   GMconstant

function input_gamepad_check(_index, _gm)
{
    if ((_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(global.__input_gamepads)))
    {
        return false;
    }
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.get_held(_gm);
}