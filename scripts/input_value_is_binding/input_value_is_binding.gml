/// @param value

function input_value_is_binding(_value)
{
    return (is_struct(_value)
         && variable_struct_exists(_value, "type")
         && variable_struct_exists(_value, "value")
         && variable_struct_exists(_value, "axis_negative")
         && (variable_struct_names_count(_value) == 3));
}