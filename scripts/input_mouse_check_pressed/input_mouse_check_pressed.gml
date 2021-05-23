/// @param binding
function input_mouse_check_pressed(_binding)
{
    //Extended mouse button handling (Windows only)
    if (os_type != os_windows)
    {
        return (_binding < mb_back && device_mouse_check_button_pressed(0, _binding));   
    }
    else
    {
        var _button  = device_mouse_check_button(0, _binding);
        var _back    = (global.__input_mouse_back    && !global.__input_mouse_back_last);
        var _forward = (global.__input_mouse_forward && !global.__input_mouse_forward_last);
        
        switch (_binding)
        {            
            case mb_any:
                return (_button || global.__input_tap_click || _back || _forward);
            break;

            case mb_left:
                return (_button || global.__input_tap_click);
            break;

            case mb_right:
            case mb_middle:
                return _button;
            break;

            case mb_back:
                return _back;
            break;
                
            case mb_forward:	
                return _forward;
            break;
            
            case mb_none:
                return (_button && !(global.__input_tap_click || _back || _forward));
            break;
        }
    }
    
    __input_error("Mouse button out of range (", _binding, ")");
    return false;
}