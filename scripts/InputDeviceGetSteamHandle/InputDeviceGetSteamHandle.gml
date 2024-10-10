// Feather disable all

/// Return the Steam handle associated with a device. If the device isn't a gamepad this function
/// will return `undefined`. If Steamworks has not been initialized (or isn't in the project),
/// this function will return `undefined`. Finally, if Steam Input is not actively managing the
/// gamepad then this function will return `undefined`.
/// 
/// @param {Real} device

function InputDeviceGetSteamHandle(_device)
{
    static _gamepadArray = __InputSystem().__gamepadArray;
    
    if (_device < 0) return undefined;
    
    return InputDeviceIsConnected(_device)? _gamepadArray[_device].__steamHandle : undefined;
}