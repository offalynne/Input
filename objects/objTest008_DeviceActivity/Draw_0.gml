var _deviceArray = InputDeviceEnumerate();

var _string = $"Player device = {InputPlayerGetDevice()} \"{InputDeviceGetDescription(InputPlayerGetDevice())}\"\n";
_string += $"New activity = {InputDeviceGetNewActivity()}\n\n";

var _i = 0;
repeat(array_length(_deviceArray))
{
    var _device = _deviceArray[_i];
    _string += $"Device {_device} \"{InputDeviceGetDescription(_device)}\"\n";
    
    if (InputDeviceIsActive(_device))
    {
        _string += "  Active\n";
    }
    
    if (InputDeviceCheckViaPlayer(_device, INPUT_VERB.ACCEPT))
    {
        _string += "  ACCEPT active\n";
    }
    
    _string += "\n";
    
    ++_i;
}

draw_text(10, 10, _string);