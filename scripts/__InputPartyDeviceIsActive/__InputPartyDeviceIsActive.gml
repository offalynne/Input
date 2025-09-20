// Feather disable all

/// Variant of the device activity getter that only checks gamepad and keyboard input.
/// 
/// @param device

function __InputPartyDeviceIsActive(_device)
{
    static _system = __InputSystem();
    if (not _system.__windowFocus) return false;
    
    if (_device >= 0)
    {
        if (not INPUT_BAN_GAMEPADS)
        {
            return __InputGetGamepadActive(_device, false, false);
        }
    }
    else if (_device == INPUT_KBM)
    {
        if (not INPUT_BAN_KBM)
        {
            if (__InputGetKeyboardActive()) return true;
        }
    }
    
    return false;
}