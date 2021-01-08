/// @param key
/// @param verb
/// @param [alternate]

function input_default_key()
{
    var _key       = argument[0];
    var _verb      = argument[1];
    var _alternate = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 0;
    
    if (__INPUT_DEBUG) __input_trace("Setting default keyboard binding...");
    
    //Fix uses of straight strings instead of ord("A") etc.
    if (is_string(_key)) _key = ord(string_upper(_key));
    
    global.__input_keyboard_valid = true;
    
    global.__input_default_player.set_binding(INPUT_SOURCE.KEYBOARD_AND_MOUSE, _verb, _alternate,
                                              new __input_class_binding("key", _key));
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].set_binding(INPUT_SOURCE.KEYBOARD_AND_MOUSE, _verb, _alternate,
                                              new __input_class_binding("key", _key));
        ++_p;
    }
}