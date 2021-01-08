var _string = "";
_string += "Pressed  = " + string(input_check_pressed(VERB.DOWN)) + "\n";
_string += "Held     = " + string(input_check(VERB.DOWN)) + "\n";
_string += "Released = " + string(input_check_released(VERB.DOWN)) + "\n";
_string += "Double P = " + string(input_check_double_pressed(VERB.DOWN)) + "\n";
_string += "Double H = " + string(input_check_double(VERB.DOWN)) + "\n";
_string += "Double R = " + string(input_check_double_released(VERB.DOWN)) + "\n";

draw_text(10, 10, _string);