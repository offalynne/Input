var _string = "";

if (INPUT_BAN_GAMEPADS)
{
    _string += "Gamepads not supported on this platform";
}
else
{
    var _device = InputPlayerGetDevice();
    if (InputDeviceIsGamepad(_device) && InputDeviceIsConnected(_device))
    {
        _string += string_concat(InputDeviceGetDescription(_device), "\n");
        _string += string_concat("Gamepad type = ", InputDeviceGetGamepadType(_device), "\n\n");
        
        var _i = INPUT_GAMEPAD_BINDING_MIN;
        repeat(1 + INPUT_GAMEPAD_BINDING_MAX - INPUT_GAMEPAD_BINDING_MIN)
        {
            _string += string_concat(_i, " = ", InputDeviceGetGamepadValue(_device, _i), "\n");
            ++_i;
        }
    }
    else
    {
        _string += "No gamepad";
    }
}

draw_text(10, 10, _string);