var _string = "";
_string += "gamepad = " + input_player_gamepad_get_type() + "\n";
_string += rebinding? "rebinding\n" : "\n";
_string += "test 1 = " + string(input_value("test 1")) + "\n";
_string += "test 2 = " + string(input_value("test 2")) + "\n";

draw_text(10, 10, _string);