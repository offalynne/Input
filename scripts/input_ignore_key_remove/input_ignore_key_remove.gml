/// @desc    Removes a keyboard key from the ignore list, allowing it to be used
/// @param   key

function input_ignore_key_remove(_key)
{
    //Fix uses of straight strings instead of ord("A") etc.
    if (is_string(_key)) _key = ord(string_upper(_key));
    
    if (variable_struct_exists(global.__input_ignore_key_dict, _key))
    {
        if (__INPUT_DEBUG) __input_trace("Un-ignoring keycode ", _key);
        variable_struct_remove(global.__input_ignore_key_dict, _key);
    }
    else
    {
        __input_trace("Could not un-ignore keycode ", _key, ", it is already permitted");
    }
}