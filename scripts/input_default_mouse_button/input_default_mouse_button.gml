/// @param button
/// @param verb
/// @param [alternate]

function input_default_mouse_button()
{
    var _button    = argument[0];
    var _verb      = argument[1];
    var _alternate = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 0;
    
    if (__INPUT_DEBUG) __input_trace("Setting default mouse button binding...");
    
    global.__input_mouse_valid = true;
    
    global.__input_default_player.set_binding(INPUT_SOURCE.KEYBOARD_AND_MOUSE, _verb, _alternate,
                                              new __input_class_binding("mouse button", _button));
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].set_binding(INPUT_SOURCE.KEYBOARD_AND_MOUSE, _verb, _alternate,
                                              new __input_class_binding("mouse button", _button));
        ++_p;
    }
}