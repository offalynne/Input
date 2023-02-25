/// @desc    Creates a keyboard binding. This function accepts vk_* constants and single-letter strings e.g. "A"
/// @param   key

function input_binding_key(_key)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    return (new __input_class_binding()).__set_key(_key, false);
}