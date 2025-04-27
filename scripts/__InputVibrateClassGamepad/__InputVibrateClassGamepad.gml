// Feather disable all

/// @param device

function __InputVibrateClassGamepad(_device) constructor
{
    __device = _device;
    
    __supported = false;
    
    __vibrating = false;
    __left      = 0;
    __right     = 0;
    
    __calibrationStrength = 1;
    
    //device < 4 = XInput
    if ((INPUT_ON_WINDOWS && (__device < 4)) || (not INPUT_ON_WINDOWS))
    {
        __supported = true;
        
        if (INPUT_ON_PS5)
        {
            ps5_gamepad_set_vibration_mode(__device, ps5_gamepad_vibration_mode_compatible);
        }            
        else
        {
            var _gamepadType = InputDeviceGetGamepadType(__device);
            if ((INPUT_ON_WINDOWS || INPUT_ON_SWITCH)
            &&  ((_gamepadType == INPUT_GAMEPAD_TYPE_SWITCH)
              || (_gamepadType == INPUT_GAMEPAD_TYPE_JOYCON_LEFT)
              || (_gamepadType == INPUT_GAMEPAD_TYPE_JOYCON_RIGHT)))
            {
                __calibrationStrength = INPUT_VIBRATION_JOYCON_STRENGTH;
            }
        }
        
        InputVibrateDirect(__device, 0, 0);
    }
    
    
    static __Update = function()
    {
        if (InputGameHasFocus() && __supported && __vibrating)
        {
            InputVibrateDirect(__device, __calibrationStrength*__left, __calibrationStrength*__right);
            __vibrating = false;
        }
        else
        {
            InputVibrateDirect(__device, 0, 0);
        }
    };
}