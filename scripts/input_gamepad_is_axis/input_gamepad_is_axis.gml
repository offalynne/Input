/// @param gamepadIndex
/// @param GMconstant

function input_gamepad_is_axis(_index, _gm)
{
    if ((_index < 0) || (_index >= array_length(global.__input_gamepads))) return false;
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.is_axis(_gm);
}