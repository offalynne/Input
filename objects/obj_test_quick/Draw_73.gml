var _string = "";

_string += "Left = " + string(input_value("left")) + "\n";
_string += "Right = " + string(input_value("right")) + "\n";
_string += "2D = " + string(input_xy("left", "right", "up", "down")) + "\n";
_string += "\n";
_string += "(quick) Left = " + string(input_check_quick_pressed("left")) + "\n";
_string += "(quick) Right = " + string(input_check_quick_pressed("right")) + "\n";
_string += "(quick) [Left, Right] = " + string(input_check_quick_pressed(["left", "right"])) + "\n";
_string += "(quick) 2D = " + string(input_xy_quick_pressed("left", "right", "up", "down")) + "\n";
_string += "\n";

draw_text(10, 10, _string);
