// Feather disable all
/// @desc    Creates a mouse button binding. This function accepts mb_* constants
/// @param   button

function input_binding_mouse_button(_button)
{
    __input_initialize();
    return (new __input_class_binding()).__set_mouse_button(_button);
}
