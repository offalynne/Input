// Feather disable all

/// Returns if a device is active due to a user pressing buttons, moving thumbsticks etc.  There is
/// no timeout on this function and it will return `true` if there is activity at the moment the
/// function is called. INPUT_GENERIC_DEVICE will always return `false`.
/// 
/// @param {Real} device

function InputDeviceIsActive(_device)
{
    static _system = __InputSystem();
    if (not _system.__windowFocus) return false;
    
    if (_device >= 0)
    {
        if (not INPUT_BAN_GAMEPADS)
        {
            return __InputGetGamepadActive(_device);
        }
    }
    else if (_device == INPUT_KBM)
    {
        if (not INPUT_BAN_KBM)
        {
            if (__InputGetKeyboardActive()) return true;
        }
        
        if (not INPUT_BLOCK_MOUSE_CHECKS)
        {
            if (__InputGetMouseActive()) return true;
        }
    }
    else if (_device == INPUT_TOUCH)
    {
        if (not INPUT_BAN_TOUCH)
        {
            //Perform a direct check
            if (mouse_check_button(mb_left)) return true;
        }
    }
    else if (_device == INPUT_GENERIC_DEVICE)
    {
        //Never active
        return false;
    }
    
    return false;
}