/// @param button
/// @param verb
/// @param [alternate]

function input_default_gamepad_button(_button, _verb, _alternate = 0)
{
	__input_initialize();
	
    if (__INPUT_DEBUG) __input_trace("Setting default gamepad button binding...");
    
    if (!INPUT_SDL2_ALLOW_EXTENDED 
    && ((_button >= gp_guide) && (_button <= gp_paddle4)))
    {
        __input_error("Extended gamepad binding not permitted\nSet INPUT_SDL2_ALLOW_EXTENDED to <true> to allow binding of extended buttons.");
    }
    else
    {
        if (__INPUT_ON_PS && (_button == gp_touchpad))
        {
            _button = gp_select;
        }
    }
    
    global.__input_gamepad_default_defined = true;
    
    if (global.__input_swap_ab)
    {
        if (_button == gp_face1)
        {
            _button = gp_face2;
            __input_trace("Default binding for \"", _verb, "\" swapped from A/O to B/X");
        }
        else if (_button == gp_face2)
        {
            _button = gp_face1;
            __input_trace("Default binding for \"", _verb, "\" swapped from B/X to A/O");
        }
    }
    
    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
    var _binding = new __input_class_binding();
    _binding.set_gamepad_button(_button);
    
    global.__input_default_player.set_binding("gamepad", _verb, _alternate, _binding);
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
        var _binding = new __input_class_binding();
        _binding.set_gamepad_button(_button);
        
        global.__input_players[_p].set_binding("gamepad", _verb, _alternate, _binding);
        ++_p;
    }
}