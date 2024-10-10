// Feather disable all

/// Returns whether a device is a gamepad. This function will still return `true` for gamepads that
/// are not connected.
/// 
/// @param {Real} device

function InputDeviceIsGamepad(_device)
{
    return (_device >= 0);
}