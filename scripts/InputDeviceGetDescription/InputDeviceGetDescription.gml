// Feather disable all

/// Returns a description for a device. If the device is a gamepad then the library will attempt to
/// return a useful description.
/// 
/// N.B. Device descriptions should not be used for gameplay logic and should instead be limited to
///      informing the player (or used for debug purposes).
/// 
/// @param {Real} device

function InputDeviceGetDescription(_device)
{
    static _gamepadArray = __InputSystem().__gamepadArray;
    
    if (_device >= 0)
    {
        if (_device < 0) return string_concat("gamepad ", _device);
        if (not InputDeviceIsConnected(_device)) return string_concat("gamepad ", _device);
        
        var _gamepad = _gamepadArray[_device];
        if ((_gamepad == undefined) || _gamepad.__blocked) return string_concat("gamepad ", _device);
        
        return _gamepad.__description;
    }
    else if (_device == INPUT_KBM)
    {
        return "keyboard & mouse";
    }
    else if (_device == INPUT_TOUCH)
    {
        return "touch";
    }
    else if (_device == INPUT_GENERIC_DEVICE)
    {
        return "generic";
    }
    
    return "no device";
}