var _string = "";
_string += string(input_source_get_array()) + "\n";
_string += input_binding_get_name(input_binding_get(0)) + " = " + string(input_value(0)) + "\n";
_string += input_binding_get_name(input_binding_get(1)) + " = " + string(input_value(1)) + "\n";
_string += input_binding_get_name(input_binding_get(2)) + " = " + string(input_value(2)) + "\n";
_string += input_binding_get_name(input_binding_get(3)) + " = " + string(input_value(3)) + "\n";
_string += input_binding_get_name(input_binding_get(4)) + " = " + string(input_value(4)) + "\n";
_string += input_binding_get_name(input_binding_get(5)) + " = " + string(input_value(5)) + "\n";
_string += input_binding_get_name(input_binding_get(6)) + " = " + string(input_value(6)) + "\n";
_string += input_binding_get_name(input_binding_get(7)) + " = " + string(input_value(7)) + "\n";
_string += input_binding_get_name(input_binding_get(8)) + " = " + string(input_value(8)) + "\n";
_string += input_binding_get_name(input_binding_get(9)) + " = " + string(input_value(9)) + "\n";

draw_text(10, 10, _string);