/// @param binding

function input_binding_get_name(_binding)
{
    if (!input_value_is_binding(_binding)) return undefined;
    
    with(_binding)
    {
        switch(type)
        {
            case "key":
                if ((value >= ord("A")) && (value <= ord("Z")))
                {
                    //Latin letters
                    return chr(value);
                }
                else if ((value >= vk_f1) && (value <= vk_f12))
                {
                    //Function keys
                    return ("F" + string(1 + value - vk_f1));
                }
                else if (value >= ord("0")) && (value <= ord("9"))
                {
                    //Top row number keys
                    return chr(value);
                }
                else 
                {
                    switch(value)
                    {
                        //Symbols
                        case 186: return ";";  break;
                        case 187: return "=";  break;
                        case 188: return ",";  break;
                        case 189: return "-";  break;
                        case 190: return ".";  break;
                        case 191: return "/";  break;
                        case 192: return "'";  break;
                        case 219: return "[";  break;
                        case 220: return "\\"; break;
                        case 221: return "]";  break;
                        case 222: return "#";  break;
                        case 223: return "`";  break;
                        
                        //Numpad
                        case vk_numpad0:  return "numpad 0"; break;
                        case vk_numpad1:  return "numpad 1"; break;
                        case vk_numpad2:  return "numpad 2"; break;
                        case vk_numpad3:  return "numpad 3"; break;
                        case vk_numpad4:  return "numpad 4"; break;
                        case vk_numpad5:  return "numpad 5"; break;
                        case vk_numpad6:  return "numpad 6"; break;
                        case vk_numpad7:  return "numpad 7"; break;
                        case vk_numpad8:  return "numpad 8"; break;
                        case vk_numpad9:  return "numpad 9"; break;
                        case vk_divide:   return "numpad /"; break;
                        case vk_decimal:  return "numpad ."; break;
                        case vk_multiply: return "numpad *"; break;
                        case vk_add:      return "numpad +"; break;
                        case vk_subtract: return "numpad -"; break;
                        
                        //Command keys
                        case vk_rshift: return "right shift"; break;
                        case vk_lshift: return "left shift";  break;
                        case vk_shift:  return "shift";       break;
                        
                        case vk_rcontrol: return "right ctrl"; break;
                        case vk_lcontrol: return "left ctrl";  break;
                        case vk_control:  return "ctrl";       break;
                        
                        case vk_ralt: return "right alt"; break;
                        case vk_lalt: return "left alt";  break;
                        case vk_alt:  return "alt";       break;
                        
                        case vk_up:    return "arrow up";    break;
                        case vk_down:  return "arrow down";  break;
                        case vk_left:  return "arrow left";  break;
                        case vk_right: return "arrow right"; break;
                        
                        case vk_escape:    return "escape";    break;
                        case vk_backspace: return "backspace"; break;
                        case vk_space:     return "space";     break;
                        case vk_tab:       return "tab";       break;
                        case vk_enter:     return "enter";     break;
                        
                        case vk_home:        return "home";         break;
                        case vk_end:         return "end";          break;
                        case vk_insert:      return "insert";       break;
                        case vk_delete:      return "delete";       break;
                        case vk_pagedown:    return "page down";    break;
                        case vk_pageup:      return "page up";      break;
                        case vk_printscreen: return "print screen"; break;
                        case vk_pause:       return "pause break";  break;
                        
                        //Weirdo keys
                        case  12: return "clear";      break; //Numpad 5 key, but with numlock off. Did you know this key existed? I didn't
                        case  20: return "capslock";   break;
                        case  91: return "windows";    break;
                        case  93: return "menu";       break;
                        case 144: return "numlock";    break;
                        case 145: return "scrolll lock"; break;
                    }
                    
                    return chr(value); //Fallback
                }
            break;
            
            case "mouse button":
                switch(value)
                {
                    case mb_left:   return "mouse button left";   break;
                    case mb_middle: return "mouse button middle"; break;
                    case mb_right:  return "mouse button right";  break
                    
                    default: return "mouse button unknown"; break;
                }
            break;
            
            case "mouse wheel up":
                return "mouse wheel up";
            break;
            
            case "mouse wheel down":
                return "mouse wheel down";
            break;
            
            case "gamepad button":
                switch(value)
                {
                    case gp_face1:      return "gamepad button a";                  break;
                    case gp_face2:      return "gamepad button b";                  break;
                    case gp_face3:      return "gamepad button x";                  break;
                    case gp_face4:      return "gamepad button y";                  break;
                    case gp_shoulderl:  return "gamepad button shoulder l";         break;
                    case gp_shoulderr:  return "gamepad button shoulder r";         break;
                    case gp_shoulderlb: return "gamepad button trigger l";          break;
                    case gp_shoulderrb: return "gamepad button trigger b";          break;
                    case gp_select:     return "gamepad button select";             break;
                    case gp_start:      return "gamepad button start";              break;
                    case gp_stickl:     return "gamepad button thumbstick l click"; break;
                    case gp_stickr:     return "gamepad button thumbstick r click"; break;
                    case gp_padu:       return "gamepad button dpad up";            break;
                    case gp_padd:       return "gamepad button dpad down";          break;
                    case gp_padl:       return "gamepad button dpad left";          break;
                    case gp_padr:       return "gamepad button dpad right"          break;
                    case gp_guide:      return "gamepad button guide";              break;
                    case gp_misc1:      return "gamepad button misc 1";             break;
                    
                    case gp_axislh: return axis_negative? "gamepad button thumbstick l left" : "gamepad button thumbstick l right"; break;
                    case gp_axislv: return axis_negative? "gamepad button thumbstick l up"   : "gamepad button thumbstick l down";  break;
                    case gp_axisrh: return axis_negative? "gamepad button thumbstick l left" : "gamepad button thumbstick l right"; break;
                    case gp_axisrv: return axis_negative? "gamepad button thumbstick l up"   : "gamepad button thumbstick l down";  break;
                    
                    default: return "gamepad button unknown"; break;
                }
            break;
            
            case "gamepad axis":
                switch(value)
                {
                    case gp_shoulderlb: return "gamepad axis trigger l"; break;
                    case gp_shoulderrb: return "gamepad axis trigger b"; break;
                    
                    case gp_axislh: return axis_negative? "gamepad axis thumbstick l left" : "gamepad axis thumbstick l right"; break;
                    case gp_axislv: return axis_negative? "gamepad axis thumbstick l up"   : "gamepad axis thumbstick l down";  break;
                    case gp_axisrh: return axis_negative? "gamepad axis thumbstick r left" : "gamepad axis thumbstick r right"; break;
                    case gp_axisrv: return axis_negative? "gamepad axis thumbstick r up"   : "gamepad axis thumbstick r down";  break;
                    
                    default: return "gamepad axis unknown"; break;
                }
            break;
        }
    }
}