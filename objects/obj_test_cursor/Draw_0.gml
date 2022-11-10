if input_mouse_check_pressed(mb_left)       input_mouse_capture_set(true);
if input_keyboard_check_pressed(vk_escape)  input_mouse_capture_set(false);

var _mouse_x = input_mouse_x();
var _mouse_y = input_mouse_y();

draw_set_color(c_white);
var _cursor = cr_default;

if (!input_window_has_focus())
{
    draw_set_color(c_gray);
}
else if (input_mouse_in_bounds())
{
    draw_triangle(_mouse_x, _mouse_y, _mouse_x - 10, _mouse_y + 20, _mouse_x + 10, _mouse_y + 20, true);
    _cursor = cr_none;
}

if (window_get_cursor() != _cursor) window_set_cursor(_cursor);

var _string =  "in bound = " + string(input_mouse_in_bounds()) + "\n";
_string += "locked   = " + string(input_mouse_capture_get().capture) + "\n";
_string += "mouse x  = " + string(_mouse_x) + "\n";
_string += "mouse y  = " + string(_mouse_y);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(10, 10, _string);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _p = 0;
repeat(input_player_connected_count())
{
    draw_line(room_width/2, room_height/2, input_cursor_x(_p), input_cursor_y(_p));
    draw_circle(input_cursor_x(_p), input_cursor_y(_p), 16, true);
    draw_text(input_cursor_x(_p), input_cursor_y(_p), _p);

    ++_p;
}
