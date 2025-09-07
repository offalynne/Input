// Feather disable all

/// Variant of the device activity getter that only checks gamepad and keyboard input and
/// additionally excludes devices that are pressing the leave verb.
/// 
/// @param leaveVerb
/// @param playerIndex

function __InputPartyDeviceGetNewActivity(_leaveVerb, _playerIndex)
{
    var _array = InputDeviceEnumerate(false);
    var _i = 0;
    repeat(array_length(_array))
    {
        var _device = _array[_i];
        
        if (InputDeviceIsAvailable(_device)
        &&  __InputPartyDeviceIsActive(_device)
        &&  (not InputDeviceCheckViaPlayer(_device, _leaveVerb, _playerIndex)))
        {
            return _device;
        }
        
        ++_i;
    }
    
    return INPUT_NO_DEVICE;
}