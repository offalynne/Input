// Feather disable all

/// @param device

function __InputGamepadGetReadArray(_device)
{
    static _gamepadArray     = __InputSystem().__gamepadArray;
    static _genericReadArray = __InputSystem().__genericReadArray;
    
    if ((_device < 0) || (_device >= array_length(_gamepadArray))) return _genericReadArray;
    
    return _gamepadArray[_device].__readArray;
}