// Feather disable all

/// Returns a discovered binding emitted from the device. This function will return `undefined`
/// if no new binding is detected or the device is not currently being scanned for new bindings.
/// 
/// N.B. This function will return a negative value if a thumbstick push is left or up e.g.
///      `-gp_axislv` is an upwards push on the left thumbstick.
/// 
/// @param {Real} device

function InputDeviceGetRebindingResult(_device)
{
    static _rebindingMap = __InputSystem().__rebindingMap;
    
    var _handler = _rebindingMap[? _device];
    return (_handler == undefined)? undefined : _handler.__rebindingResult;
}