/// @desc    Returns the target gamepad index for the binding. This is only relevant in the MULTIDEVICE source mode
///          If no target gamepad has been set for the binding then this function returns <undefined>
/// @param   binding

function input_binding_gamepad_get(_binding)
{
    __input_initialize();
    
    if (!input_value_is_binding(_binding))
    {
        __input_error("Parameter is not a binding (typeof=", typeof(_binding), ")");
        return;
    }
    
    return _binding.__gamepad_get();
}