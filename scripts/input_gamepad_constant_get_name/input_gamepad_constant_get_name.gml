/// @param GMconstant

function input_gamepad_constant_get_name(_gm_constant)
{
    switch(_gm_constant)
    {
        case gp_face1:      return "gp_face1";
        case gp_face2:      return "gp_face2";
        case gp_face3:      return "gp_face3";
        case gp_face4:      return "gp_face4";
        case gp_padd:       return "gp_padd";
        case gp_padu:       return "gp_padu";
        case gp_padl:       return "gp_padl";
        case gp_padr:       return "gp_padr";
        case gp_shoulderl:  return "gp_shoulderl";
        case gp_shoulderr:  return "gp_shoulderr";
        case gp_shoulderlb: return "gp_shoulderlb";
        case gp_shoulderrb: return "gp_shoulderrb";
        case gp_axislh:     return "gp_axislh";
        case gp_axislv:     return "gp_axislv";
        case gp_axisrh:     return "gp_axisrh";
        case gp_axisrv:     return "gp_axisrv";
        case gp_start:      return "gp_start";
        case gp_select:     return "gp_select";
        case gp_stickl:     return "gp_stickl";
        case gp_stickr:     return "gp_stickr";
        case gp_guide:      return "gp_guide";
        case gp_misc1:      return "gp_misc1";
    }
    
    return "unknown";
}