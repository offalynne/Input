// Feather disable all
/// @desc    Creates a mouse wheel up binding

function input_binding_mouse_wheel_up()
{
    __input_initialize();
    return (new __input_class_binding()).__set_mouse_wheel_up();
}
