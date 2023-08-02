// Feather disable all
/// @desc    Sets the specific analogue activation threshold for this binding
///          This overrides the activation threshold set by input_axis_threshold_set()
/// @param   binding
/// @param   min
/// @param   max

function input_binding_threshold_set(_binding, _min, _max)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (!input_value_is_binding(_binding))
    {
        __input_error("Parameter is not a binding (typeof=", typeof(_binding), ")");
        return;
    }
    
    _binding.__threshold_set(_min, _max);
}
