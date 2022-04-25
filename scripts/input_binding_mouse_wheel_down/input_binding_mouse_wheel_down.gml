function input_binding_mouse_wheel_down()
{
	__input_initialize();
	
    if (global.__input_mouse_allowed)
    {
        global.__input_mouse_default_defined = true;
    }
    
    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
    var _binding = new __input_class_binding();
    _binding.set_mouse_wheel_down();
    
    return _binding;
}