var _index = input_player_gamepad_get();

var _string = "";
_string += "player gamepad = " + string(_index) + "\n\n";
_string += "gp_face1 = " + string(input_gamepad_get_button_label(_index, gp_face1)) + ", " + string(input_gamepad_get_button_color(_index, gp_face1)) + "\n";
_string += "gp_face2 = " + string(input_gamepad_get_button_label(_index, gp_face2)) + ", " + string(input_gamepad_get_button_color(_index, gp_face2)) + "\n";
_string += "gp_face3 = " + string(input_gamepad_get_button_label(_index, gp_face3)) + ", " + string(input_gamepad_get_button_color(_index, gp_face3)) + "\n";
_string += "gp_face4 = " + string(input_gamepad_get_button_label(_index, gp_face4)) + ", " + string(input_gamepad_get_button_color(_index, gp_face4)) + "\n";

draw_text(10, 10, _string);