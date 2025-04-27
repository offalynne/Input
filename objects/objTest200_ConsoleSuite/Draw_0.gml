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
        _string += string_concat("Device Indx = ", _device, "\n");
        _string += string_concat("Description = \"", InputDeviceGetDescription(_device), "\"\n");
        _string += string_concat("Gamepad type = ", gamepadTypeMap[? InputDeviceGetGamepadType(_device)] ?? "?!", "\n\n");
        
        if (InputVibrateGetSupported())
        {
            _string += "VIBRATE TEST:\n";
            _string += "gp_shoulderl = Vibrate left\n";
            _string += "gp_shoulderr = Vibrate right\n\n";
        }
        
        if (InputColorSupportedByDevice())
        {
            _string += "COLOR TEST:\n";
            _string += "Color = " + string(InputColorGet()) + "\n";
            _string += "gp_face1 = Red\n";
            _string += "gp_face2 = Yellow\n";
            _string += "gp_face3 = Lime\n";
            _string += "gp_face4 = Blue\n";
            _string += "gp_start = Reset\n\n";
        }
        
        if (InputTriggerEffectGetSupported())
        {
            _string += "TRIGGER EFFECT TEST:\n";
            _string += "Left trigger effect state = " + (triggerEffectMap[? InputTriggerEffectGetState(gp_shoulderlb)] ?? "?!") + "\n";
            _string += "Right trigger effect state = " + (triggerEffectMap[? InputTriggerEffectGetState(gp_shoulderrb)] ?? "?!") + "\n";
            _string += "gp_padu = Left trigger effect = off\n";
            _string += "gp_padl = Left trigger effect = weapon\n";
            _string += "gp_padd = Right trigger effect = off\n";
            _string += "gp_padr = Right trigger effect = weapon\n\n";
        }
        
        _string += "INPUT TEST:\n";
        _string += "Press buttons and axes on the gamepad to confirm behavior\n";
        var _i = INPUT_GAMEPAD_BINDING_MIN;
        repeat(1 + INPUT_GAMEPAD_BINDING_MAX - INPUT_GAMEPAD_BINDING_MIN)
        {
            if (abs(InputDeviceGetGamepadValue(_device, _i)) >= 0.1)
            {
                _string += string_concat(bindingMap[? _i] ?? "?!", " = ", InputDeviceGetGamepadValue(_device, _i), "\n");
            }
            
            ++_i;
        }
        
        var _stringB = "RAW INPUT DATA:\n";
        _stringB += "Press buttons and axes on the gamepad to see raw values\n";

        var _i = 0;
        repeat(100)
        {
            if (abs(gamepad_button_value(_device, _i)) > 0.1)
            {
                _stringB += string_concat("b", _i, " = ", gamepad_button_value(_device, _i), "\n");
            }
            
            ++_i;
        }

        var _i = 0;
        repeat(100)
        {
            if (abs(gamepad_axis_value(_device, _i)) > 0.1)
            {
                _stringB += string_concat("a", _i, " = ", gamepad_axis_value(_device, _i), "\n");
            }
            
            ++_i;
        }
        
        draw_text(room_width/2, 10, _stringB);
    }
    else
    {
        _string += "Player device is not a gamepad\nPress a button on a gamepad to hotswap to it";
    }
}

draw_text(10, 10, _string);