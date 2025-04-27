// Feather disable all

/// Returns whether any gamepad is connected.

function InputDeviceGetAnyGamepadConnected()
{
    static _gamepadArray = __InputSystem().__gamepadArray;
    
    if (INPUT_BAN_GAMEPADS) return false;
    
    var _i = 0;
    repeat(array_length(_gamepadArray))
    {
        if (InputDeviceIsConnected(_i)) return true;
        ++_i;
    }
    
    return false;
}