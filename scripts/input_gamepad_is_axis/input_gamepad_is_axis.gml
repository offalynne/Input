// Feather disable all
/// @desc    Returns whether the given gp_* constant is mapped as an analogue input
/// @param   gamepadIndex
/// @param   {Constant.GamepadAxis|Constant.GamepadButton} GMconstant

function input_gamepad_is_axis(_index, _gm)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if ((_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepads)))
    {
        return false;
    }
    
    var _gamepad = _global.__gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.__is_axis(_gm);
}
