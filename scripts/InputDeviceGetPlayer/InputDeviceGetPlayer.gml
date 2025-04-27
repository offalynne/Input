// Feather disable all

/// Returns the player assigned to a device. This function will return `undefined` if no plauyer is
/// is using the device. INPUT_GENERIC_DEVICE will always return `undefined` as multiple players
/// can use that "device" at the same time.
/// 
/// @param {Real} device

function InputDeviceGetPlayer(_device)
{
    static _deviceMap = __InputSystem().__deviceMap;
    return _deviceMap[? _device];
}