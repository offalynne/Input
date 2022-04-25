/// @param axis
/// @param negative

function input_binding_gamepad_axis(_axis, _negative)
{
	__input_initialize();
    
    if (__INPUT_DEBUG) __input_trace("Setting default gamepad axis binding...");
    
    global.__input_gamepad_default_defined = true;
    
    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
    var _binding = new __input_class_binding();
    _binding.set_gamepad_axis(_axis, _negative);
    
    return _binding;
}