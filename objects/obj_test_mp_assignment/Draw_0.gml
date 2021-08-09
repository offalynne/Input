var _string = "";

if (success)
{
    _string += "Source assignemnt complete\n\n";
}
else if (assigning)
{
    _string += "Assigning sources to players\n\n";
}
else
{
    _string += "Source assignment aborted\n\n";
}

_string += "0 = " + string(input_player_gamepad_get(0)) + ", " + input_source_get_name(input_player_source_get(0)) + "\n";
_string += "1 = " + string(input_player_gamepad_get(1)) + ", " + input_source_get_name(input_player_source_get(1)) + "\n";
_string += "2 = " + string(input_player_gamepad_get(2)) + ", " + input_source_get_name(input_player_source_get(2)) + "\n";
_string += "\n\n";
_string += "x = " + string(input_x(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 0)) + "\n";
_string += "y = " + string(input_y(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 0)) + "\n";
_string += "A = " + string(input_check(VERB.CONFIRM, 0)) + "\n";
_string += "\n";
_string += "x = " + string(input_x(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 1)) + "\n";
_string += "y = " + string(input_y(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 1)) + "\n";
_string += "A = " + string(input_check(VERB.CONFIRM, 1)) + "\n";
_string += "\n";
_string += "x = " + string(input_x(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 2)) + "\n";
_string += "y = " + string(input_y(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 2)) + "\n";
_string += "A = " + string(input_check(VERB.CONFIRM, 2)) + "\n";

draw_text(10, 10, _string);