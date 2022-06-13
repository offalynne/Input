var _string = "";

_string += "(held) Accept = " + string(input_check_double("accept")) + "\n";
_string += "(held) Cancel = " + string(input_check_double("cancel")) + "\n";
_string += "(held) [Accept, Cancel] = " + string(input_check_double(["accept", "cancel"])) + "\n";
_string += "\n";

_string += "(pressed) Accept = " + string(input_check_double_pressed("accept")) + "\n";
_string += "(pressed) Cancel = " + string(input_check_double_pressed("cancel")) + "\n";
_string += "(pressed) [Accept, Cancel] = " + string(input_check_double_pressed(["accept", "cancel"])) + "\n";
_string += "\n";

_string += "(released) Accept = " + string(input_check_double_released("accept")) + "\n";
_string += "(released) Cancel = " + string(input_check_double_released("cancel")) + "\n";
_string += "(released) [Accept, Cancel] = " + string(input_check_double_released(["accept", "cancel"])) + "\n";
_string += "\n";

draw_text(10, 10, _string);