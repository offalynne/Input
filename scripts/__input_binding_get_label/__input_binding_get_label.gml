function __input_binding_get_label(_type, _value, _axis_negative)
{
    switch(_type)
    {
        case "key":
            return __input_key_get_name(_value);
        break;
        
        case "mouse button":
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
        
        case "mouse wheel up":
            return "mouse wheel up";
        break;
        
        case "mouse wheel down":
            return "mouse wheel down";
        break;
        
        case "gamepad axis":
        case "gamepad button":
            switch(_value)
            {
                case gp_face1:      return "gamepad button south";           break; // xbox A
                case gp_face2:      return "gamepad button east";            break; // xbox B
                case gp_face3:      return "gamepad button west";            break; // xbox X
                case gp_face4:      return "gamepad button north";           break; // xbox Y
                case gp_select:     return "gamepad button select";          break;
                case gp_start:      return "gamepad button start";           break;
                case gp_guide:      return "gamepad button guide";           break;
                
                case gp_misc1:      return _type + " misc 1";                break;
                case gp_shoulderl:  return _type + " shoulder l";            break;
                case gp_shoulderr:  return _type + " shoulder r";            break;
                case gp_shoulderlb: return _type + " trigger l";             break;
                case gp_shoulderrb: return _type + " trigger r";             break;
                case gp_stickl:     return _type + " thumbstick l click";    break;
                case gp_stickr:     return _type + " thumbstick r click";    break;
                case gp_padu:       return _type + " dpad up";               break;
                case gp_padd:       return _type + " dpad down";             break;
                case gp_padl:       return _type + " dpad left";             break;
                case gp_padr:       return _type + " dpad right"             break;
                
                case gp_axislh: return _axis_negative? _type + " thumbstick l left" : _type + " thumbstick l right"; break;
                case gp_axislv: return _axis_negative? _type + " thumbstick l up"   : _type + " thumbstick l down";  break;
                case gp_axisrh: return _axis_negative? _type + " thumbstick r left" : _type + " thumbstick r right"; break;
                case gp_axisrv: return _axis_negative? _type + " thumbstick r up"   : _type + " thumbstick r down";  break;
                
                default: return _type + " unknown"; break;
            }
        break;
        
        default:
            return "binding unknown";
        break;
    }
}
