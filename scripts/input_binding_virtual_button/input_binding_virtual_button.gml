/// @desc    Creates a binding that a virtual button can be attached to

function input_binding_virtual_button()
{
    __INPUT_GLOBAL_STATIC
    
    return (new __input_class_binding()).__set_virtual_button();
}