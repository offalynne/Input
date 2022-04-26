/// @param key

function input_binding_key(_key)
{
	__input_initialize();
    
    return (new __input_class_binding()).__set_key(_key, false);
}