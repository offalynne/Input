/// @desc    Returns the analogue value of the given input (after applying SDL axis remapping)
/// @param   gamepadIndex
/// @param   GMconstant

function input_gamepad_value(_index, _gm)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if ((!INPUT_ALLOW_OUT_OF_FOCUS && !_global.__window_focus)
    ||  (_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepads)))
    {
        return 0.0;
    }
    
    var _gamepad = _global.__gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.get_value(_gm);
}