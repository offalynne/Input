/// @desc    Returns if the given value is a virtual button
/// 
/// @param   value

function input_is_virtual(_value)
{
    if (!is_struct(_value)) return false;
    return !_value.__destroyed;
}