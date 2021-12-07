/// @param verb
/// @param [alternate]

function input_default_mouse_wheel_up(_verb, _alternate = 0)
{
	__input_initialize();
	
    if (__INPUT_DEBUG) __input_trace("Setting default mouse wheel up binding...");
    
    if (global.__input_mouse_allowed) 
    {
        global.__input_mouse_default_defined = true;
    }
    
    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
    var _binding = new __input_class_binding();
    _binding.set_mouse_wheel_up();
    
    global.__input_default_player.set_binding("keyboard and mouse", _verb, _alternate, _binding);
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
        var _binding = new __input_class_binding();
        _binding.set_mouse_wheel_up();
        
        global.__input_players[_p].set_binding("keyboard and mouse", _verb, _alternate, _binding);
        ++_p;
    }
}