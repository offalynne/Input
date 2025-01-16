// Feather disable all
/// @desc    Checks if any gamepad button is newly activated this frame
/// @param   gamepadIndex

function input_gamepad_any_pressed(_index)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
        
    if (!_global.__game_input_allowed
    ||  !_global.__gamepad_allowed
    ||   _global.__cleared
    ||  (_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepads)))
    {
        return false;
    }
    
    var _gamepad = _global.__gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.__get_any_pressed();
}