var _string = "";

_string += "(held) Confirm = " + string(input_check_long("accept")) + "\n";
_string += "(held) Cancel = " + string(input_check_long("cancel")) + "\n";
_string += "(held) [Confirm, Cancel] = " + string(input_check_long(["accept", "cancel"])) + "\n";
_string += "(held time) Confirm = " + string(input_held_time("accept")) + "\n";
_string += "(held time) Cancel = " + string(input_held_time("cancel")) + "\n";
_string += "\n";

_string += "(pressed) Confirm = " + string(input_check_long_pressed("accept")) + "\n";
_string += "(pressed) Cancel = " + string(input_check_long_pressed("cancel")) + "\n";
_string += "(pressed) [Confirm, Cancel] = " + string(input_check_long_pressed(["accept", "cancel"])) + "\n";
_string += "\n";

_string += "(released) Confirm = " + string(input_check_long_released("accept")) + "\n";
_string += "(released) Cancel = " + string(input_check_long_released("cancel")) + "\n";
_string += "(released) [Confirm, Cancel] = " + string(input_check_long_released(["accept", "cancel"])) + "\n";
_string += "\n";

draw_text(10, 10, _string);