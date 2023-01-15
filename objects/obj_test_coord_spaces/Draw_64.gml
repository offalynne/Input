var _cursor_x = input_cursor_x(0, INPUT_COORD_SPACE.GUI);
var _cursor_y = input_cursor_y(0, INPUT_COORD_SPACE.GUI);

draw_line(display_get_gui_width()/2, display_get_gui_height()/2, _cursor_x, _cursor_y);
draw_triangle(_cursor_x, _cursor_y, _cursor_x - 10, _cursor_y + 20, _cursor_x + 10, _cursor_y + 20, true);