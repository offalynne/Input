// Feather disable all

/// Returns whether the device is connected to the system as a whole. This function will return
///`false` for devices that are unsupported on the current platform (e.g. keyboard on Xbox Series
/// X). If a gamepad has been blocked due to incompatibility, this function will return `false`.
/// 
/// @param {Real} device

function InputDeviceIsConnected(_device)
{
    static _gamepadArray = __InputSystem().__gamepadArray;
    
    if (_device >= 0)
    {
        if (INPUT_BAN_GAMEPADS || (_device >= array_length(_gamepadArray))) return false;
        
        var _struct = _gamepadArray[_device];
        return ((_struct != undefined) && (not _struct.__blocked));
    }
    else if (_device == INPUT_KBM)
    {
        return (not INPUT_BAN_KBM);
    }
    else if (_device == INPUT_TOUCH)
    {
        return ((not INPUT_BAN_TOUCH) || (INPUT_ALLOW_TOUCH_ON_DESKTOP && INPUT_ON_DESKTOP));
    }
    else if (_device == INPUT_GENERIC_DEVICE)
    {
        return true;
    }
    
    return false;
}