/// @desc    Creates a mouse wheel up binding
/// @returns {Struct.__input_class_binding}

function input_binding_mouse_wheel_up()
{
	__input_initialize();
    
    return (new __input_class_binding()).__set_mouse_wheel_up();
}