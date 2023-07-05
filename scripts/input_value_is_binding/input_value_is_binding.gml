/// @desc    Returns if the given value is a valid Input binding
/// @param   value

function input_value_is_binding(_value)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_global.__use_is_instanceof)
    {
        return (is_struct(_value) && (is_instanceof(_value, __InputClassBindingKey) || is_instanceof(_value, __InputClassBindingMouse) || is_instanceof(_value, __InputClassBindingGamepad)));
    }
    else
    {
        var _instanceOf = instanceof(_value);
        return (is_struct(_value) && ((_instanceOf == "__InputClassBindingKey") || (_instanceOf == "__InputClassBindingMouse") || (_instanceOf == "__InputClassBindingGamepad")));
    }
}