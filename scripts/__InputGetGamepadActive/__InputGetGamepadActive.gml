// Feather disable all

function __InputGetGamepadActive(_device)
{
    static _gamepadArray = __InputSystem().__gamepadArray;
    
    if (INPUT_BAN_GAMEPADS) return false;
    
    if (_device < 0) return false;
    if (not InputGameHasFocus()) return false;
    if (not InputDeviceIsConnected(_device)) return false;
    if (not gamepad_is_connected(_device)) return false;
    
    with(_gamepadArray[_device])
    {
        var _readArray = __readArray;
        
        var _prevValueArray = __prevValueArray; //Thumbsticks only
        var _valueArray     = __valueArray; //Thumbsticks only
        
        var _binding = INPUT_GAMEPAD_BINDING_MIN;
        repeat(INPUT_GAMEPAD_BINDING_COUNT)
        {
            if ((_binding == gp_axislh) || (_binding == gp_axislv) || (_binding == gp_axisrh) || (_binding == gp_axisrv))
            {
                if (INPUT_GAMEPAD_THUMBSTICK_REPORTS_ACTIVE)
                {
                    if ((abs(_prevValueArray[_binding - gp_axislh]) <= INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD)
                    &&  (abs(_valueArray[_binding - gp_axislh]) > INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD))
                    {
                        return true;
                    }
                }
            }
            else if ((_binding == gp_shoulderlb) || (_binding == gp_shoulderrb))
            {
                if (INPUT_GAMEPAD_TRIGGER_REPORTS_ACTIVE)
                {
                    if (abs(_readArray[_binding - INPUT_GAMEPAD_BINDING_MIN](_device, _binding)) > INPUT_GAMEPAD_TRIGGER_MIN_THRESHOLD)
                    {
                        return true;
                    }
                }
            }
            else 
            {
                if (_readArray[_binding - INPUT_GAMEPAD_BINDING_MIN](_device, _binding))
                {
                    return true;
                }
            }
            
            ++_binding;
        }
    }
    
    return false;
}