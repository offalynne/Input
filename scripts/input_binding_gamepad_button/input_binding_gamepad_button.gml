// Feather disable all
/// @desc    Creates a gamepad button binding. This function accepts gp_* constants
/// @param   button

function input_binding_gamepad_button(_button)
{
    __input_initialize();
    
    if (__INPUT_ON_PS 
    && (_button == gp_touchpad))
    {
        _button = gp_select;
    }
    else if (!__INPUT_DIGITAL_TRIGGER
         && ((_button == gp_shoulderlb) || (_button == gp_shoulderrb)))
    {
        return (new __input_class_binding()).__set_gamepad_axis(_button, false);
    }
    
    return (new __input_class_binding()).__set_gamepad_button(_button);
}
