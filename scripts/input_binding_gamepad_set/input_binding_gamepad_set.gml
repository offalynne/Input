/// @param binding
/// @param gamepadIndex

function input_binding_gamepad_set(_binding, _gamepad_index)
{
	__input_initialize();
    
    if (!input_value_is_binding(_binding))
    {
        __input_error("Parameter is not a binding (typeof=", typeof(_binding), ")");
        return;
    }
    
    _binding.__gamepad_set(_gamepad_index);
}