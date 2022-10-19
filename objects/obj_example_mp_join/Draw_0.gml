var _string = "";
_string += "Multiplayer Example\n";
_string += "\n";

if (!input_player_connected(0))
{
    _string += "Player 1: Press any key/button to join\n";
    _string += "\n";
    _string += "\n";
    _string += "Player 2: Please wait...\n";
    _string += "\n";
    _string += "\n";
}
else
{
    _string += "Player 1: Joined (press " + input_binding_get_icon(input_binding_get("cancel", 0), 0) + " to leave)\n";
    _string += "Using " + (input_source_using(INPUT_GAMEPAD, 0)? input_gamepad_get_description(input_player_get_gamepad(0)) : "keyboard + mouse") + "\n";
    _string += "\n";
    
    if (!input_player_connected(1))
    {
        _string += "Player 2: Press any key/button to join\n";
        _string += "\n";
        _string += "\n";
    }
    else
    {
        _string += "Player 2: Joined (press " + input_binding_get_icon(input_binding_get("cancel", 1), 1) + " to leave)\n";
        _string += "Using " + (input_source_using(INPUT_GAMEPAD, 1)? input_gamepad_get_description(input_player_get_gamepad(1)) : "keyboard + mouse") + "\n";
        _string += "\n";
    }
}

if (input_multiplayer_is_finished())
{
    _string += "\n";
    _string += "Player 1: Please press and hold \"" + input_binding_get_icon(input_binding_get("action")) + "\" to play\n";
}

draw_text(10, 10, _string);