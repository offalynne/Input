/// @desc    Returns if the given value is a valid Input binding
/// @param   {Struct.__input_class_binding} _value

function input_value_is_binding(_value)
{
    return (is_struct(_value) && (instanceof(_value) == "__input_class_binding"));
}