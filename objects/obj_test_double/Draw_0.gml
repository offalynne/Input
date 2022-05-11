var _string = "";

_string += "(held) Confirm = " + string(input_check_double("accept")) + "\n";
_string += "(held) Cancel = " + string(input_check_double("cancel")) + "\n";
_string += "(held) [Confirm, Cancel] = " + string(input_check_double(["accept", "cancel"])) + "\n";
_string += "\n";

_string += "(pressed) Confirm = " + string(input_check_double_pressed("accept")) + "\n";
_string += "(pressed) Cancel = " + string(input_check_double_pressed("cancel")) + "\n";
_string += "(pressed) [Confirm, Cancel] = " + string(input_check_double_pressed(["accept", "cancel"])) + "\n";
_string += "\n";

_string += "(released) Confirm = " + string(input_check_double_released("accept")) + "\n";
_string += "(released) Cancel = " + string(input_check_double_released("cancel")) + "\n";
_string += "(released) [Confirm, Cancel] = " + string(input_check_double_released(["accept", "cancel"])) + "\n";
_string += "\n";

draw_text(10, 10, _string);