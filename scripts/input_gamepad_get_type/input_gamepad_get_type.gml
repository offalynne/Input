/// @desc    Returns the gamepad type as a string (after SDL remapping)
/// @param   gamepadIndex

function input_gamepad_get_type(_index)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if ((_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepads)))
    {
        return INPUT_GAMEPAD_TYPE_UNKNOWN;
    }
    
    var _gamepad = _global.__gamepads[_index];
    if (!is_struct(_gamepad)) return INPUT_GAMEPAD_TYPE_UNKNOWN;
    return _gamepad.simple_type;
}