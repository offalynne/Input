// Feather disable all

/// Returns whether the given mouse button is newly pressed this frame.
/// 
/// @param {Constant.MouseButton,Real} [binding=mb_left]

function InputMousePressed(_binding = mb_left)
{
    static _system = __InputSystem();
    if (INPUT_BLOCK_MOUSE_CHECKS || _system.__pointerBlocked) return false;
    
    if not ((_binding == mb_left) || (_binding == mb_any) || (_binding == mb_none))
    {
        //Extended mouse buttons
        return device_mouse_check_button_pressed(0, _binding);
    }
    
    if (INPUT_ON_WINDOWS && _system.__tapClick)
    {
        //Trackpad
        
        var _left = true;
    }
    else if (INPUT_ON_MOBILE)
    {
        //Touch
        
        //Edge testing
        if (INPUT_TOUCH_EDGE_DEADZONE > 0)
        {
            var _x = device_mouse_x_to_gui(0);
            var _y = device_mouse_y_to_gui(0);
            
            if ((_x < INPUT_TOUCH_EDGE_DEADZONE) || (_x > (display_get_gui_width()  - INPUT_TOUCH_EDGE_DEADZONE))
            ||  (_y < INPUT_TOUCH_EDGE_DEADZONE) || (_y > (display_get_gui_height() - INPUT_TOUCH_EDGE_DEADZONE)))
            {
                var _left = false;
            }
            else
            {
                var _left = device_mouse_check_button_pressed(0, mb_left);
            }
        }
    }
    else
    {
        //Mouse
        
        var _left = device_mouse_check_button_pressed(0, mb_left);
    }
    
    switch(_binding)
    {
        case mb_none: return !_left && device_mouse_check_button_pressed(0, mb_none); break;
        case mb_any:  return  _left || device_mouse_check_button_pressed(0, mb_any);  break;
        case mb_left: return  _left;                                                  break;
    }
        
    __InputError("Mouse button out of range (", _binding, ")");
    
    return false;
}
