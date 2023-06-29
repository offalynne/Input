/// @desc    Creates a gamepad button binding. This function accepts gp_* constants
/// @param   button

function input_binding_gamepad_button(_button)
{
    __input_initialize();
    
    if (!INPUT_SDL2_ALLOW_EXTENDED 
    && ((_button >= gp_guide) && (_button <= gp_paddle4)))
    {
        __input_error("Extended gamepad binding not permitted\nSet INPUT_SDL2_ALLOW_EXTENDED to <true> to allow binding of extended buttons.");
    }
    else if (__INPUT_ON_PS 
         && (_button == gp_touchpad))
    {
        _button = gp_select;
    }
    else if (!__INPUT_ON_SWITCH
         && ((_button == gp_shoulderlb) || (_button == gp_shoulderrb)))
    {
        return (new __input_class_binding()).__set_gamepad_axis(_button, false);
    }
    
    return (new __input_class_binding()).__set_gamepad_button(_button);
}