function InputBinding(_constant)
{
    static _key_name_dict = __input_global().__key_name_dict;
    
    switch(_constant)
    {
        case mb_left:
        case mb_right:
        case mb_middle:
        case mb_side1:
        case mb_side2:
        case mb_wheel_up:
        case mb_wheel_down:
            return new __InputClassBindingMouse().__Set(_constant, true);
        break;
        
        case  gp_axislh:
        case  gp_axislv:
        case  gp_axisrh:
        case  gp_axisrv:
        case  gp_shoulderl:
        case  gp_shoulderr:
        case  gp_shoulderlb:
        case  gp_shoulderrb:
        case  gp_padu:
        case  gp_padd:
        case  gp_padl:
        case  gp_padr:
        case  gp_face1:
        case  gp_face2:
        case  gp_face3:
        case  gp_face4:
        case  gp_stickl:
        case  gp_stickr:
        case  gp_select:
        case  gp_start:
        case  gp_guide:
        case  gp_misc1:
        case  gp_touchpad:
        case  gp_paddle1:
        case  gp_paddle2:
        case  gp_paddle3:
        case  gp_paddle4:
        case -gp_axislh:
        case -gp_axislv:
        case -gp_axisrh:
        case -gp_axisrv:
        case -gp_shoulderl:
        case -gp_shoulderr:
        case -gp_shoulderlb:
        case -gp_shoulderrb:
        case -gp_padu:
        case -gp_padd:
        case -gp_padl:
        case -gp_padr:
        case -gp_face1:
        case -gp_face2:
        case -gp_face3:
        case -gp_face4:
        case -gp_stickl:
        case -gp_stickr:
        case -gp_select:
        case -gp_start:
        case -gp_guide:
        case -gp_misc1:
        case -gp_touchpad:
        case -gp_paddle1:
        case -gp_paddle2:
        case -gp_paddle3:
        case -gp_paddle4:
            return new __InputClassBindingGamepad().__Set(_constant, true);
        break;
        
        case mb_any:
            __input_error("mb_any is not supported as a binding");
        break;
        
        case mb_none:
            __input_error("mb_none is not supported as a binding");
        break;
        
        default:
            if (is_string(_constant))
            {
                if (string_length(_constant) == 1)
                {
                    return new __InputClassBindingKey().__Set(_constant, true);
                }
                else
                {
                    __input_error("Keyboard keys must be defined using a single character");
                }
            }
            else if (is_numeric(_constant))
            {
                return new __InputClassBindingKey().__Set(_constant, true);
            }
            else
            {
                __input_error("Binding datatype ", typeof(_constant), " unsupported");
            }
        break;
    }
}