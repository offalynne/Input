// Feather disable all

//This function is intended for specific *mouse* input i.e. it should exclude touch.

function __InputGetMouseActive()
{
    static _system = __InputSystem();
    
    if (INPUT_BAN_KBM) return false;
    
    if (INPUT_MOUSE_MOVEMENT_REPORTS_ACTIVE)
    {
        with(_system)
        {
            if (point_distance(__prevPointerDeviceX, __prevPointerDeviceY, __pointerDeviceX, __pointerDeviceY) > 3) return true;
        }
    }
    
    if (INPUT_MOUSE_BUTTON_REPORTS_ACTIVE)
    {
        if (mouse_check_button_pressed(mb_left)) return true;
    }
    
    return false;
}