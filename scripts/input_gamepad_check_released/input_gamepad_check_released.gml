/// @desc    Checks if the given button/axis is newly deactivated this frame
/// @param   gamepadIndex
/// @param   GMconstant

function input_gamepad_check_released(_index, _gm)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if ((!INPUT_ALLOW_OUT_OF_FOCUS && !_global.__window_focus)
    ||  _global.__cleared
    ||  (_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepads)))
    {
        return false;
    }
    
    var _gamepad = _global.__gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.get_released(_gm);
}