var _string = "";
_string += "gamepad = " + input_player_get_gamepad_type() + "\n\n";

var _array = input_gamepad_get_map(input_player_get_gamepad());
var _i = 0;
repeat(array_length(_array))
{
    _string += input_gamepad_constant_get_name(_array[_i]) + "\n";
    ++_i;
}

draw_text(10, 10, _string);