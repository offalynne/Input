// Feather disable all

/// Returns the current value being emitted from a binding for a gamepad. If the device isn't
/// connected or isn't a gamepad then this function returns 0. This function will return 0 on
/// platforms where the library does not support gamepads.
/// 
/// @param {Real} device
/// @param {Any} binding

function InputDeviceGetGamepadValue(_device, _binding)
{
    static _gamepadArray = __InputSystem().__gamepadArray;
    
    if (_device < 0) return 0;
    if (not InputGameHasFocus()) return 0;
    if (not InputDeviceIsConnected(_device)) return 0;
    if (not gamepad_is_connected(_device)) return 0;
    
    return _gamepadArray[_device].__valueArray[_binding - INPUT_GAMEPAD_BINDING_MIN];
}