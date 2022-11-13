if input_mouse_check_pressed(mb_left)
{
    input_mouse_capture_set(true);
}

if (input_keyboard_check_pressed(vk_escape) || !input_window_has_focus())
{
    input_mouse_capture_set(false);
}

var _mouse_x = input_mouse_x();
var _mouse_y = input_mouse_y();

draw_set_color(c_white);
var _cursor = cr_default;

if (!input_window_has_focus())
{
    draw_set_color(c_gray);
}
else if (input_mouse_in_bounds() && input_mouse_capture_get().capture)
{
    draw_triangle(_mouse_x, _mouse_y, _mouse_x - 10, _mouse_y + 20, _mouse_x + 10, _mouse_y + 20, true);
    _cursor = cr_none;
}

if (window_get_cursor() != _cursor)
{
    window_set_cursor(_cursor);
}

var _string =  "in bound = " + string(input_mouse_in_bounds()) + "\n";
_string += "locked   = " + string(input_mouse_capture_get().capture) + "\n";
_string += "mouse x  = " + string(_mouse_x) + "\n";
_string += "mouse y  = " + string(_mouse_y);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(10, 10, _string);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_line(room_width/2, room_height/2, input_cursor_x(), input_cursor_y());
draw_circle(input_cursor_x(), input_cursor_y(), 16, true);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(10, 110, "Gyro enabled = " + string(input_gyro_enabled_get()));

draw_text(10, 150, "Gyro params =");
draw_text(10, 170, string_replace_all(string(input_gyro_params_get()), ",", "\n"))

draw_text(10, 270, "Motion data =");
draw_text(10, 290, string_replace_all(string(input_motion_data_get()), ",", "\n"))

