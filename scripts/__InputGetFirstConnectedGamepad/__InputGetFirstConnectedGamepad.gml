// Feather disable all

function __InputGetFirstConnectedGamepad()
{
    var _i = 0;
    repeat(gamepad_get_device_count())
    {
        if (InputDeviceIsConnected(_i))
        {
            return _i;
        }
        
        ++_i;
    }
    
    return INPUT_NO_DEVICE;
}