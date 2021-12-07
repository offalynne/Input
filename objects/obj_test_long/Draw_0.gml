var _string = "";

_string += "(held) Confirm = " + string(input_check_long("confirm")) + "\n";
_string += "(held) Cancel = " + string(input_check_long("cancel")) + "\n";
_string += "(held) [Confirm, Cancel] = " + string(input_check_long(["confirm", "cancel"])) + "\n";
_string += "\n";

_string += "(pressed) Confirm = " + string(input_check_long_pressed("confirm")) + "\n";
_string += "(pressed) Cancel = " + string(input_check_long_pressed("cancel")) + "\n";
_string += "(pressed) [Confirm, Cancel] = " + string(input_check_long_pressed(["confirm", "cancel"])) + "\n";
_string += "\n";

_string += "(released) Confirm = " + string(input_check_long_released("confirm")) + "\n";
_string += "(released) Cancel = " + string(input_check_long_released("cancel")) + "\n";
_string += "(released) [Confirm, Cancel] = " + string(input_check_long_released(["confirm", "cancel"])) + "\n";
_string += "\n";

draw_text(10, 10, _string);