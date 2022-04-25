/// @param value

function input_value_is_binding(_value)
{
    if (is_struct(_value)
    &&  variable_struct_exists(_value, "type")
    &&  variable_struct_exists(_value, "value")
    &&  variable_struct_exists(_value, "axis_negative")
    &&  variable_struct_exists(_value, "label")
    &&  variable_struct_exists(_value, "joycon"))
    {
        if (os_type == os_android)
        {
            return (variable_struct_exists(_value, "android_lowercase") && (variable_struct_names_count(_value) == 6));
        }
        else
        {
            return (variable_struct_names_count(_value) == 5);
        }
    }
    
    return false;
}