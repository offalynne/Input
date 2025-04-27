// Feather disable all

/// Returns whether the device is currently set to scan for new bindings.
/// 
/// @param {Real} device

function InputDeviceGetRebinding(_device)
{
    static _rebindingMap = __InputSystem().__rebindingMap;
    return _rebindingMap[? _device] ?? false;
}