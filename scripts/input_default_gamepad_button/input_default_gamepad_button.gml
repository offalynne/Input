/// @param button
/// @param verb
/// @param [alternate]

function input_default_gamepad_button()
{
    var _button    = argument[0];
    var _verb      = argument[1];
    var _alternate = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 0;
    
    if (__INPUT_DEBUG) __input_trace("Setting default gamepad button binding...");
    if (!INPUT_SDL2_ALLOW_GUIDE && (_button == gp_guide)) __input_error("gp_guide not permitted\nSet INPUT_SDL2_ALLOW_GUIDE to <true> to allow gp_guide");
    if (!INPUT_SDL2_ALLOW_MISC1 && (_button == gp_misc1)) __input_error("gp_misc1 not permitted\nSet INPUT_SDL2_ALLOW_MISC1 to <true> to allow gp_misc1");
    
    global.__input_gamepad_valid = true;
    
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