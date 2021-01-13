/// @param gamepadIndex
/// @param GMconstant

function input_gamepad_check_pressed(_index, _gm)
{
    if (_index < 0) return 0.0;
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.get_pressed(_gm);
}