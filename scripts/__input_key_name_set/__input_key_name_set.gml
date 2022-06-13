/// @param key
/// @param name

function __input_key_name_set(_key, _name)
{
    global.__input_key_name_dict[$ string(_key)] = string(_name);
}