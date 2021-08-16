draw_set_halign(fa_right);
draw_text(room_width - 10, 10, string(string_length(keyboard_string)));
draw_text(room_width - 10, 30, "\"" + keyboard_string    + "\" keyboard_string   ");
draw_text(room_width - 10, 50, "\"" + input_string_get() + "\" input_string_get()");

draw_set_halign(fa_center);
draw_text(room_width*.25, 200, "Set Direct");
draw_text(room_width*.50, 200, "Clear"     );
draw_text(room_width*.75, 200, "Set Async" );