// Feather disable all

/// Returns if a device has not been assigned to any players and is available for use. This
/// function will return `false` for devices that are unsupported on the current platform (e.g.
/// keyboard on Xbox Series X). `INPUT_GENERIC_DEVICE` can be assigned to multiple players at
/// the same time and as such this function will always return `true` for `INPUT_GENERIC_DEVICE`.
/// 
/// @param {Real} device

function InputDeviceIsAvailable(_device)
{
    static _deviceMap = __InputSystem().__deviceMap;
    
    if (_device == INPUT_NO_DEVICE) return false;
    if ((_device >= 0) && INPUT_BAN_GAMEPADS) return false;
    if ((_device == INPUT_KBM) && INPUT_BAN_KBM) return false;
    if ((_device == INPUT_TOUCH) && INPUT_BAN_TOUCH) return false;
    if (_device == INPUT_GENERIC_DEVICE) return true;
    
    return (not ds_map_exists(_deviceMap, _device));
}