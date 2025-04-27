// Feather disable all

function __InputGetGamepadActive(_device)
{
    if (INPUT_BAN_GAMEPADS) return false;
    
    if (_device < 0) return false;
    if (not InputDeviceIsConnected(_device)) return false;
    if (not gamepad_is_connected(_device)) return false;
    
    var _readArray = __InputGamepadGetReadArray(_device);
    
    var _binding = INPUT_GAMEPAD_BINDING_MIN;
    repeat(1 + INPUT_GAMEPAD_BINDING_MAX - INPUT_GAMEPAD_BINDING_MIN)
    {
        if ((((_binding != gp_axislh) && (_binding != gp_axislv) && (_binding != gp_axisrh) && (_binding != gp_axisrv)) || INPUT_GAMEPAD_THUMBSTICK_REPORTS_ACTIVE)
        &&  (((_binding != gp_shoulderlb) && (_binding != gp_shoulderrb)) || INPUT_GAMEPAD_TRIGGER_REPORTS_ACTIVE))
        {
            if (abs(_readArray[_binding - INPUT_GAMEPAD_BINDING_MIN](_device, _binding)) > INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD)
            {
                return true;
            }
        }
        
        ++_binding;
    }
    
    return false;
}