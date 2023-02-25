var _string = "";
_string += "Platformer Example\n";
_string += "\n";
_string += input_verb_get_icon("left") + "/" + input_verb_get_icon("right") + " = Move\n";
_string += input_verb_get_icon("accept") + " = Jump\n";
_string += input_verb_get_icon("action") + " = Dash\n";
draw_text(10, 10, _string);