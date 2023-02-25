/// @desc    Creates a mouse wheel up binding

function input_binding_mouse_wheel_up()
{
    static _global = __input_state();
    
    return (new __input_class_binding()).__set_mouse_wheel_up();
}