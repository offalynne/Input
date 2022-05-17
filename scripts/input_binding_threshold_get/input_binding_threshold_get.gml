/// @param binding

function input_binding_threshold_get(_binding)
{
	__input_initialize();
    
    if (!input_value_is_binding(_binding))
    {
        __input_error("Parameter is not a binding (typeof=", typeof(_binding), ")");
        return;
    }
    
    return _binding.__threshold_get();
}