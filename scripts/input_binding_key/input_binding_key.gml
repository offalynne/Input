/// @param key

function input_binding_key(_key)
{
	__input_initialize();
	
    //Set keyboard source validity
    if (!global.__input_keyboard_default_defined && global.__input_keyboard_allowed)
    {
        global.__input_keyboard_default_defined = true;
    }
    
    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
    var _binding = new __input_class_binding();
    _binding.set_key(_key, false);
    
    return _binding;
}