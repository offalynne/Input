// Feather disable all

/// Directly sets the vibration values for a device. This should typically be ignored in favour of
/// the other vibration functions (InputVibrateConstant() etc.) but many occasionally be useful.

function InputVibrateDirect(_device, _left, _right)
{
    if (INPUT_ON_SWITCH)
    {
        var _gamepadType = InputDeviceGetGamepadType(_device);
        if ((_gamepadType == INPUT_GAMEPAD_TYPE_JOYCON_LEFT) || (_gamepadType == INPUT_GAMEPAD_TYPE_JOYCON_RIGHT))
        {
            //Documentation said to use switch_controller_motor_single for these two controller types but I'll be damned if I can feel any difference!
            switch_controller_vibrate_hd(_device, switch_controller_motor_single, max(_left, _right), 250, max(_left, _right), 160);
        }
        else
        {
            switch_controller_vibrate_hd(_device, switch_controller_motor_left,  _left,  250, _left,  160);
            switch_controller_vibrate_hd(_device, switch_controller_motor_right, _right, 250, _right, 160);
        }
    }
    else
    {
        var _steamHandle = InputDeviceGetSteamHandle(_device);
        if (_steamHandle != undefined)
        {
            steam_input_trigger_vibration(_steamHandle, 65535*_left, 65535*_right);
        }
        else if (INPUT_FIX_PS_NATIVE_VIBRATION_SIDE && (INPUT_ON_PS4 || INPUT_ON_PS5))
        {
            gamepad_set_vibration(_device, _right, _left);
        }
        else
        {
            gamepad_set_vibration(_device, _left, _right);
        }
    }
}