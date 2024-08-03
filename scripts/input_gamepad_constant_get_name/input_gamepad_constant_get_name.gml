// Feather disable all
/// @desc    Returns the human-readable name of the virtual button/axis constant
/// @param   {Constant.GamepadAxis|Constant.GamepadButton} GMconstant

function input_gamepad_constant_get_name(_gm_constant)
{
    switch(_gm_constant)
    {
        case gp_face1:       return "gp_face1";       break;
        case gp_face2:       return "gp_face2";       break;
        case gp_face3:       return "gp_face3";       break;
        case gp_face4:       return "gp_face4";       break;
        case gp_padd:        return "gp_padd";        break;
        case gp_padu:        return "gp_padu";        break;
        case gp_padl:        return "gp_padl";        break;
        case gp_padr:        return "gp_padr";        break;
        case gp_shoulderl:   return "gp_shoulderl";   break;
        case gp_shoulderr:   return "gp_shoulderr";   break;
        case gp_shoulderlb:  return "gp_shoulderlb";  break;
        case gp_shoulderrb:  return "gp_shoulderrb";  break;
        case gp_axislh:      return "gp_axislh";      break;
        case gp_axislv:      return "gp_axislv";      break;
        case gp_axisrh:      return "gp_axisrh";      break;
        case gp_axisrv:      return "gp_axisrv";      break;
        case gp_start:       return "gp_start";       break;
        case gp_select:      return "gp_select";      break;
        case gp_stickl:      return "gp_stickl";      break;
        case gp_stickr:      return "gp_stickr";      break;
        
        case gp_guide:     return "gp_guide";     break;
        case gp_misc1:     return "gp_misc1";     break;
        case gp_touchpad:  return "gp_touchpad";  break;
        case gp_paddle1:   return "gp_paddle1";   break;
        case gp_paddle2:   return "gp_paddle2";   break;
        case gp_paddle3:   return "gp_paddle3";   break;
        case gp_paddle4:   return "gp_paddle4";   break;
        
        default: return "unknown"; break;
    }
}
