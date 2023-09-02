//Feather disable all

function __input_gamepad_value_internal(_index, _gm)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if ((_index == undefined) || (_index < 0) || (_index >= array_length(_global.__gamepads)))
    {
        return 0.0;
    }
    
    var _gamepad = _global.__gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    return _gamepad.get_value(_gm);
}
