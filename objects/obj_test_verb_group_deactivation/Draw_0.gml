var _string = "";
_string += "\"general\" active = " + string(input_verb_group_is_active("general")) + "\n";
_string += "\n";
_string += "up = "     + string(input_check("up"    )) + "\n";
_string += "down = "   + string(input_check("down"  )) + "\n";
_string += "left = "   + string(input_check("left"  )) + "\n";
_string += "right = "  + string(input_check("right" )) + "\n";
_string += "accept = " + string(input_check("accept")) + "\n";
_string += "cancel = " + string(input_check("cancel")) + "\n";

draw_text(10, 10, _string);
