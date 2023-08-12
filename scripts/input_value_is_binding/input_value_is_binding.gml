// Feather disable all
/// @desc    Returns if the given value is a valid Input binding
/// @param   value

function input_value_is_binding(_value)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_global.__use_is_instanceof)
    {
        return (is_struct(_value) && is_instanceof(_value, __input_class_binding));
    }
    else
    {
        return (is_struct(_value) && (instanceof(_value) == "__input_class_binding"));
    }
}
