/// @desc    Adds a keyboard key to be ignored by Input
/// @param   key

function input_ignore_key_add(_key)
{
    //Fix uses of straight strings instead of ord("A") etc.
    if (is_string(_key)) _key = ord(string_upper(_key));
    
    if (_key == vk_anykey) __input_error("Cannot ignore vk_anykey (=", vk_anykey, ")");
    
    if (!variable_struct_exists(global.__input_ignore_key_dict, _key))
    {
        if (__INPUT_DEBUG) __input_trace("Ignoring keycode ", _key);
        global.__input_ignore_key_dict[$ _key] = true;
    }
    else
    {
        __input_trace("Could not ignore keycode ", _key, ", it is already ignored");
    }
}