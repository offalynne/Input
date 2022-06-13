/// @desc    Checks if the given button/axis is newly deactivated this frame
/// @param   gamepadIndex
/// @param   GMconstant

function input_gamepad_check_released(_index, _gm)
{
    if (global.__input_cleared
    ||  (_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(global.__input_gamepads)))
    {
        return false;
    }
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.get_released(_gm);
}