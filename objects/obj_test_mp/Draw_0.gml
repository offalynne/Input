var _string = "";
_string += "x = " + string(input_x(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 0)) + "\n";
_string += "y = " + string(input_y(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 0)) + "\n";
_string += "\n";
_string += "x = " + string(input_x(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 1)) + "\n";
_string += "y = " + string(input_y(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 1)) + "\n";
_string += "\n";
_string += "x = " + string(input_x(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 2)) + "\n";
_string += "y = " + string(input_y(VERB.LEFT, VERB.RIGHT, VERB.UP, VERB.DOWN, 2)) + "\n";

draw_text(10, 10, _string);