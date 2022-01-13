/// @param gamepadIndex
/// @param GMconstant

function input_gamepad_get_button_label(_index, _gm)
{
    if ((_index < 0) || (_index >= array_length(global.__input_gamepads))) return undefined;
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return undefined;
    return _gamepad.get_button_label(_gm);
}