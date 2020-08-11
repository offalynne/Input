/// @param button
/// @param verb
/// @param [alternate]

function input_default_gamepad_button()
{
    var _button    = argument[0];
    var _verb      = argument[1];
    var _alternate = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 0;
    
    global.__input_gamepad_valid = true;
    
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