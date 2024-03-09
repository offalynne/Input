var _string = "";
_string += concat("Left  = ", input_binding_get_name(input_binding_get("left" )), "\n");
_string += concat("Right = ", input_binding_get_name(input_binding_get("right")), "\n");
_string += concat("Up    = ", input_binding_get_name(input_binding_get("up"   )), "\n");
_string += concat("Down  = ", input_binding_get_name(input_binding_get("down" )), "\n");
_string += "\n";
_string += concat("chord a pressed  = ", input_check_pressed("chord a"), "\n");
_string += concat("chord a          = ", input_check("chord a"), "\n");
_string += concat("chord a released = ", input_check_released("chord a"), "\n");
_string += "\n";
_string += concat("chord b pressed  = ", input_check_pressed("chord b"), "\n");
_string += concat("chord b          = ", input_check("chord b"), "\n");
_string += concat("chord b released = ", input_check_released("chord b"), "\n");

draw_text(10, 10, _string);