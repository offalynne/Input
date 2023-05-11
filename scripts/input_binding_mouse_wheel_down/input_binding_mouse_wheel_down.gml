/// @desc    Creates a mouse wheel down binding

function input_binding_mouse_wheel_down()
{
    __input_initialize();
    return (new __input_class_binding()).__set_mouse_wheel_down();
}