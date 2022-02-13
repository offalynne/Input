/// @param gamepadIndex
/// @param GMconstant

function input_gamepad_get_button_label(_index, _gm)
{
    if ((_index < 0) || (_index >= array_length(global.__input_gamepads))) return "unknown";
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return "unknown";
    var _label = _gamepad.get_button_label(_gm);
    return ((_label == undefined) ? "unknown" : _label);
}