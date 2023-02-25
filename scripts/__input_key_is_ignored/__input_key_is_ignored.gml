/// @param key

function __input_key_is_ignored(_key)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    return variable_struct_exists(_global.__ignore_key_dict, _key);
}