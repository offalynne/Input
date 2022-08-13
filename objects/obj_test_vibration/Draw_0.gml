var _gamepad = input_player_get_gamepad();

var _string = "";
_string += "Vibration Test\n";
_string += "Gamepad = " + input_gamepad_get_description(_gamepad) + "\n";
_string += "\n";
_string += "gp_face1 = Constant event";
_string += "gp_face2 = ADSR event";
_string += "gp_face3 = Pulse event";
_string += "gp_face4 = Curve event";

draw_text(10, 10, _string);