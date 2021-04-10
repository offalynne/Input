if (!all_assigned)
{
    var _string = "";
    _string += "0 = " + string(input_player_gamepad_get(0)) + ", " + input_source_get_name(input_player_source_get(0)) + "\n";
    _string += "1 = " + string(input_player_gamepad_get(1)) + ", " + input_source_get_name(input_player_source_get(1)) + "\n";
    _string += "2 = " + string(input_player_gamepad_get(2)) + ", " + input_source_get_name(input_player_source_get(2)) + "\n";
}
else
{
    var _string = "";
    _string += "x = " + string(input_x(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 0)) + "\n";
    _string += "y = " + string(input_y(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 0)) + "\n";
    _string += "\n";
    _string += "x = " + string(input_x(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 1)) + "\n";
    _string += "y = " + string(input_y(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 1)) + "\n";
    _string += "\n";
    _string += "x = " + string(input_x(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 2)) + "\n";
    _string += "y = " + string(input_y(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 2)) + "\n";
}

draw_text(10, 10, _string);