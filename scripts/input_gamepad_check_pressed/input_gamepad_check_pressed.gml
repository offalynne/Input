/// @param gamepadIndex
/// @param GMconstant

function input_gamepad_check_pressed(_index, _gm)
{
    if (global.__input_cleared || (_index < 0)
    || (_index >= array_length(global.__input_gamepads)))
    {
        return false;
    }
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.get_pressed(_gm);
}