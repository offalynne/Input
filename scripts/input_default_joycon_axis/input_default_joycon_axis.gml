/// @param axis
/// @param negative
/// @param verb
/// @param [alternate]

function input_default_joycon_axis(_axis, _negative, _verb, _alternate = 0)
{
    if (INPUT_WARNING_DEPRECATED) __input_error("This function has been deprecated\n(Set INPUT_WARNING_DEPRECATED to <false> to ignore this warning)");
    
	__input_initialize();
    __input_verb_define(_verb);
	
    if (__INPUT_DEBUG) __input_trace("Setting default Joy-Con axis binding...");
    
    global.__input_gamepad_default_defined = true;
    
    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
    var _binding = new __input_class_binding();
    _binding.set_gamepad_axis(_axis, _negative);
    
    global.__input_default_player.set_binding("joycon", _verb, _alternate, _binding);
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
        var _binding = new __input_class_binding();
        _binding.set_gamepad_axis(_axis, _negative);
        
        global.__input_players[_p].set_binding("joycon", _verb, _alternate, _binding);
        
        ++_p;
    }
}