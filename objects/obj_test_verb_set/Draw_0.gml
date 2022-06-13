var _string = "";
_string += "Verb   State  Binding \n"; 
_string += concat("Left   ", input_check_pressed("left" ), " ", max(0, input_held_time("left" )) mod 10, " ", input_check_released("left" ), "  ", input_binding_get_name(input_binding_get("left" )), "\n");
_string += concat("Right  ", input_check_pressed("right"), " ", max(0, input_held_time("right")) mod 10, " ", input_check_released("right"), "  ", input_binding_get_name(input_binding_get("right")), "\n");
_string += concat("Up     ", input_check_pressed("up"   ), " ", max(0, input_held_time("up"   )) mod 10, " ", input_check_released("up"   ), "  ", input_binding_get_name(input_binding_get("up"   )), "\n");
_string += concat("Down   ", input_check_pressed("down" ), " ", max(0, input_held_time("down" )) mod 10, " ", input_check_released("down" ), "  ", input_binding_get_name(input_binding_get("down" )), "\n");
draw_text(10, 10, _string);