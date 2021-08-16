/// @param binding

function input_binding_get_name(_binding)
{
    if (!input_value_is_binding(_binding)) return "binding unknown";
    return _binding.label;
}
