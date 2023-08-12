// Feather disable all
/// @desc    Returns the difference in value between this frame and the previous frame for the given button/axis
/// @param   gamepadIndex
/// @param   GMconstant

function input_gamepad_delta(_index, _gm)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if ((_global.__cleared)
    ||  (_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepads)))
    {
        return false;
    }
    
    var _gamepad = _global.__gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.get_delta(_gm);
}
