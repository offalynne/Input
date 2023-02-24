function __input_binding_get_label(_type, _value, _axis_negative)
{
    if (__INPUT_TOUCH_SUPPORT && (os_type != os_windows))
    {
        //Touch bindings
        if (__INPUT_ON_PS)
        {
            if (((_type == __INPUT_BINDING_GAMEPAD_BUTTON) && (_value == gp_select))
            ||  ((_type == __INPUT_BINDING_MOUSE_BUTTON  ) && (_value == mb_left  )))
            {
                return "gamepad touchpad click";
            }
        }
        else if ((_type == __INPUT_BINDING_MOUSE_BUTTON) && (_value == mb_left))
        {
            return "touchscreen press";
        }
    }
    
    switch(_type)
    {
        case __INPUT_BINDING_KEY:
            return __input_key_get_name(_value);
        break;
        
        case __INPUT_BINDING_MOUSE_BUTTON:
            switch(_value)
            {
                case mb_left:    return "mouse button left";    break;
                case mb_middle:  return "mouse button middle";  break;
                case mb_right:   return "mouse button right";   break;
                case mb_side1:   return "mouse button back";    break;
                case mb_side2:   return "mouse button forward"; break;
                
                default: return "mouse button unknown"; break;
            }
        break;
        
        case __INPUT_BINDING_MOUSE_WHEEL_UP:
            return "mouse wheel up";
        break;
        
        case __INPUT_BINDING_MOUSE_WHEEL_DOWN:
            return "mouse wheel down";
        break;
        
        case __INPUT_BINDING_GAMEPAD_BUTTON:
        case __INPUT_BINDING_GAMEPAD_AXIS:
            switch(_value)
            {
                case gp_face1:      return "gamepad face south";         break; //Xbox A, Nintendo B, PlayStation Cross
                case gp_face2:      return "gamepad face east";          break; //Xbox B, Nintendo A, PlayStation Circle
                case gp_face3:      return "gamepad face west";          break; //Xbox X, Nintendo Y, PlayStation Square
                case gp_face4:      return "gamepad face north";         break; //Xbox Y, Nintendo X, PlayStation Triangle
                case gp_shoulderl:  return "gamepad shoulder l";         break;
                case gp_shoulderr:  return "gamepad shoulder r";         break;
                case gp_shoulderlb: return "gamepad trigger l";          break;
                case gp_shoulderrb: return "gamepad trigger r";          break;
                case gp_select:     return "gamepad select";             break;
                case gp_start:      return "gamepad start";              break;
                case gp_stickl:     return "gamepad thumbstick l click"; break;
                case gp_stickr:     return "gamepad thumbstick r click"; break;
                case gp_padu:       return "gamepad dpad up";            break;
                case gp_padd:       return "gamepad dpad down";          break;
                case gp_padl:       return "gamepad dpad left";          break;
                case gp_padr:       return "gamepad dpad right"          break;
                
                case gp_guide:      return "gamepad guide";              break;
                case gp_misc1:      return "gamepad misc 1";             break;
                case gp_touchpad:   return "gamepad touchpad click";     break;
                case gp_paddle1:    return "gamepad paddle 1";           break;
                case gp_paddle2:    return "gamepad paddle 2";           break;
                case gp_paddle3:    return "gamepad paddle 3";           break;
                case gp_paddle4:    return "gamepad paddle 4";           break;

                case gp_axislh: return _axis_negative? "gamepad thumbstick l left" : "gamepad thumbstick l right"; break;
                case gp_axislv: return _axis_negative? "gamepad thumbstick l up"   : "gamepad thumbstick l down";  break;
                case gp_axisrh: return _axis_negative? "gamepad thumbstick r left" : "gamepad thumbstick r right"; break;
                case gp_axisrv: return _axis_negative? "gamepad thumbstick r up"   : "gamepad thumbstick r down";  break;
                
                default: return "gamepad input unknown"; break;
            }
        break;
        
        case __INPUT_BINDING_VIRTUAL_BUTTON:
            return "virtual button";
        break;
        
        default:
            return "binding unknown";
        break;
    }
}
