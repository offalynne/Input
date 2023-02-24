/// @desc    Creates a gamepad axis binding. This function accepts gp_* constants
///          The <negative> argument should be set to either <true> or <false> to control what direction
///          is anticipated from the gamepad axis e.g. thumbstick left is negative but thumbstick right
///          is positive. Gamepad triggers are always considered positively valued
/// @param   axis
/// @param   negative

function input_binding_gamepad_axis(_axis, _negative)
{
    __input_initialize();
    
    return (new __input_class_binding()).__set_gamepad_axis(_axis, _negative);
}