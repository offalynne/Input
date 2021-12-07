var _string = "";
_string += "Left  = " + string(input_binding_get_name(input_binding_get("left" ))) + "\n";
_string += "Right = " + string(input_binding_get_name(input_binding_get("right"))) + "\n";
_string += "Up    = " + string(input_binding_get_name(input_binding_get("up"   ))) + "\n";
_string += "Down  = " + string(input_binding_get_name(input_binding_get("down" ))) + "\n";
_string += "\n";
_string += "x = " + string(input_x("left", "right", "up", "down")) + "\n";
_string += "y = " + string(input_y("left", "right", "up", "down")) + "\n";
_string += "xy = " + string(input_xy("left", "right", "up", "down")) + "\n";
_string += "direction = " + string(input_direction("left", "right", "up", "down")) + "\n";
_string += "distance = " + string(input_distance("left", "right", "up", "down")) + "\n";

draw_text(10, 10, _string);