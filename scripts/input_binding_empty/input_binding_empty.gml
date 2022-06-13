/// @desc    Creates a null binding that can never be activated

function input_binding_empty()
{
	__input_initialize();
    
    return (new __input_class_binding());
}