var _device = InputPlayerGetDevice();

var _string = "";
_string += "Color Test\n";
_string += "Gamepad = " + InputDeviceGetDescription(_device) + "\n";
_string += "Color = " + string(InputColorGet()) + "\n";
_string += "\n";
_string += "gp_face1 = Red\n";
_string += "gp_face2 = Yellow\n";
_string += "gp_face3 = Lime\n";
_string += "gp_face4 = Blue\n";
_string += "\n";
_string += "gp_start = Reset\n";

draw_text(10, 10, _string);