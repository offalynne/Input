/// @desc    Creates a keyboard binding. This function accepts vk_* constants and single-letter strings e.g. "A"
/// @param   {Real, Constant.VirtualKey} _key
/// @returns {Struct.__input_class_binding}

function input_binding_key(_key)
{
	__input_initialize();
    
    return (new __input_class_binding()).__set_key(_key, false);
}