/// @param axis
/// @param negative

function input_binding_joycon_axis(_axis, _negative)
{
	__input_initialize();
    
    global.__input_gamepad_default_defined = true;
    
    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
    var _binding = new __input_class_binding();
    _binding.set_gamepad_axis(_axis, _negative);
    _binding.joycon = true;
    
    return _binding;
}
