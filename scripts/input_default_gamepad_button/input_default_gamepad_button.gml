/// @param button
/// @param verb
/// @param [alternate]

function input_default_gamepad_button()
{
    var _button    = argument[0];
    var _verb      = argument[1];
    var _alternate = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 0;
    
    if (__INPUT_DEBUG) __input_trace("Setting default gamepad button binding...");
    
    global.__input_gamepad_valid = true;
    
    if (global.__input_swap_ab)
    {
        if (_button == gp_face1)
        {
            _button = gp_face2;
        }
        else if (_button == gp_face2)
        {
            _button = gp_face1;
        }
    }
    
    global.__input_default_player.set_binding(INPUT_SOURCE.GAMEPAD, _verb, _alternate,
                                              new __input_class_binding("gamepad button", _button));
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].set_binding(INPUT_SOURCE.GAMEPAD, _verb, _alternate,
                                               new __input_class_binding("gamepad button", _button));
        ++_p;
    }
}