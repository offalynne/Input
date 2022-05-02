/// @param axis
/// @param negative

function input_binding_gamepad_axis(_axis, _negative)
{
	__input_initialize();
    
    return (new __input_class_binding())__set_gamepad_axis(_axis, _negative);
}