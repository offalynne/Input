/// This macro toggles binding lookup compat mode to work around https://github.com/JujuAdams/Input/issues/371
/// If you are depending on pre 5.0.4 input_binding_get_label() you need this to be true
#macro INPUT_BINDING_LABEL_COMPAT true

function __input_binding_get_label(_type, _value, _axis_negative)
{
    if(INPUT_BINDING_LABEL_COMPAT) {
        if (__INPUT_TOUCH_SUPPORT)
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

                    case gp_axislh: return  axis_negative? "gamepad thumbstick l left" : "gamepad thumbstick l right"; break;
                    case gp_axislv: return  axis_negative? "gamepad thumbstick l up"   : "gamepad thumbstick l down";  break;
                    case gp_axisrh: return  axis_negative? "gamepad thumbstick r left" : "gamepad thumbstick r right"; break;
                    case gp_axisrv: return  axis_negative? "gamepad thumbstick r up"   : "gamepad thumbstick r down";  break;
                
                    default: return "gamepad input unknown"; break;
                }
            break;
        
            default:
                return "binding unknown";
            break;
        }
    } else {
        if (__INPUT_TOUCH_SUPPORT)
        {
            //Touch bindings
            if (__INPUT_ON_PS)
            {
                if (((_type == __INPUT_BINDING_GAMEPAD_BUTTON) && (_value == gp_select))
                ||  ((_type == __INPUT_BINDING_MOUSE_BUTTON  ) && (_value == mb_left  )))
                {
                    return "gamepad_touchpad_click";
                }
            }
            else if ((_type == __INPUT_BINDING_MOUSE_BUTTON) && (_value == mb_left))
            {
                return "touchscreen_press";
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
                    case mb_left:    return "mouse_button_left";    break;
                    case mb_middle:  return "mouse_button_middle";  break;
                    case mb_right:   return "mouse_button_right";   break;
                    case mb_side1:   return "mouse_button_back";    break;
                    case mb_side2:   return "mouse_button_forward"; break;
                
                    default: return "mouse_button_unknown"; break;
                }
            break;
        
            case __INPUT_BINDING_MOUSE_WHEEL_UP:
                return "mouse_wheel_up";
            break;
        
            case __INPUT_BINDING_MOUSE_WHEEL_DOWN:
                return "mouse_wheel_down";
            break;
        
            case __INPUT_BINDING_GAMEPAD_BUTTON:
            case __INPUT_BINDING_GAMEPAD_AXIS:
                switch(_value)
                {
                    case gp_face1:      return "gamepad_face_south";         break; //Xbox A, Nintendo B, PlayStation Cross
                    case gp_face2:      return "gamepad_face_east";          break; //Xbox B, Nintendo A, PlayStation Circle
                    case gp_face3:      return "gamepad_face_west";          break; //Xbox X, Nintendo Y, PlayStation Square
                    case gp_face4:      return "gamepad_face_north";         break; //Xbox Y, Nintendo X, PlayStation Triangle
                    case gp_shoulderl:  return "gamepad_shoulder_l";         break;
                    case gp_shoulderr:  return "gamepad_shoulder_r";         break;
                    case gp_shoulderlb: return "gamepad_trigger_l";          break;
                    case gp_shoulderrb: return "gamepad_trigger_r";          break;
                    case gp_select:     return "gamepad_select";             break;
                    case gp_start:      return "gamepad_start";              break;
                    case gp_stickl:     return "gamepad_thumbstick_l_click"; break;
                    case gp_stickr:     return "gamepad_thumbstick_r_click"; break;
                    case gp_padu:       return "gamepad_dpad_up";            break;
                    case gp_padd:       return "gamepad_dpad_down";          break;
                    case gp_padl:       return "gamepad_dpad_left";          break;
                    case gp_padr:       return "gamepad_dpad_right"          break;
                
                    case gp_guide:      return "gamepad_guide";              break;
                    case gp_misc1:      return "gamepad_misc_1";             break;
                    case gp_touchpad:   return "gamepad_touchpad_click";     break;
                    case gp_paddle1:    return "gamepad_paddle_1";           break;
                    case gp_paddle2:    return "gamepad_paddle_2";           break;
                    case gp_paddle3:    return "gamepad_paddle_3";           break;
                    case gp_paddle4:    return "gamepad_paddle_4";           break;

                    case gp_axislh: return _axis_negative? "gamepad_thumbstick_l_left" : "gamepad_thumbstick_l_right"; break;
                    case gp_axislv: return _axis_negative? "gamepad_thumbstick_l_up"   : "gamepad_thumbstick_l_down";  break;
                    case gp_axisrh: return _axis_negative? "gamepad_thumbstick_r_left" : "gamepad_thumbstick_r_right"; break;
                    case gp_axisrv: return _axis_negative? "gamepad_thumbstick_r_up"   : "gamepad_thumbstick_r_down";  break;
                
                    default: return "gamepad_input_unknown"; break;
                }
            break;
        
            default:
                return "binding_unknown";
            break;
        }
    }
}
