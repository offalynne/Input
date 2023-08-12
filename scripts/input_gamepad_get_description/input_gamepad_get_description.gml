// Feather disable all
/// @desc    Returns the name of the given gamepad (after SDL remapping)
/// @param   gamepadIndex

function input_gamepad_get_description(_index)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if ((_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepads)))
    {
        return "Unknown";
    }
    
    var _gamepad = _global.__gamepads[_index];
    if (!is_struct(_gamepad)) return "Unknown";
    return _gamepad.description;
}
