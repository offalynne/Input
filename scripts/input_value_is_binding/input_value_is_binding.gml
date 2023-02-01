/// @desc    Returns if the given value is a valid Input binding
/// @param   value

function input_value_is_binding(_value)
{
    if (global.__input_use_is_instanceof)
    {
        return (is_struct(_value) && is_instanceof(_value, __input_class_binding));
    }
    else
    {
        return (is_struct(_value) && (instanceof(_value) == "__input_class_binding"));
    }
}