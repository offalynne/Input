// Feather disable all
/// @desc    Creates a gamepad axis binding. This function accepts gp_* constants
///          The <negative> argument should be set to either <true> or <false> to control what direction
///          is anticipated from the gamepad axis e.g. thumbstick left is negative but thumbstick right
///          is positive. Gamepad triggers are always considered positively valued
/// @param   {Constant.GamepadAxis|Constant.GamepadButton} axis
/// @param   negative

function input_binding_gamepad_axis(_axis, _negative)
{
    __input_initialize();
    
    if (__INPUT_DIGITAL_TRIGGER
    && ((_axis == gp_shoulderlb) || (_axis == gp_shoulderrb)))
    {
        return (new __input_class_binding()).__set_gamepad_button(_axis);
    }
    
    return (new __input_class_binding()).__set_gamepad_axis(_axis, _negative);
}
