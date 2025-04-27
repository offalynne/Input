// Feather disable all

/// Returns the first available (i.e. unassigned) device that has activity on it.

function InputDeviceGetNewActivity()
{
    var _array = InputDeviceEnumerate(false);
    var _i = 0;
    repeat(array_length(_array))
    {
        var _device = _array[_i];
        if (InputDeviceIsAvailable(_device) && InputDeviceIsActive(_device))
        {
            return _device;
        }
        
        ++_i;
    }
    
    return INPUT_NO_DEVICE;
}