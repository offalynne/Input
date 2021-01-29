/// @param gamepadIndex

function input_gamepad_get_type(_index)
{
    if (_index < 0) return "unknown";
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return "unknown";
    return _gamepad.type;
}