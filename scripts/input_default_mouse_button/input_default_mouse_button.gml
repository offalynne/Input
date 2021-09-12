/// @param button
/// @param verb
/// @param [alternate]

function input_default_mouse_button(_button, _verb, _alternate = 0)
{
    if (__INPUT_DEBUG) __input_trace("Setting default mouse button binding...");
    
    //Disallow mouse bindings on console and touch platforms (unless explicitly enabled)
    if ((!__INPUT_TOUCH_SUPPORT || INPUT_TOUCH_MOUSE_ALLOWED) && (os_type != os_xboxone) && (os_type != os_xboxseriesxs))
    {
        global.__input_mouse_valid = true;
    }    
    
    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
    var _binding = new __input_class_binding();
    _binding.set_mouse_button(_button);
    
    global.__input_default_player.set_binding("keyboard and mouse", _verb, _alternate, _binding);
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
        var _binding = new __input_class_binding();
        _binding.set_mouse_button(_button);
        
        global.__input_players[_p].set_binding("keyboard and mouse", _verb, _alternate, _binding);
        ++_p;
    }
}