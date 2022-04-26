/// @param value

function input_value_is_binding(_value)
{
    return (is_struct(_value) && (instanceof(_value) == "__input_class_binding"));
}