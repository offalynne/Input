// Feather disable all

function __InputGetMouseOutput()
{
    static _system = __InputSystem();
    
    if (INPUT_BLOCK_MOUSE_CHECKS) return undefined;
    
    with(_system)
    {
        if (__pointerBlockedByWindowDefocus)
        {
            //Mouse not alllowed
            return undefined;
        }
        
        if (INPUT_ON_DESKTOP && (not INPUT_ON_WEB))
        {
            //Desktop native
            if (mouse_button != mb_none)
            {
                //Mouse
                return mouse_button;
            }
            
            if (mouse_wheel_up()) return mb_wheel_up;
            if (mouse_wheel_down()) return mb_wheel_down;
            
            if (__tapClick)
            {
                //Trackpad
                return mb_left;
            }
        }
        else
        {
            //Web and non-desktop mouse
            if (device_mouse_check_button(0, mb_side2))  return mb_side2;
            if (device_mouse_check_button(0, mb_side1))  return mb_side1;
            if (device_mouse_check_button(0, mb_middle)) return mb_middle;
            if (device_mouse_check_button(0, mb_right))  return mb_right;
            if (device_mouse_check_button(0, mb_left))   return mb_left;
        }
        
        return undefined;
    }
}
