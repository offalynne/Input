var _device = InputPlayerGetDevice();

var _string = "";
_string += "Vibration Test\n";
_string += "Gamepad = " + InputDeviceGetDescription(_device) + "\n";
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