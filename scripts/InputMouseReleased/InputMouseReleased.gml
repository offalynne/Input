// Feather disable all

/// Returns whether the given mouse button was newly released this frame.
/// 
/// @param {Constant.MouseButton,Real} [binding=mb_left]

function InputMouseReleased(_binding = mb_left)
{
    static _system = __InputSystem();
    if (INPUT_BLOCK_MOUSE_CHECKS) return false;
    
    //If mouse was blocked this frame then return <true> if the mouse is pressed
    //This means blocking the mouse should fire off a released event
    if (_system.__pointerBlockedByUserThisFrame)
    {
        return __InputMouseCheckRaw(_binding);
    }
    
    if (_system.__pointerBlocked) return false;
    
    if not ((_binding == mb_left) || (_binding == mb_any) || (_binding == mb_none))
    {
        //Extended mouse buttons
        return device_mouse_check_button_released(0, _binding);
    }
    
    if (INPUT_ON_WINDOWS && _system.__tapClick)
    {
        //Trackpad
        
        var _left = true;
    }
    else if (INPUT_ON_MOBILE)
    {
        //Mouse
        
        //Edge testing
        if (INPUT_TOUCH_EDGE_DEADZONE > 0)
        {
            var _x = device_mouse_raw_x(0);
            var _y = device_mouse_raw_y(0);
            
            if ((_x < INPUT_TOUCH_EDGE_DEADZONE) || (_x > (display_get_width()  - INPUT_TOUCH_EDGE_DEADZONE))
            ||  (_y < INPUT_TOUCH_EDGE_DEADZONE) || (_y > (display_get_height() - INPUT_TOUCH_EDGE_DEADZONE)))
            {
                var _left = false;
            }
            else
            {
                var _left = device_mouse_check_button_released(0, mb_left);
            }
        }
    }
    else
    {
        //Mouse
        
        var _left = device_mouse_check_button_released(0, mb_left);
    }
    
    if (_binding == mb_left)
    {
        return _left;
    }
    else if (_binding == mb_any)
    {
        return (_left || device_mouse_check_button_released(0, mb_any));
    }
    else if (_binding == mb_none)
    {
        return ((not _left) && device_mouse_check_button_released(0, mb_none));
    }
    
    __InputError("Mouse button out of range (", _binding, ")");
    
    return false;
}
