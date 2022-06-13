var _string = "";
_string += concat("Left  = ", input_binding_get_name(input_binding_get("left" )), "\n");
_string += concat("Right = ", input_binding_get_name(input_binding_get("right")), "\n");
_string += concat("Up    = ", input_binding_get_name(input_binding_get("up"   )), "\n");
_string += concat("Down  = ", input_binding_get_name(input_binding_get("down" )), "\n");
_string += "\n";
_string += concat("x = ", input_x("left", "right", "up", "down"), "\n");
_string += concat("y = ", input_y("left", "right", "up", "down"), "\n");
_string += concat("xy = ", input_xy("left", "right", "up", "down"), "\n");
_string += concat("direction = ", input_direction("left", "right", "up", "down"), "\n");
_string += concat("distance = ", input_distance("left", "right", "up", "down"), "\n");
draw_text(10, 10, _string);

var _x = room_width/2  + 200*input_x("left", "right", "up", "down");
var _y = room_height/2 + 200*input_y("left", "right", "up", "down");
draw_line(room_width/2, room_height/2, _x, _y);
draw_circle(_x, _y, 16, true);