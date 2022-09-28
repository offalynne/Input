var _string  = "Left  = " + string(input_value("left" )) + "    " + string(input_binding_get("left" )) + "    " + string(input_binding_get_name(input_binding_get("left" ))) + "\n";
    _string += "Right = " + string(input_value("right")) + "    " + string(input_binding_get("right")) + "    " + string(input_binding_get_name(input_binding_get("right"))) + "\n";

_string += "\n";
_string += "Enter = Start rebinding\n";
_string += "C = Clear Binding\n";
_string += "S = Save\n";
_string += "L = Load\n";
_string += "R = Reset\n";

if (input_binding_scan_in_progress()) _string += "\nREBINDING!";

draw_text(10, 10, _string);