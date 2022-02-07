/// @param gamepadIndex
/// @param GMconstant

function input_gamepad_get_button_color(_index, _gm)
{
    if ((_index < 0) || (_index >= array_length(global.__input_gamepads))) return "unknown";
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return "unknown";
    var _color = _gamepad.get_button_color(_gm);
    return ((_color == undefined) ? "unknown" : _color);
}
