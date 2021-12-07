var _string = "";
_string += "x = " + string(input_x("left", "right", "up", "down", 0)) + "\n";
_string += "y = " + string(input_y("left", "right", "up", "down", 0)) + "\n";
_string += "\n";
_string += "x = " + string(input_x("left", "right", "up", "down", 1)) + "\n";
_string += "y = " + string(input_y("left", "right", "up", "down", 1)) + "\n";
_string += "\n";
_string += "x = " + string(input_x("left", "right", "up", "down", 2)) + "\n";
_string += "y = " + string(input_y("left", "right", "up", "down", 2)) + "\n";

draw_text(10, 10, _string);