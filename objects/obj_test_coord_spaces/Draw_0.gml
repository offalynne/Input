draw_clear(c_dkgrey);

var _mouse_x  = input_mouse_x();
var _mouse_y  = input_mouse_y();
var _cursor_x = input_cursor_x(0, INPUT_COORD_SPACE.ROOM);
var _cursor_y = input_cursor_y(0, INPUT_COORD_SPACE.ROOM);

var _string = "";
_string += "coord space = " + string(coord_space) + "\n";
_string += "\n";
_string += "mouse x     = " + string(_mouse_x) + "\n";
_string += "mouse y     = " + string(_mouse_y) + "\n";
_string += "\n";
_string += "cursor x    = " + string(_cursor_x) + "\n";
_string += "cursor y    = " + string(_cursor_y) + "\n";

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(10, 10, _string);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_line(room_width/2, room_height/2, _cursor_x, _cursor_y);
draw_circle(_cursor_x, _cursor_y, 16, true);