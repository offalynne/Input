/// @param key

function __input_key_is_ignored(_key)
{
    if (variable_struct_exists(global.__input_ignore_key_dict, _key)) return true;
    
    return false;
}