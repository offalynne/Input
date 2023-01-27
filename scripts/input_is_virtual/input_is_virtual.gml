/// @desc    Returns if the given value is a virtual button
/// 
/// @param   value

function input_virtual_exists(_value)
{
    if (!is_struct(_value)) return false;
    return !_value.__destroyed;
}