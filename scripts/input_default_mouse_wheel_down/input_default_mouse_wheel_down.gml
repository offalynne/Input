/// @param verb
/// @param [alternate]

function input_default_mouse_wheel_down()
{
    var _verb      = argument[0];
    var _alternate = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : 0;
    
    if (__INPUT_DEBUG) __input_trace("Setting default mouse wheel down binding...");
    
    global.__input_mouse_valid = true;
    
    global.__input_default_player.set_binding(INPUT_SOURCE.KEYBOARD_AND_MOUSE, _verb, _alternate,
                                              new __input_class_binding("mouse wheel down"));
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].set_binding(INPUT_SOURCE.KEYBOARD_AND_MOUSE, _verb, _alternate,
                                               new __input_class_binding("mouse wheel down"));
        ++_p;
    }
}