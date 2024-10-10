// Feather disable all

/// Stops rebinding for all devices.

function InputDeviceStopAllRebinding()
{
    var _array = InputDeviceEnumerate(false);
    var _i = 0;
    repeat(array_length(_array))
    {
        InputDeviceSetRebinding(_i, false);
        ++_i;
    }
}