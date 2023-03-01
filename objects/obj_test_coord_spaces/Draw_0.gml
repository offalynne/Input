draw_clear(c_dkgrey);
draw_set_font(fnt_debug);

var _mouse_x   = device_mouse_x(0);
var _mouse_y   = device_mouse_y(0);
var _cursor_x  = input_cursor_x(0, INPUT_COORD_SPACE.ROOM);
var _cursor_y  = input_cursor_y(0, INPUT_COORD_SPACE.ROOM);

var _string = "";
_string += "cursor coord space = " + string(input_cursor_coord_space_get()) + "\n";
_string += "mouse coord space = " + string(input_mouse_coord_space_get()) + "\n";
_string += "\n";
_string += "mouse x     = " + string(_mouse_x) + "\n";
_string += "mouse y     = " + string(_mouse_y) + "\n";
_string += "\n";
_string += "cursor x    = " + string(_cursor_x) + "\n";
_string += "cursor y    = " + string(_cursor_y) + "\n";
_string += "\n";
_string += "view width  = " + string(camera_get_view_width( camera_get_active())) + "\n";
_string += "view height = " + string(camera_get_view_height(camera_get_active())) + "\n";

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(10, 10, _string);

return;

draw_line(room_width/2, room_height/2, _cursor_x, _cursor_y);
draw_circle(_cursor_x, _cursor_y, 16, true);

draw_rectangle(_mouse_x-5, _mouse_y-5, _mouse_x+5, _mouse_y+5, true);