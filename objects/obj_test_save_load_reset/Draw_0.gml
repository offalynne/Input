var _string  = "Left  = " + string(input_value(VERB.LEFT )) + "    " + string(input_binding_get(VERB.LEFT )) + "\n";
    _string += "Right = " + string(input_value(VERB.RIGHT)) + "    " + string(input_binding_get(VERB.RIGHT)) + "\n";

_string += "\n";
_string += "Enter = Start rebinding\n";
_string += "S = Save\n";
_string += "L = Load\n";
_string += "R = Reset\n";

if (rebinding) _string += "\nREBINDING!";

draw_text(10, 10, _string);