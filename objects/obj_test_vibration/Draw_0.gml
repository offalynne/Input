var _gamepad = input_player_get_gamepad();

var _string = "";
_string += "Vibration Test\n";
_string += "Gamepad = " + input_gamepad_get_description(_gamepad) + "\n";
_string += "\n";
_string += "gp_face1 = Constant event\n";
_string += "gp_face2 = ADSR event\n";
_string += "gp_face3 = Pulse event\n";
_string += "gp_face4 = Curve event\n";
_string += "\n";
_string += "gp_shoulderl = Resume\n";
_string += "gp_shoulderr = Pause\n";
_string += "\n";
_string += "gp_start = Stop vibration\n";

draw_text(10, 10, _string);