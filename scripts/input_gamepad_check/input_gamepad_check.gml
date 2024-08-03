// Feather disable all
/// @desc    Checks if the given button/axis is currently activated on the given gamepad
/// @param   gamepadIndex
/// @param   {Constant.GamepadAxis|Constant.GamepadButton} GMconstant

function input_gamepad_check(_index, _gm)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!_global.__game_input_allowed
    ||  !_global.__gamepad_allowed
    ||  (_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepads)))
    {
        return false;
    }
    
    var _gamepad = _global.__gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.__get_held(_gm);
}
