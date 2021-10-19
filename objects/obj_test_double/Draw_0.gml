var _string = "";

_string += "(held) Confirm = " + string(input_check_double(VERB.CONFIRM)) + "\n";
_string += "(held) Cancel = " + string(input_check_double(VERB.CANCEL)) + "\n";
_string += "(held) [Confirm, Cancel] = " + string(input_check_double([VERB.CONFIRM, VERB.CANCEL])) + "\n";
_string += "\n";

_string += "(pressed) Confirm = " + string(input_check_double_pressed(VERB.CONFIRM)) + "\n";
_string += "(pressed) Cancel = " + string(input_check_double_pressed(VERB.CANCEL)) + "\n";
_string += "(pressed) [Confirm, Cancel] = " + string(input_check_double_pressed([VERB.CONFIRM, VERB.CANCEL])) + "\n";
_string += "\n";

_string += "(released) Confirm = " + string(input_check_double_released(VERB.CONFIRM)) + "\n";
_string += "(released) Cancel = " + string(input_check_double_released(VERB.CANCEL)) + "\n";
_string += "(released) [Confirm, Cancel] = " + string(input_check_double_released([VERB.CONFIRM, VERB.CANCEL])) + "\n";
_string += "\n";

draw_text(10, 10, _string);