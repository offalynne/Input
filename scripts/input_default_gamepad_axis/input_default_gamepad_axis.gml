/// @param axis
/// @param negative
/// @param verb
/// @param [alternate]

function input_default_gamepad_axis()
{
    var _axis      = argument[0];
    var _negative  = argument[1];
    var _verb      = argument[2];
    var _alternate = ((argument_count > 3) && (argument[3] != undefined))? argument[3] : 0;
    
    if (__INPUT_DEBUG) __input_trace("Setting default gamepad axis binding...");
    
    global.__input_gamepad_valid = true;
    
    global.__input_default_player.set_binding(INPUT_SOURCE.GAMEPAD, _verb, _alternate,
                                              new __input_class_binding("gamepad axis", _axis, _negative));
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].set_binding(INPUT_SOURCE.GAMEPAD, _verb, _alternate,
                                              new __input_class_binding("gamepad axis", _axis, _negative));
        ++_p;
    }
}