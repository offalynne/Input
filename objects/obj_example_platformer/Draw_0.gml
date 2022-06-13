var _string = "";
_string += "Platformer Example\n";
_string += "\n";
_string += input_binding_get_icon(input_binding_get("left")) + "/" + input_binding_get_icon(input_binding_get("right")) + " = Move\n";
_string += input_binding_get_icon(input_binding_get("accept")) + " = Jump\n";
_string += input_binding_get_icon(input_binding_get("action")) + " = Dash\n";
draw_text(10, 10, _string);