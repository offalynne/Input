/// @desc    Returns a generic, human-readable name for the binding
///          For a list of return values, please see https://www.jujuadams.com/Input/#/latest/Binding-Names
/// @param   binding

function input_binding_get_name(_binding)
{
    if (!input_value_is_binding(_binding)) return "not a binding";
    return _binding.__label;
}
