var _string = "";

_string += "Player active = " + string(input_player_active_get()) + "\n";
_string += "Accept = " + string(input_check("accept")) + " " + input_verb_get_icon("accept") + "\n";
_string += "Cancel = " + string(input_check("cancel")) + " " + input_verb_get_icon("cancel") + "\n";
_string += "\n";

draw_text(10, 10, _string);