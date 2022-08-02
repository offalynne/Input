/// @desc    Creates a null binding that can never be activated
/// @return {Struct.__input_class_binding}

function input_binding_empty()
{
	__input_initialize();
    
    return (new __input_class_binding());
}