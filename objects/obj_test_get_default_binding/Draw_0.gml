var _string = "";

_string += string(input_binding_get_name(input_binding_get("left",  "default", 0, INPUT_AUTO_PROFILE_FOR_KEYBOARD))) + "\n";
_string += string(input_binding_get_name(input_binding_get("right", "default", 0, INPUT_AUTO_PROFILE_FOR_KEYBOARD))) + "\n";
_string += string(input_binding_get_name(input_binding_get("up",    "default", 0, INPUT_AUTO_PROFILE_FOR_KEYBOARD))) + "\n";
_string += string(input_binding_get_name(input_binding_get("down",  "default", 0, INPUT_AUTO_PROFILE_FOR_KEYBOARD))) + "\n";

draw_text(10, 10, _string);