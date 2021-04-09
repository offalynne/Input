/// @param binding

function input_binding_get_name(_binding)
{
    if (!input_value_is_binding(_binding)) return undefined;
    
    with(_binding)
    {
        switch(type)
        {
            case "key":
                return __input_key_get_name(value);
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
                    case gp_shoulderrb: return "gamepad button trigger r";          break;
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
                    case gp_shoulderrb: return "gamepad axis trigger r"; break;
                    
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
