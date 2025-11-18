// Feather disable all

/// @param {Real} device

function __InputGamepadHasAnalogueTrigger(_device)
{
    static _gamepadArray = __InputSystem().__gamepadArray;
    
    if (_device < 0) return false;
    if (not InputDeviceIsConnected(_device)) return false;
    
    return _gamepadArray[_device].__hasAnalogueTrigger;
}