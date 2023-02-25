/// @desc    Creates a null binding that can never be activated

function input_binding_empty()
{
    __INPUT_GLOBAL_STATIC
    
    return (new __input_class_binding());
}