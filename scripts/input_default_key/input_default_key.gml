/// @param key
/// @param verb
/// @param [alternate]

function input_default_key(_key, _verb, _alternate = 0)
{
	__input_initialize();
	
    if (__INPUT_DEBUG) __input_trace("Setting default keyboard binding...");
    
    //Set keyboard source validity
    if (!global.__input_keyboard_default_defined && global.__input_keyboard_allowed)
    {
        global.__input_keyboard_default_defined = true;
    }
    
    //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
    var _binding = new __input_class_binding();
    _binding.set_key(_key, false);
    
    global.__input_default_player.set_binding("keyboard and mouse", _verb, _alternate, _binding);
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
        var _binding = new __input_class_binding();
        _binding.set_key(_key, false);
        
        global.__input_players[_p].set_binding("keyboard and mouse", _verb, _alternate, _binding);
        
        ++_p;
    }
}